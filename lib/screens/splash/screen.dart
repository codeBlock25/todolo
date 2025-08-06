import 'package:extension_helpers/extension_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolo/config/config.dart';
import 'package:todolo/generated/assets.dart';
import 'package:todolo/main.dart';
import 'package:todolo/route/route.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:todolo/screens/screens.dart';

class SplashScreen extends RouteFulWidget {
  const SplashScreen({super.key});

  static SplashScreen get route => const SplashScreen();

  @override
  State<SplashScreen> createState() => _SplashScreenState();

  @override
  String path() => '/';

  @override
  String title() => 'Welcome ${AppConfig.platformName}';
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(
            Assets.imagesIcon,
            width: 30.cl(80, 300),
            height: 30.cl(80, 300),
          ),
          DefaultTextStyle(
            style: context.textTheme.titleLarge!.copyWith(
              color: appTheme.palette.primaryColor,
            ),
            child: AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  AppConfig.platformName,
                  speed: 300.milliseconds,
                ),
              ],
              displayFullTextOnTap: false,
              isRepeatingAnimation: false,
              totalRepeatCount: 1,
              onFinished: () async =>
                  1.seconds.delay(OnboardingScreen.route.startAt),
            ).center,
          ),
        ],
      ),
    );
  }
}
