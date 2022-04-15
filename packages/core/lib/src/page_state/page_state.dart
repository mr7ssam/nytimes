import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'page_state.freezed.dart';

@freezed
class PageState<T> with _$PageState<T> {
  const factory PageState.init() = _init<T>;

  const factory PageState.loading() = _Lodaing<T>;

  const factory PageState.loaded({required T data}) = _Loaded<T>;

  const factory PageState.empty() = _Empty<T>;

  const factory PageState.error({required String error}) = _Error<T>;
}

extension PageStateEx<T> on PageState<T> {
  bool get isLoading => this is _Lodaing;

  bool get isLoaded => this is _Loaded;

  bool get isEmpty => this is _Empty;

  bool get isError => this is _Error;

  T get data => (this as _Loaded).data;

  String get error => (this as _Error).error;
}

class PageStateBuilder<T> extends StatelessWidget {
  const PageStateBuilder({
    Key? key,
    required this.state,
    this.init,
    required this.success,
    this.loading,
    this.error,
  }) : super(key: key);

  final PageState<T> state;
  final Widget Function()? init;
  final Widget Function()? loading;
  final Widget Function(T data) success;
  final Widget Function(String message)? error;

  @override
  Widget build(BuildContext context) {
    late final Widget next;
    state.maybeWhen(
      orElse: () => next = const SizedBox(),
      init: () => next = init?.call() ?? const SizedBox(),
      loading: () => next =
          Center(child: loading?.call() ?? const CircularProgressIndicator()),
      loaded: (T data) => next = success(data),
      error: (message) =>
          next = Center(child: error?.call(message) ?? Text(message)),
    );
    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: KeyedSubtree(key: ValueKey(state), child: next));
  }
}
