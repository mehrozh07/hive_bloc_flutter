import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tericce_animation/utils/theme_helper/theme_helper.dart';

part 'theme_event.dart';
part 'theme_state.dart';

enum ThemeType { light, dark }

class ThemeBloc extends Bloc<ThemeEvent, ThemeType> {
  ThemeBloc() : super(ThemeType.dark) {
    on<InitialThemeSetEvent>((event, emit) async {
      final bool hasDarkTheme = await isDark();
      emit(hasDarkTheme ? ThemeType.dark : ThemeType.light);
    });
    on<ThemeSwitchEvent>((event, emit) {
      final isDark = state == ThemeType.dark;
      emit(isDark ? ThemeType.light : ThemeType.dark);
      setTheme(isDark);
    });
  }
}
