import 'package:flutter/material.dart';
import 'package:get/get.dart' hide ScreenType;
import 'package:get_storage/get_storage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todolo/config/config.dart';
import 'package:todolo/logic/logic.dart';
import 'package:todolo/screens/screens.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:todolo/themes/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding.instance.addPostFrameCallback((_) {});
  await GetStorage.init();
  runApp(const App());
}

final AppTheme appTheme = AppTheme(
  palette: AppThemePalette(
    primaryColor: const Color(0xff7537AB),
    primaryAltColor: const Color(0xff7537AB),
    primaryColorDark: const Color(0xff7537AB),
    primaryColorLight: const Color(0xff7537AB),
    background: const Color(0xffFFFFFF),
    backgroundDark: const Color(0xff141416),
    error: const Color(0xffCC2B2B),
    success: const Color(0xff1bce4e),
    info: const Color(0xff3383de),
    warning: const Color(0xfff1aa23),
    errorContainer: const Color(0xffe5899a),
    secondary: const Color(0xff10B4F0),
    tertiary: const Color(0xff82828B),
    textColorLight: const Color(0xff1b1b1c),
    textColorDark: const Color(0xffe6e6ec),
    caption: const Color(0xff82828B),
    plain: const Color(0xffF3F9FF),
    buttonAlt: const Color(0xffECF0F6),
  ),
);

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      animationDuration: 300.milliseconds,
      type: MaterialType.canvas,
      surfaceTintColor: Colors.transparent,
      child: ResponsiveSizer(
        builder:
            (
              BuildContext context,
              Orientation orientation,
              ScreenType screenType,
            ) {
              return AdaptiveTheme(
                light: appTheme.light,
                dark: appTheme.dark,
                initial: AdaptiveThemeMode.system,
                debugShowFloatingThemeButton: false,
                builder: (ThemeData lightTheme, ThemeData darkTheme) {
                  return GetMaterialApp(
                    title: AppConfig.platformName,
                    initialRoute: SplashScreen.route.path(),
                    getPages: [
                      SplashScreen.route.page(),
                      OnboardingScreen.route.page(),
                      MainScreen.route.page(),
                      NewTodoScreen.route.page(),
                      ProjectScreen.route.page(),
                    ],
                    onInit: () {
                      ProjectService.put;
                      TaskService.put;
                    },
                    color: Colors.blue,
                    themeMode: ThemeMode.light,
                    theme: lightTheme,
                    darkTheme: darkTheme,
                    enableLog: false,
                    defaultTransition: Transition.leftToRightWithFade,
                  );
                },
              );
            },
      ),
    );
  }
}
