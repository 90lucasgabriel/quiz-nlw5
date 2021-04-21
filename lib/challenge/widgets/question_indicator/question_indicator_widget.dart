import 'package:flutter/material.dart';

import 'package:quiz/core/core.dart';
import 'package:quiz/shared/widgets/progress_indicator/progress_indicator_widget.dart';

class QuestionIndicatorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Questão 04',
                  style: AppTextStyles.body,
                ),
                Text(
                  'de 10',
                  style: AppTextStyles.body,
                ),
              ],
            ),
          ),
          ProgressIndicatorWidget(value: 0.4),
        ],
      ),
    );
  }
}
