import 'package:extension_helpers/extension_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todolo/generated/assets.dart';

class ErrorPage extends StatefulWidget {
  const ErrorPage({super.key, required this.refresh, required this.content});

  final Future<void> Function() refresh;
  final String content;

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          Assets.imagesErrorIllustration,
          width: 100.w,
          fit: BoxFit.contain,
        ),
        Text(
          widget.content,
          textAlign: TextAlign.center,
          style: context.textTheme.headlineMedium,
        ),
        ElevatedButton(
          onPressed: () async {
            await widget.refresh();
          },
          style: ButtonStyle(minimumSize: Size(100.w, 28.cl(40, 70)).all),
          child: const Text('Refresh'),
        ),
      ],
    ).contain(
      width: 100.w,
      height: 100.h,
      padding: 30.cl(50, 80).pdX,
      color: Colors.red.withAlpha(30),
    );
  }
}
