import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:network/api_result.dart';
import 'package:shimmer/shimmer.dart';

import '../theme/const.dart';

enum CustomChipSelectType {
  list,
  wrap,
}

class CustomChipSelect<T> extends StatefulWidget {
  final List<T> items;
  final String Function(T item) itemAsString;
  final ValueChanged<T>? onChanged;
  final T selected;
  final CustomChipSelectType type;
  final bool allSelected;
  final Future<ApiResult<List<T>>> Function()? asyncItems;
  final EdgeInsets? padding;

  const CustomChipSelect({
    Key? key,
    this.items = const [],
    required this.onChanged,
    required this.itemAsString,
    required this.selected,
    this.type = CustomChipSelectType.wrap,
    this.allSelected = false,
    this.padding,
    this.asyncItems,
  }) : super(key: key);

  @override
  State<CustomChipSelect> createState() => _CustomChipSelectState<T>();
}

class _CustomChipSelectState<T> extends State<CustomChipSelect<T>> {
  late T _selectedItem;
  Future<ApiResult<List<T>>> Function()? _asyncItems;

  @override
  void initState() {
    _selectedItem = widget.selected;
    super.initState();
  }

  RSizedBox _separatorBuilder() => const RSizedBox.horizontal(8);

  Widget _asyncBuilder(AsyncSnapshot<ApiResult<List<T>>> snapshot) {
    if (snapshot.hasData) {
      var data = snapshot.data!;
      if (data.isSuccess) {
        return _build(data.data);
      } else {
        return Text(data.message);
      }
    } else if (snapshot.hasError) {
      return Text(snapshot.error.toString());
    }
    return _shimmerLoading();
  }

  RSizedBox _shimmerLoading() {
    return RSizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => _separatorBuilder(),
        padding: PEdgeInsets.horizontal,
        itemBuilder: (_, __) => Shimmer.fromColors(
          period: const Duration(milliseconds: 700),
          highlightColor: Colors.grey.shade400,
          baseColor: Colors.grey,
          child: FilterChip(
            onSelected: (value) {},
            label: RSizedBox(
              width: Random().nextInt(20) + 25,
            ),
          ),
        ),
        itemCount: 5,
      ),
    );
  }

  RenderObjectWidget _build(List<T> items) {
    if (widget.type == CustomChipSelectType.list) {
      return RSizedBox(
        height: 50,
        child: ListView.separated(
          padding: PEdgeInsets.horizontal,
          itemCount: itemsCount(items),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (_, __) => _separatorBuilder(),
          itemBuilder: (context, index) {
            return _buildFilterChips(index, items);
          },
        ),
      );
    }
    return Wrap(
      spacing: 8.r,
      runSpacing: 8.r,
      children: List.generate(
          items.length, (index) => _buildFilterChips(index, items)),
    );
  }

  int itemsCount(List<T> items) => (items.length);

  Widget _buildFilterChips(int index, List<T> items) {
    final item = items[index];
    final selected = _selectedItem == item;
    return ChoiceChip(
      selected: selected,
      onSelected: (value) {
        _selectedItem = item;
        widget.onChanged?.call(item);
        setState(() {});
      },
      label: Text(
        widget.itemAsString(
          item,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.asyncItems != null) {
      _asyncItems ??= widget.asyncItems;
      return FutureBuilder<ApiResult<List<T>>>(
        future: _asyncItems!(),
        builder: (context, snapshot) {
          return _asyncBuilder(snapshot);
        },
      );
    }
    return _build(widget.items);
  }
}
