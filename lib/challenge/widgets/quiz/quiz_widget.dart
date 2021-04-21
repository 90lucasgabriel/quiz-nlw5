import 'package:flutter/material.dart';
import 'package:quiz/challenge/widgets/answer/answer_widget.dart';
import 'package:quiz/core/core.dart';

class QuizWidget extends StatelessWidget {
  final String title;
  QuizWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            title,
            style: AppTextStyles.heading,
          ),
          SizedBox(height: 24),
          AnswerWidget(
              title:
                  'Possibilita a criação de aplicativo compilados nativamente.'),
          AnswerWidget(
              isRight: false,
              isSelected: true,
              title:
                  'Possibilita a criação de aplicativo compilados nativamente.'),
          AnswerWidget(
              isRight: true,
              isSelected: true,
              title:
                  'Possibilita a criação de aplicativo compilados nativamente.'),
        ],
      ),
    );
  }
}
