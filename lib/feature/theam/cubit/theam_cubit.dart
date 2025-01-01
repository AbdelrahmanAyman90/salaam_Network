import 'package:bloc/bloc.dart';
import 'package:halqahquran/core/util/app_pref.dart';
import 'package:halqahquran/core/util/const_varible.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theam_state.dart';

class TheamCubit extends Cubit<TheamState> {
  bool isDarkTheme = false;

  TheamCubit() : super(TheamInitial());

  /// Load theme from SharedPreferences
  Future<void> loadTheme() async {
    isDarkTheme = SharedPrefService.getBool(themeKey);
    emit(isDarkTheme ? DarkThemeState() : LightThemeState());
  }

  /// Toggle theme and save to SharedPreferences
  Future<void> toggleTheme() async {
    isDarkTheme = !isDarkTheme;
    SharedPrefService.setBool(themeKey, isDarkTheme);
    emit(isDarkTheme ? DarkThemeState() : LightThemeState());
  }
}
