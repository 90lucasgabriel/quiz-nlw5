import 'package:flutter/material.dart';

import 'package:quiz/challenge/widgets/answer/answer_widget.dart';
import 'package:quiz/core/core.dart';
import 'package:quiz/shared/models/answer_model.dart';
import 'package:quiz/shared/models/question_model.dart';

class QuizWidget extends StatefulWidget {
  final QuestionModel question;
  final ValueChanged<bool> onSelected;

  QuizWidget({
    Key? key,
    required this.question,
    required this.onSelected,
  }) : super(key: key);

  @override
  _QuizWidgetState createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  int selectedIndex = -1;

  AnswerModel answer(int index) => widget.question.answers[index];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              widget.question.title,
              style: AppTextStyles.heading,
            ),
          ),
          SizedBox(height: 24),
          for (var i = 0; i < widget.question.answers.length; i++)
            AnswerWidget(
              answer: answer(i),
              disabled: selectedIndex != -1,
              isSelected: selectedIndex == i,
              onPressed: (value) {
                selectedIndex = i;
                widget.onSelected(value);
                setState(() {});
              },
            ),
        ],
      ),
    );
  }
}
