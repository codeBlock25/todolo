part of './themes.dart';

ThemeData _darkTheme(AppThemePalette palette) {
  return ThemeData(
    colorScheme: ColorScheme.light(
      onPrimary: palette.primaryColor,
      onPrimaryContainer: palette.primaryColor.withValues(alpha: 0.2),
      onError: palette.error,
      onErrorContainer: palette.errorContainer,
      brightness: GetPlatform.isIOS ? Brightness.dark : Brightness.light,
      primary: palette.primaryColor,
      error: palette.error,
      errorContainer: palette.errorContainer,
      secondary: palette.secondary,
      tertiary: palette.tertiary,
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: palette.backgroundDark,
      dividerColor: palette.caption,
      headerForegroundColor: palette.textColorDark,
      dayOverlayColor: palette.primaryColor.withAlpha(40).all,
      dayForegroundColor: WidgetStateColor.resolveWith((state) {
        if (state.contains(WidgetState.selected)) {
          return palette.textColorDark.lighten(40);
        }
        return palette.textColorDark;
      }),
      dayBackgroundColor: WidgetStateColor.resolveWith((state) {
        if (state.contains(WidgetState.selected)) {
          return palette.primaryColor;
        }
        return palette.primaryColor.withAlpha(20);
      }),
      yearOverlayColor: palette.primaryColor.withAlpha(40).all,
      yearBackgroundColor: WidgetStateColor.resolveWith((state) {
        if (state.contains(WidgetState.selected)) {
          return palette.primaryColor;
        }
        return palette.primaryColor.withAlpha(20);
      }),
      yearForegroundColor: WidgetStateColor.resolveWith((state) {
        if (state.contains(WidgetState.selected)) {
          return palette.textColorDark.lighten(40);
        }
        return palette.textColorDark;
      }),
      todayBackgroundColor: WidgetStateColor.resolveWith((state) {
        if (state.contains(WidgetState.selected)) {
          return palette.primaryColor;
        }
        return palette.primaryColor.withAlpha(20);
      }),
      todayForegroundColor: WidgetStateColor.resolveWith((state) {
        if (state.contains(WidgetState.selected)) {
          return palette.textColorDark.lighten(40);
        }
        return palette.textColorDark;
      }),
      weekdayStyle: TextStyle(
        fontSize: 14.cl(12, 16),
        fontWeight: FontWeight.w400,
        color: palette.textColorDark,
      ),
      rangePickerHeaderHelpStyle: TextStyle(
        fontSize: 14.cl(12, 16),
        fontWeight: FontWeight.w400,
        color: palette.textColorDark,
      ),
      rangePickerHeaderHeadlineStyle: TextStyle(
        fontSize: 14.cl(12, 16),
        fontWeight: FontWeight.w400,
        color: palette.textColorDark,
      ),
      headerHeadlineStyle: TextStyle(
        fontSize: 16.cl(16, 20),
        fontWeight: FontWeight.w700,
        color: palette.textColorDark,
      ),
      headerHelpStyle: TextStyle(
        fontSize: 14.cl(14, 18),
        fontWeight: FontWeight.w700,
        color: palette.textColorDark,
      ),
      dayStyle: TextStyle(
        fontSize: 14.cl(12, 16),
        fontWeight: FontWeight.w400,
        color: palette.textColorDark,
      ),
      yearStyle: TextStyle(
        fontSize: 14.cl(12, 16),
        fontWeight: FontWeight.w400,
        color: palette.textColorDark,
      ),
    ),
    hoverColor: palette.primaryColor.darken(5).withValues(alpha: 0.2),
    scaffoldBackgroundColor: palette.backgroundDark,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.grey[900],
      selectionColor: palette.primaryColor.withValues(alpha: 0.5),
      selectionHandleColor: palette.primaryColor,
    ),
    snackBarTheme: SnackBarThemeData(
      shape: RoundedRectangleBorder(borderRadius: 10.cl(10, 20).rc.brAll),
      width: 100.cw(200, 500).minus(15.cl(10, 35).double).toDouble(),
      dismissDirection: DismissDirection.down,
      showCloseIcon: true,
      closeIconColor: Colors.white,
      contentTextStyle: TextStyle(
        fontSize: 15.cl(12, 18),
        fontWeight: FontWeight.w400,
        color: palette.textColorDark,
      ),
      behavior: SnackBarBehavior.floating,
    ),
    primaryColor: palette.primaryColor,
    primaryColorDark: palette.primaryColorDark,
    primaryColorLight: palette.primaryColorLight,
    useMaterial3: true,
    tabBarTheme: TabBarThemeData(
      overlayColor: palette.primaryColor.withValues(alpha: 0.1).all,
      labelColor: palette.textColorLight,
      unselectedLabelColor: palette.textColorLight.withValues(alpha: 0.8),
      unselectedLabelStyle: TextStyle(
        fontSize: 12.cl(12, 18),
        fontWeight: FontWeight.w400,
        color: palette.textColorLight,
      ),
      labelStyle: TextStyle(
        fontSize: 12.cl(12, 18),
        fontWeight: FontWeight.w600,
        color: palette.textColorLight,
      ),
      tabAlignment: TabAlignment.fill,
      dividerColor: Colors.transparent,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: palette.backgroundDark,
      surfaceTintColor: palette.backgroundDark,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontSize: 16.cl(16, 22),
        fontWeight: FontWeight.w600,
        color: palette.textColorDark,
      ),
      iconTheme: IconThemeData(color: palette.textColorDark),
      actionsIconTheme: IconThemeData(color: palette.primaryColorLight),
      scrolledUnderElevation: 10,
      foregroundColor: palette.textColorDark,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: palette.backgroundDark,
        systemNavigationBarColor: palette.backgroundDark,
        statusBarBrightness: GetPlatform.isIOS
            ? Brightness.dark
            : Brightness.light,
        systemNavigationBarIconBrightness: GetPlatform.isIOS
            ? Brightness.dark
            : Brightness.light,
        statusBarIconBrightness: GetPlatform.isIOS
            ? Brightness.dark
            : Brightness.light,
      ),
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: palette.backgroundDark,
      titleTextStyle: TextStyle(
        fontSize: 16.cl(16, 20),
        fontWeight: FontWeight.w700,
        color: palette.textColorDark,
      ),
      contentTextStyle: TextStyle(
        fontSize: 16.cl(16, 20),
        color: palette.textColorDark,
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      indicatorColor: palette.primaryColor,
      iconTheme: IconThemeData(size: 18.cl(16, 28)).all,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
      labelTextStyle: TextStyle(fontSize: 12.cl(10, 16)).all,
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: palette.primaryColor,
      circularTrackColor: palette.primaryColor.withValues(alpha: 0.5),
      refreshBackgroundColor: palette.primaryColor.withValues(alpha: 0.5),
      linearTrackColor: palette.primaryColor.withValues(alpha: 0.5),
      linearMinHeight: 8.cl(6, 12),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        backgroundColor: Colors.transparent.all,
        overlayColor: palette.primaryColor.withValues(alpha: 0.2).all,
        elevation: 2.cl(1, 3).all,
        foregroundColor: palette.textColorDark.all,
        textStyle: TextStyle(
          fontSize: 15.cl(10, 20),
          fontWeight: FontWeight.w600,
        ).all,
        padding: 10
            .cl(12, 20)
            .pdX
            .copyWith(top: 5.cl(5, 14), bottom: 5.cl(5, 14))
            .all,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.cl(10, 25)),
        ).all,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((val) {
          if (val.contains(WidgetState.disabled)) {
            return Color(0xffF3F9FF).darken(17);
          }
          if (val.contains(WidgetState.hovered)) {
            return Color(0xffF3F9FF).darken(4);
          }
          if (val.contains(WidgetState.focused) ||
              val.contains(WidgetState.pressed)) {
            return Color(0xffF3F9FF).darken(10);
          }
          return Color(0xffF3F9FF);
        }),
        overlayColor: palette.primaryColor.withValues(alpha: 0.1).all,
        elevation: 2.cl(1, 3).all,
        foregroundColor: palette.primaryColor.all,
        surfaceTintColor: palette.primaryColor.withValues(alpha: 0.2).all,
        iconColor: palette.primaryColor.all,
        textStyle: TextStyle(
          fontSize: 14.cl(14, 18),
          fontWeight: FontWeight.w600,
        ).all,
        padding: 10.cl(12, 20).pdXY(5.cl(5, 10)).all,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.cl(5, 16)),
        ).all,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: Colors.transparent.all,
        overlayColor: palette.primaryColor.withValues(alpha: 0.1).all,
        elevation: 2.cl(1, 3).all,
        foregroundColor: palette.primaryColor.all,
        surfaceTintColor: palette.primaryColor.withValues(alpha: 0.2).all,
        iconColor: palette.primaryColor.all,
        textStyle: TextStyle(
          fontSize: 16.cl(14, 20),
          fontWeight: FontWeight.w600,
        ).all,
        padding: 10.cl(12, 20).pdXY(5.cl(5, 10)).all,
        shape: RoundedRectangleBorder(
          borderRadius: 8.cl(8, 17).rc.brAll,
          side: BorderSide(color: palette.primaryColor, width: 2.cl(2, 4)),
        ).all,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((val) {
          if (val.contains(WidgetState.disabled)) {
            return palette.primaryColor.darken(17);
          }
          if (val.contains(WidgetState.hovered)) {
            return palette.primaryColor.lighten(5);
          }
          if (val.contains(WidgetState.focused) ||
              val.contains(WidgetState.pressed)) {
            return palette.primaryColor.darken(10);
          }
          return palette.primaryColor;
        }),
        overlayColor: palette.primaryColor
            .darken(10)
            .withValues(alpha: 0.2)
            .all,
        elevation: 2.cl(1, 3).all,
        foregroundColor: Colors.white.all,
        surfaceTintColor: palette.primaryColor.withValues(alpha: 0.2).all,
        iconColor: Colors.white.all,
        textStyle: TextStyle(
          fontSize: 16.cl(14, 20),
          fontWeight: FontWeight.w700,
        ).all,
        padding: 10.cl(12, 20).pdXY(5.cl(5, 10)).all,
        shape: RoundedRectangleBorder(borderRadius: 8.cl(8, 17).rc.brAll).all,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((Set<WidgetState> states) {
        if (states.contains(WidgetState.pressed) ||
            states.contains(WidgetState.selected) ||
            states.contains(WidgetState.focused)) {
          return palette.primaryColor; // Button is pressed
        }
        return Colors.grey; // Default state
      }),
      trackOutlineColor: WidgetStateProperty.resolveWith((
        Set<WidgetState> states,
      ) {
        if (states.contains(WidgetState.pressed) ||
            states.contains(WidgetState.selected) ||
            states.contains(WidgetState.focused)) {
          return palette.primaryColor; // Button is pressed
        }
        return Colors.grey; // Default state
      }),
      trackColor: palette.primaryColor.lighten(30).all,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: palette.primaryColor,
      foregroundColor: palette.textColorDark,
      elevation: 4.cl(4, 10),
      focusColor: palette.primaryColor.lighten(10),
      focusElevation: 7.cl(4, 16),
      hoverColor: palette.primaryColor.lighten(10),
      splashColor: palette.primaryColor.withValues(alpha: 0.3),
      iconSize: 18.cl(20, 40),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 24.cl(36, 36),
        fontWeight: FontWeight.w900,
        color: palette.textColorDark,
      ),
      titleMedium: TextStyle(
        fontSize: 22.cl(22, 32),
        fontWeight: FontWeight.w900,
        color: palette.textColorDark,
      ),
      titleSmall: TextStyle(
        fontSize: 20.cl(20, 28),
        fontWeight: FontWeight.w900,
        color: palette.textColorDark,
      ),
      headlineLarge: TextStyle(
        fontSize: 20.cl(24, 26),
        fontWeight: FontWeight.w700,
        color: palette.textColorDark,
      ),
      headlineMedium: TextStyle(
        fontSize: 16.cl(16, 20),
        fontWeight: FontWeight.w700,
        color: palette.textColorDark,
      ),
      headlineSmall: TextStyle(
        fontSize: 14.cl(14, 16),
        fontWeight: FontWeight.w700,
        color: palette.textColorDark,
      ),
      bodyLarge: TextStyle(
        fontSize: 22.cl(24, 30),
        fontWeight: FontWeight.w400,
        color: palette.textColorDark,
      ),
      bodyMedium: TextStyle(
        fontSize: 16.cl(16, 20),
        fontWeight: FontWeight.w400,
        color: palette.textColorDark,
      ),
      bodySmall: TextStyle(
        fontSize: 14.cl(12, 16),
        fontWeight: FontWeight.w400,
        color: palette.textColorDark,
      ),
      labelLarge: TextStyle(
        fontSize: 20.cl(18, 32),
        fontWeight: FontWeight.w600,
      ),
      labelMedium: TextStyle(
        fontSize: 16.cl(16, 22),
        fontWeight: FontWeight.w600,
      ),
      labelSmall: TextStyle(
        fontSize: 14.cl(14, 18),
        fontWeight: FontWeight.w600,
      ),
    ),
    tooltipTheme: TooltipThemeData(
      textStyle: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: Colors.white.withValues(alpha: 0.6),
      ),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: 5.cl(5, 15).rc.brAll,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: 15.cl(10, 45).pdXY(5.cl(5, 10)),
      labelStyle: TextStyle(
        fontSize: 16.cl(16, 20),
        color: palette.textColorDark,
      ),
      hintStyle: TextStyle(
        fontSize: 16.cl(16, 20),
        textBaseline: TextBaseline.alphabetic,
        color: palette.textColorDark.darken(40),
        fontWeight: FontWeight.normal,
      ),
      prefixIconColor: palette.textColorDark,
      suffixIconColor: palette.textColorDark.withValues(alpha: 0.7),
      hoverColor: palette.primaryColor.withValues(alpha: 0.05),
      errorBorder: OutlineInputBorder(
        borderRadius: 8.cl(8, 17).rc.brAll,
        borderSide: BorderSide(width: 2.cl(2, 4), color: palette.error),
      ),
      errorMaxLines: 2,
      focusColor: palette.backgroundDark,
      fillColor: palette.backgroundDark,
      iconColor: Colors.grey[900],
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: 8.cl(8, 17).rc.brAll,
        borderSide: BorderSide(
          width: 1.cl(1, 3),
          color: palette.primaryColor.withValues(alpha: 0.2),
        ),
      ),
      activeIndicatorBorder: BorderSide(
        width: 2.cl(1, 3),
        color: palette.primaryColor,
      ),
      outlineBorder: BorderSide(width: 2.cl(2, 4), color: Colors.grey[600]!),
      focusedBorder: OutlineInputBorder(
        borderRadius: 8.cl(8, 17).rc.brAll,
        borderSide: BorderSide(width: 2.cl(2, 4), color: palette.primaryColor),
      ),
      border: OutlineInputBorder(
        borderRadius: 8.cl(8, 17).rc.brAll,
        borderSide: BorderSide(
          width: 2.cl(1, 3),
          color: palette.primaryColor.withValues(alpha: 0.4),
        ),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: 8.cl(8, 17).rc.brAll,
        borderSide: BorderSide(width: 2.cl(2, 4), color: Colors.grey[400]!),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      elevation: 0,
      enableFeedback: true,
      selectedIconTheme: IconThemeData(
        color: palette.primaryColor,
        size: 18.cl(18, 26),
      ),
      selectedItemColor: palette.textColorLight,
      unselectedItemColor: palette.textColorLight,
      unselectedIconTheme: IconThemeData(
        color: Colors.grey[500],
        size: 18.cl(18, 26),
      ),
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.shifting,
      selectedLabelStyle: TextStyle(
        fontSize: 15.cl(12, 18),
        color: palette.textColorLight,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 15.cl(12, 18),
        color: palette.textColorLight,
      ),
    ),
  );
}
