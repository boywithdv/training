import 'package:flutter/material.dart';
import 'package:training/models/Data/app_colors.dart';

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    Key? key,
    required this.isActive,
  }) : super(key: key);

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(bottom: 2),
      height: 4,
      width: isActive ? 20 : 0,
      decoration: const BoxDecoration(
        color: AppColors.contentColorCyan,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
