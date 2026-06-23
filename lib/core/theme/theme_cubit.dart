import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/services/preferences_service.dart';

class ThemeCubit extends Cubit<ThemeMode> {
  final PreferencesService _prefs;

  ThemeCubit(this._prefs) : super(ThemeMode.system) {
    _loadTheme();
  }

  void toggleTheme() async {
    final next = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    await _prefs.saveThemeMode(next);
    emit(next);
  }

  void _loadTheme() async {
    final mode = await _prefs.getThemeMode();
    emit(mode);
  }
}
