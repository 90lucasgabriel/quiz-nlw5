import 'package:flutter/material.dart';

import 'package:quiz/core/core.dart';
import 'package:quiz/shared/models/question_model.dart';

import 'package:quiz/challenge/widgets/answer/answer_widget.dart';

class QuizWidget extends StatelessWidget {
  final QuestionModel question;
  QuizWidget({required this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            question.title,
            style: AppTextStyles.heading,
          ),
          SizedBox(height: 24),
          ...question.answers
              .map(
                (answer) => AnswerWidget(
                  title: answer.title,
                  isRight: answer.isRight ?? false,
                ),
              )
              .toList()
        ],
      ),
    );
  }
}
