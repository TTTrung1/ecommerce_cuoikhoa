import 'package:ecommerce_cuoikhoa/bloc/theme/theme_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeMode> {
  ThemeBloc() : super(ThemeMode.light) {
    on<InitialThemeSetEvent>(_initTheme);
    on<ThemeSwitchEvent>(_onSwitch);
  }

  Future<void> _initTheme(ThemeEvent event,Emitter<ThemeMode> emit)async{
    final bool darkTheme = await isDark();
    if(darkTheme){
      emit(ThemeMode.dark);
    }
    else{
      emit(ThemeMode.light);
    }
  }
  void _onSwitch(ThemeEvent event,Emitter<ThemeMode> emit){
    final isDark = state == ThemeMode.dark;
    emit(isDark ? ThemeMode.light : ThemeMode.dark);
    setTheme(isDark);
  }

}
