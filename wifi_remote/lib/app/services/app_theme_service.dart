import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wifi_remote/utils/AppColors.dart';

enum AppTheme { dark, light }

class AppThemeService extends GetxService {
  final _theme = AppTheme.dark.obs;

  void toggleTheme() {
    _theme.value = _theme.value == AppTheme.dark? AppTheme.light: AppTheme.dark;
  }

  Color get background => _theme.value == AppTheme.dark
      ? AppColors.darkBackground
      : AppColors.lightBackground;
  Color get text =>
      _theme.value == AppTheme.dark ? AppColors.darkText : AppColors.lightText;
  Color get select => _theme.value == AppTheme.dark
      ? AppColors.darkSelect
      : AppColors.lightSelect;
  Color get icon =>
      _theme.value == AppTheme.dark ? AppColors.darkIcon : AppColors.lightIcon;
  Color get iconButton => _theme.value == AppTheme.dark
      ? AppColors.darkIconButton
      : AppColors.lightIconButton;
  Color get buttonBackground => _theme.value == AppTheme.dark
      ? AppColors.darkButtonBackground
      : AppColors.lightButtonBackground;
}
