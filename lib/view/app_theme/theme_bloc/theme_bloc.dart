import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:tericce_animation/view/app_theme/theme_helper/theme_helper.dart';
part 'theme_event.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeData> {
  ThemeBloc() : super(ThemeData.dark()) {
    on<InitialThemeSetEvent>((event, emit) async {
      final bool hasDarkTheme = await isDark();
      if (hasDarkTheme) {
        emit(ThemeData.dark());
      } else {
        emit(ThemeData.light());
      }
    });
    on<ThemeSwitchEvent>((event, emit) {
      final isDark = state == ThemeData.dark();
      emit(isDark ? ThemeData.light() : ThemeData.dark());
      setTheme(isDark);
    });
  }
}
