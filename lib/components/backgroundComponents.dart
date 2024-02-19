import 'package:flutter/material.dart';
import 'package:training/models/Data/app_colors.dart';

class BackgroundComponents extends StatelessWidget {
  const BackgroundComponents({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Stack(
        children: [
          Container(
            height: 500,
            color: Colors.transparent,
          ),
          Container(
            height: 1000,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(200),
                  bottomLeft: Radius.circular(30)),
              color: AppColors.pageBackground,
            ),
          ),
          // カードの部分の実装
        ],
      ),
    );
  }
}
