import 'package:flutter/material.dart';
import 'package:quiz/challenge/widgets/question_indicator/question_indicator_widget.dart';
import 'package:quiz/challenge/widgets/quiz/quiz_widget.dart';

class ChallengePage extends StatefulWidget {
  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: SafeArea(
          top: true,
          child: QuestionIndicatorWidget(),
        ),
      ),
      body: QuizWidget(title: 'O que o Flutter faz em sua totalidade?'),
    );
  }
}
