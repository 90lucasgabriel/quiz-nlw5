import 'package:flutter/material.dart';
import 'package:quiz/challenge/widgets/next_button/next_button_widget.dart';
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
        preferredSize: Size.fromHeight(140),
        child: SafeArea(
          top: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              QuestionIndicatorWidget(),
            ],
          ),
        ),
      ),
      body: QuizWidget(title: 'O que o Flutter faz em sua totalidade?'),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: NextButtonWidget.white(
                  label: 'Voltar',
                  onPressed: () {},
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: NextButtonWidget.green(
                  label: 'Confirmar',
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
