import 'package:flutter/cupertino.dart';

class AppTextStyles{
  AppTextStyles._();
  static final AppTextStyles instance =  AppTextStyles._();

  TextStyle get f16w400Black => const TextStyle(
    color: CupertinoColors.black,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  TextStyle get f16w400 => const TextStyle(
    color: CupertinoColors.black,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

}