import 'package:extension_helpers/extension_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todolo/components/form_field/form_field.dart';
import 'package:todolo/config/config.dart';
import 'package:todolo/generated/assets.dart';
import 'package:todolo/logic/error/error.dart';
import 'package:todolo/main.dart';
import 'package:todolo/route/route.dart';
import 'package:todolo/screens/screens.dart';
import 'package:todolo/utils/utils.dart';
import 'package:validatorless/validatorless.dart';

class OnboardingScreen extends RouteFulWidget {
  const OnboardingScreen({super.key});

  static OnboardingScreen get route => const OnboardingScreen();

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();

  @override
  String path() => '/onboarding';

  @override
  String title() => 'Onboarding';

  @override
  Transition transition() => Transition.fadeIn;
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final TextEditingController _emailController = TextEditingController();
  String? _apiEmailError;
  String? _apiPasswordError;
  final TextEditingController _passwordController = TextEditingController();
  final RxBool _apiLoading = false.obs;
  final RxBool isPasswordHidden = true.obs;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(toolbarHeight: 0),
      body: Column(
        children: <Widget>[
          20.cl(20, 50).hSpacer,
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                LucideIcons.check,
                color: appTheme.palette.primaryColor,
                size: context.textTheme.headlineLarge?.fontSize?.double
                    .toDouble(),
              ),
              Text(
                AppConfig.platformName,
                style: context.textTheme.headlineLarge,
              ),
            ],
          ),
          Image.asset(
            Assets.imagesOnboardingImage2,
            fit: BoxFit.contain,
          ).expand,
          // const Spacer(),
          OutlinedButton.icon(
            onPressed: () {
              context.toast(
                toastMessage:
                    'Google auth coming soon, please use your email credentials',
                type: ToastSnackBarType.info,
              );
            },
            icon: Image.asset(Assets.iconsGoogle, width: 20.cl(20, 40)),
            style: ButtonStyle(
              minimumSize: Size(100.w, 28.cl(40, 70)).all,
              foregroundColor: context.textTheme.bodySmall?.color.all,
            ),
            label: Text('Continue with Google'),
          ),
          10.cl(10, 20).hSpacer,
          OutlinedButton.icon(
            onPressed: () {
              context.toast(
                toastMessage:
                    'Apple auth coming soon, please use your email credentials',
                type: ToastSnackBarType.info,
              );
            },
            icon: Image.asset(Assets.iconsApple, width: 20.cl(20, 40)),
            style: ButtonStyle(
              minimumSize: Size(100.w, 28.cl(40, 70)).all,
              foregroundColor: context.textTheme.bodySmall?.color.all,
            ),
            label: Text('Continue with Apple'),
          ),
          10.cl(10, 20).hSpacer,
          OutlinedButton.icon(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                enableDrag: true,
                backgroundColor: context.theme.scaffoldBackgroundColor,
                requestFocus: true,
                showDragHandle: true,
                isDismissible: true,
                isScrollControlled: true,
                useRootNavigator: true,
                constraints: BoxConstraints(minHeight: 90.h),
                scrollControlDisabledMaxHeightRatio: 0.8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: 15.cl(10, 30).rc,
                    topRight: 15.cl(10, 30).rc,
                  ),
                ),
                builder: (BuildContext context) {
                  return Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sign In',
                          style: context.textTheme.headlineLarge?.copyWith(
                            color: appTheme.palette.primaryColor,
                          ),
                        ),
                        Text(
                          'Please enter your email address and password to continue',
                          style: context.textTheme.bodyMedium,
                        ),
                        20.cl(20, 40).hSpacer,
                        AppTextFormField(
                          controller: _emailController,
                          label: 'Email',
                          hint: 'Enter email address',
                          validator: (String? val) =>
                              Validatorless.multiple([
                                Validatorless.required('Email is required'),
                                Validatorless.email('Email is invalid'),
                                noEmojiValidator,
                              ])(val) ??
                              _apiEmailError,
                          autofillHints: [
                            AutofillHints.email,
                            AutofillHints.username,
                          ],
                          onChanged: (_) {
                            if (_apiEmailError != null) {
                              setState(() {
                                _apiEmailError = null;
                              });
                            }
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(
                              RegExp(
                                r'[\u{1F600}-\u{1F64F}]|' // Emoticons
                                r'[\u{1F300}-\u{1F5FF}]|' // Symbols & Pictographs
                                r'[\u{1F680}-\u{1F6FF}]|' // Transport & Map Symbols
                                r'[\u{1F1E6}-\u{1F1FF}]|' // Flags
                                r'[\u{2600}-\u{26FF}]|' // Misc symbols
                                r'[\u{2700}-\u{27BF}]', // Dingbats
                                unicode: true,
                              ),
                            ),
                          ],
                          startWidget: Icon(LucideIcons.mail),
                        ),
                        10.cl(10, 20).hSpacer,
                        Obx(
                          () => AppTextFormField(
                            controller: _passwordController,
                            label: 'Password',
                            hint: 'Enter password',
                            isHidden: isPasswordHidden.value,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(
                                RegExp(
                                  r'[\u{1F600}-\u{1F64F}]|' // Emoticons
                                  r'[\u{1F300}-\u{1F5FF}]|' // Symbols & Pictographs
                                  r'[\u{1F680}-\u{1F6FF}]|' // Transport & Map Symbols
                                  r'[\u{1F1E6}-\u{1F1FF}]|' // Flags
                                  r'[\u{2600}-\u{26FF}]|' // Misc symbols
                                  r'[\u{2700}-\u{27BF}]', // Dingbats
                                  unicode: true,
                                ),
                              ),
                            ],
                            endWidget: IconButton(
                              onPressed: isPasswordHidden.toggle,
                              icon: Obx(
                                () => Icon(
                                  isPasswordHidden.value.when(
                                    use: LucideIcons.eye,
                                    elseUse: LucideIcons.eyeClosed,
                                  ),
                                  color: appTheme.palette.caption,
                                ),
                              ),
                            ).paddingSymmetric(vertical: 5.cl(5, 15)),
                            validator: (String? val) =>
                                Validatorless.multiple([
                                  Validatorless.required(
                                    'Password is required',
                                  ),
                                  Validatorless.min(
                                    8,
                                    'Password must be at least 8 characters',
                                  ),
                                  noEmojiValidator,
                                ])(val) ??
                                _apiPasswordError,
                            startWidget: Icon(LucideIcons.lock),
                          ),
                        ),
                        20.cl(20, 50).hSpacer,
                        Obx(
                          () => ElevatedButton.icon(
                            onPressed: onSignIn,
                            icon: _apiLoading.isTrue.whenOnly(
                              use:
                                  CircularProgressIndicator(
                                    color: Colors.white.withValues(alpha: 0.6),
                                    strokeWidth: 2.cl(2, 4),
                                  ).sized(
                                    width: 16.cl(16, 28),
                                    height: 16.cl(16, 28),
                                  ),
                            ),
                            style: ButtonStyle(
                              minimumSize: Size(100.w, 28.cl(40, 70)).all,
                            ),
                            label: Text('Sign In'),
                          ),
                        ),
                      ],
                    ),
                  ).contain(width: 100.w, padding: 20.cl(20, 40).pdX);
                },
              );
            },
            icon: Icon(
              LucideIcons.mail,
              size: context.textTheme.bodySmall?.fontSize?.double.toDouble(),
            ),
            style: ButtonStyle(
              minimumSize: Size(100.w, 28.cl(40, 70)).all,
              iconColor: context.textTheme.bodySmall?.color.all,
              foregroundColor: context.textTheme.bodySmall?.color.all,
            ),
            label: Text('Continue with Email'),
          ),
          20.cl(20, 40).hSpacer,
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'By continuing, you agree to our ',
              style: context.textTheme.bodySmall,
              children: [
                TextSpan(
                  text: 'Terms of Service',
                  style: context.textTheme.bodySmall?.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
                TextSpan(text: ' and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: context.textTheme.bodySmall?.copyWith(
                    decoration: TextDecoration.underline,
                  ),
                ),
                TextSpan(text: '.'),
              ],
            ),
          ),
          10.cl(10, 20).plus(context.mediaQueryPadding.bottom).hSpacer,
        ],
      ).contain(width: 100.w, height: 100.h, padding: 20.cl(20, 40).pdX),
    );
  }

  Future<void> onSignIn() async {
    try {
      _apiLoading.value = true;
      if (_formKey.currentState?.validate() ?? false) {
        await 2.seconds.delay(() {
          Get.back();
          _emailController.text = '';
          _passwordController.text = '';
          context.toast(
            toastMessage: 'Welcome back',
            type: ToastSnackBarType.success,
            duration: 1.seconds,
            onClosed: MainScreen.route.startAt,
          );
        });
      }
    } on ErrorResponse catch (error) {
      if (error.message != null) {
        if (mounted) {
          Get.back();
          context.toast(
            toastMessage: error.message!,
            type: ToastSnackBarType.danger,
          );
        }
      }
      if (error.errors?.keys.contains('email') ?? false) {
        setState(() {
          _apiEmailError = error.errors?['email']?.join(', ');
        });
      }
      if (error.errors?.keys.contains('password') ?? false) {
        setState(() {
          _apiPasswordError = error.errors?['password']?.join(', ');
        });
      }
    } catch (e) {
      if (mounted) {
        context.toast(
          toastMessage: 'Ops!, Something went wrong',
          type: ToastSnackBarType.danger,
        );
      }
    } finally {
      _apiLoading.value = false;
    }
  }
}
