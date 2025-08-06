import 'package:extension_helpers/extension_helpers.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:shimmer/shimmer.dart';
import 'package:todolo/main.dart';

class AvatarShimmer extends StatelessWidget {
  final String imageUrl;
  final double radius;
  final Color? backgroundColor;

  const AvatarShimmer({
    super.key,
    required this.imageUrl,
    this.radius = 30,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final double size = radius.double.toDouble();

    return Container(
      clipBehavior: Clip.hardEdge,
      padding: 2.pdAll,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey[900],
        borderRadius: size.double.brcAll,
      ),
      child: Image.network(
        imageUrl,
        width: size,
        height: size,
        fit: BoxFit.cover,
        alignment: Alignment.center,
        errorBuilder: (context, url, error) => Container(
          width: size,
          height: size,
          color: Colors.grey[300],
          alignment: Alignment.center,
          child: Icon(LucideIcons.triangleAlert, color: appTheme.palette.error),
        ),
        loadingBuilder: (context, _, _) => Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(width: size, height: size, color: Colors.white),
        ),
      ),
    );
  }
}
