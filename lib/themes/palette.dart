part of 'themes.dart';

class AppThemePalette {
  const AppThemePalette({
    required this.primaryColor,
    required this.primaryAltColor,
    required this.primaryColorDark,
    required this.primaryColorLight,
    required this.background,
    required this.backgroundDark,
    required this.error,
    required this.success,
    required this.info,
    required this.warning,
    required this.errorContainer,
    required this.secondary,
    required this.tertiary,
    required this.textColorLight,
    required this.caption,
    required this.textColorDark,
    required this.plain,
    required this.buttonAlt,
  });

  final Color primaryColor;
  final Color primaryAltColor;
  final Color primaryColorDark;
  final Color primaryColorLight;
  final Color background;
  final Color backgroundDark;
  final Color errorContainer;
  final Color error;
  final Color secondary;
  final Color success;
  final Color warning;
  final Color info;
  final Color tertiary;
  final Color textColorLight;
  final Color caption;
  final Color textColorDark;
  final Color plain;
  final Color buttonAlt;

  AppThemePalette copyWith({
    Color? primaryColor,
    Color? primaryAltColor,
    Color? primaryColorDark,
    Color? primaryColorLight,
    Color? background,
    Color? backgroundDark,
    Color? errorContainer,
    Color? error,
    Color? warning,
    Color? info,
    Color? success,
    Color? secondary,
    Color? tertiary,
    Color? textColorLight,
    Color? textColorDark,
    Color? caption,
    Color? plain,
    Color? buttonAlt,
  }) {
    return AppThemePalette(
      primaryColor: primaryColor ?? this.primaryColor,
      primaryAltColor: primaryAltColor ?? this.primaryAltColor,
      primaryColorDark: primaryColorDark ?? this.primaryColorDark,
      primaryColorLight: primaryColorLight ?? this.primaryColorLight,
      background: background ?? this.background,
      backgroundDark: backgroundDark ?? this.backgroundDark,
      error: error ?? this.error,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      info: info ?? this.info,
      errorContainer: errorContainer ?? this.errorContainer,
      secondary: secondary ?? this.secondary,
      tertiary: tertiary ?? this.tertiary,
      textColorLight: textColorLight ?? this.textColorLight,
      textColorDark: textColorDark ?? this.textColorDark,
      caption: caption ?? this.caption,
      plain: plain ?? this.plain,
      buttonAlt: buttonAlt ?? this.buttonAlt,
    );
  }

  @override
  String toString() {
    return 'AppThemePalette (\n'
        '\tprimaryColor: $primaryColor\n'
        '\tprimaryAltColor: $primaryAltColor\n'
        '\tprimaryColorDark: $primaryColorDark\n'
        '\tprimaryColorLight: $primaryColorLight\n'
        '\tbackground: $background\n'
        '\tbackgroundDark: $backgroundDark\n'
        '\terror: $error\n'
        '\twarning: $error\n'
        '\tsuccess: $error\n'
        '\tinfo: $error\n'
        '\terrorContainer: $errorContainer\n'
        '\tsecondary: $secondary\n'
        '\ttertiary: $tertiary\n'
        '\ttextColorLight: $textColorLight\n'
        '\ttextColorDark: $textColorDark\n'
        '\tcaption: $caption\n'
        '\tplain: $plain\n'
        '\tbuttonAlt: $plain\n'
        ')\n';
  }
}
