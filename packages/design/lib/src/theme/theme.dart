import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'colors.dart';
import 'const.dart';
import 'typo.dart';

final kButtonPadding = REdgeInsets.all(LayoutConstrains.m1);
final kChipPadding = REdgeInsets.all(LayoutConstrains.s2);

final lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: PColors.primarySwatch.shade500,
  scaffoldBackgroundColor: PColors.scaffoldBackground,
  useMaterial3: true,
  textTheme: textTheme,
  colorScheme: _colorScheme,
  textButtonTheme: _textButtonTheme,
  elevatedButtonTheme: _elevatedButtonTheme,
  chipTheme: _chipTheme,
  iconTheme: _kIconTheme,
  appBarTheme: _appBarTheme,
);
final _kIconTheme = IconThemeData(size: 20.r);

final _textButtonTheme = TextButtonThemeData(
  style: TextButton.styleFrom(
    padding: kButtonPadding,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(PRadius.button.r),
    ),
  ),
);

final _elevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    padding: kButtonPadding,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(PRadius.button.r),
    ),
  ),
);

final _colorScheme = ColorScheme.fromSwatch(
  primarySwatch: PColors.primarySwatch,
  accentColor: PColors.secondarySwatch.shade400,
);

final _chipTheme = ChipThemeData(
  padding: kChipPadding,
  selectedColor: PColors.primarySwatch.shade50,
  backgroundColor: Colors.transparent,
  checkmarkColor: PColors.primarySwatch.shade400,
  shape: RoundedRectangleBorder(
    side: BorderSide(
      width: 1.r,
    ),
    borderRadius: BorderRadius.circular(PRadius.chip.r),
  ),
);

const _appBarTheme = AppBarTheme(
  color: Colors.transparent,
  elevation: 0,
  foregroundColor: Colors.black,
  iconTheme: IconThemeData(color: Colors.black),
);
