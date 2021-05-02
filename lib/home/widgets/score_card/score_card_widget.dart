import 'package:flutter/material.dart';
import 'package:quiz/core/core.dart';
import 'package:quiz/home/widgets/chart/chart_widget.dart';

class ScoreCardWidget extends StatelessWidget {
  final double value;

  const ScoreCardWidget({Key? key, this.value = 0}) : super(key: key);

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
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: ChartWidget(value: value),
          ),
          Expanded(
            flex: 5,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Vamos começar',
                    style: AppTextStyles.heading,
                  ),
                  Text(
                    'Complete os desafios e avance em conhecimento.',
                    style: AppTextStyles.body,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
