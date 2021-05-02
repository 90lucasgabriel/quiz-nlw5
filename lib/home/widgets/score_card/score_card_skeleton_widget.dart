import 'package:flutter/material.dart';
import 'package:quiz/core/core.dart';
import 'package:quiz/home/widgets/skeleton/skeleton_widget.dart';

class ScoreCardSkeletonWidget extends StatelessWidget {
  const ScoreCardSkeletonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      height: 136,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Skeleton(borderRadius: 14),
    );
  }
}
