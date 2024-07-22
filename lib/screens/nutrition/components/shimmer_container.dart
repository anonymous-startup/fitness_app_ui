import 'package:fitness_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerContainer extends StatelessWidget {
  const ShimmerContainer({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: primaryLightColor,
      highlightColor: secondaryLightColor,
      child: Container(
        padding: const EdgeInsets.all(10),
        height: height,
        width: width,
        decoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
      ),
    );
  }
}