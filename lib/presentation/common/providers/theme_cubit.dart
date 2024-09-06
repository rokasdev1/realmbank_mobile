import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(DarkThemeState());

  void init() {
    Hive.box('settings').watch(key: 'theme').listen((event) {
      if (event.value == 'light') {
        emit(LightThemeState());
      } else {
        emit(DarkThemeState());
      }
    });
  }

  void toggleTheme() async {
    await Hive.box('settings')
        .put('theme', state is LightThemeState ? 'dark' : 'light');
  }
}

abstract class ThemeState {}

class LightThemeState extends ThemeState {}

class DarkThemeState extends ThemeState {}
