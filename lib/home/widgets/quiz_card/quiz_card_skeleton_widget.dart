import 'package:flutter/material.dart';

import 'package:quiz/core/core.dart';
import 'package:quiz/home/widgets/skeleton/skeleton_widget.dart';

class QuizCardSkeletonWidget extends StatelessWidget {
  const QuizCardSkeletonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.fromBorderSide(
          BorderSide(
            color: AppColors.border,
          ),
        ),
      ),
      child: Skeleton(
        borderRadius: 9,
      ),
    );
  }
}
