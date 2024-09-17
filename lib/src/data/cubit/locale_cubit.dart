import 'package:chat_service/src/manager/pref_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit()
      : super(
            LocaleState(locale: const Locale('en'), mode: LocaleMode.manual)) {
    loadLocale();
  }

  void loadLocale() async {
    final locale = await PrefManager.getLocale();
    emit(LocaleState(locale: locale, mode: LocaleMode.manual));
  }

  void changeLocale(Locale newLocale) {
    emit(LocaleState(locale: newLocale, mode: LocaleMode.manual));
    saveLocale(newLocale);
  }

  void useDeviceLocale() {
    final deviceLocale = WidgetsBinding.instance.window.locale;
    emit(LocaleState(locale: deviceLocale, mode: LocaleMode.device));
    saveLocale(deviceLocale);
  }

  void setLocaleMode(LocaleMode mode) {
    if (mode == LocaleMode.device) {
      useDeviceLocale();
    } else {
      emit(LocaleState(locale: state.locale, mode: LocaleMode.manual));
    }
  }

  void saveLocale(Locale locale) {
    PrefManager.setLocale(locale);
  }
}

enum LocaleMode { manual, device }

class LocaleState {
  final Locale locale;
  final LocaleMode mode;

  LocaleState({required this.locale, required this.mode});
}
