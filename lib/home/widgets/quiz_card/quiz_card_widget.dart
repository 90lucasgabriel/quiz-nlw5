import 'package:flutter/material.dart';

import 'package:quiz/core/core.dart';
import 'package:quiz/shared/widgets/progress_indicator/progress_indicator_widget.dart';

class QuizCardWidget extends StatelessWidget {
  final String title;
  final int quantityAnswered;
  final int totalQuestions;

  const QuizCardWidget(
      {Key? key,
      required this.title,
      required this.quantityAnswered,
      required this.totalQuestions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.fromBorderSide(
          BorderSide(
            color: AppColors.border,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 20),
            height: 40,
            width: 40,
            child: Image.asset(AppImages.blocks),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Text(
              title,
              style: AppTextStyles.heading15,
            ),
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  "$quantityAnswered/$totalQuestions",
                  style: AppTextStyles.body11,
                ),
              ),
              Expanded(
                flex: 3,
                child: ProgressIndicatorWidget(
                  value: quantityAnswered / totalQuestions,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
