import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quiz/home/home_controller.dart';

import 'package:quiz/shared/models/question_model.dart';
import 'package:quiz/shared/models/user_model.dart';
import 'package:quiz/challenge/challenge_controller.dart';
import 'package:quiz/result/result_page.dart';

import 'package:quiz/challenge/widgets/next_button/next_button_widget.dart';
import 'package:quiz/challenge/widgets/question_indicator/question_indicator_widget.dart';
import 'package:quiz/challenge/widgets/quiz/quiz_widget.dart';

class ChallengePage extends StatefulWidget {
  final String id;
  final UserModel user;
  final List<QuestionModel> questions;
  final String title;

  const ChallengePage({
    Key? key,
    required this.id,
    required this.user,
    required this.questions,
    required this.title,
  }) : super(key: key);

  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  final controller = ChallengeController();
  final pageController = PageController();
  final homeController = HomeController();

  void nextPage() {
    if (controller.currentPage < 10) {
      pageController.nextPage(
        duration: Duration(
          milliseconds: 500,
        ),
        curve: Curves.easeOut,
      );
    }
  }

  void onSelected(bool value) {
    if (value) {
      controller.totalRightAnswers++;
    }

    FirebaseFirestore.instance.collection('userScore').doc(widget.user.uid).set(
        {widget.id: controller.totalRightAnswers}, SetOptions(merge: true));

    homeController.getUserScore();
  }

  @override
  void initState() {
    super.initState();

    pageController.addListener(() {
      controller.currentPage = pageController.page!.toInt() + 1;
    });
  }

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
              ValueListenableBuilder<int>(
                valueListenable: controller.currentPageNotifier,
                builder: (context, value, _) => QuestionIndicatorWidget(
                  currentPage: value,
                  totalPages: widget.questions.length,
                ),
              ),
            ],
          ),
        ),
      ),
      body: widget.questions.length > 0
          ? PageView(
              controller: pageController,
              physics: NeverScrollableScrollPhysics(),
              children: widget.questions
                  .map(
                    (question) => QuizWidget(
                      question: question,
                      onSelected: onSelected,
                    ),
                  )
                  .toList(),
            )
          : CircularProgressIndicator(),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: Container(
          padding: EdgeInsets.all(16),
          child: ValueListenableBuilder<int>(
            valueListenable: controller.currentPageNotifier,
            builder: (context, value, _) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                value == widget.questions.length
                    ? Expanded(
                        child: NextButtonWidget.purple(
                          label: 'Finalizar',
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ResultPage(
                                  title: widget.title,
                                  totalRightAnswers:
                                      controller.totalRightAnswers,
                                  totalQuestions: widget.questions.length,
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : Expanded(
                        child: NextButtonWidget.green(
                          label: 'Próxima',
                          onPressed: nextPage,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
