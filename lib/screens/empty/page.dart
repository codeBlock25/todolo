import 'package:extension_helpers/extension_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todolo/generated/assets.dart';

enum PageType { project, task }

class EmptyPage extends StatefulWidget {
  const EmptyPage({super.key, required this.type});

  final PageType type;

  @override
  State<EmptyPage> createState() => _EmptyPageState();
}

class _EmptyPageState extends State<EmptyPage> {
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
          'Your ${widget.type.name}s would appear here.',
          textAlign: TextAlign.center,
          style: context.textTheme.headlineMedium,
        ),
        Text(
          'Start by adding a ${widget.type.name}.',
          textAlign: TextAlign.center,
          style: context.textTheme.headlineMedium,
        ),
      ],
    ).contain(
      width: 100.w,
      height: 100.h,
      padding: 30.cl(50, 80).pdX,
      // color: appTheme.palette.primaryColor.withAlpha(10),
    );
  }
}
