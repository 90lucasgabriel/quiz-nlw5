import 'package:flutter/material.dart';
import 'package:quiz/core/core.dart';

import 'package:quiz/home/home_controller.dart';
import 'package:quiz/home/home_state.dart';
import 'package:quiz/home/widgets/appbar/appbar_widget.dart';
import 'package:quiz/home/widgets/level_button/level_button_widget.dart';
import 'package:quiz/home/widgets/quiz_card/quiz_card_widget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  @override
  void initState() {
    super.initState();
    controller.getUser();
    controller.getQuizList();

    controller.stateNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (controller.state == HomeState.loading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.darkGreen),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppbarWidget(
        user: controller.user!,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          children: [
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LevelButtonWidget(label: 'Fácil'),
                LevelButtonWidget(label: 'Médio'),
                LevelButtonWidget(label: 'Difícil'),
                LevelButtonWidget(label: 'Perito'),
              ],
            ),
            SizedBox(height: 16),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: controller.quizList!
                    .map(
                      (item) => QuizCardWidget(
                        title: item.title,
                        quantityAnswered: item.quantityAnswered,
                        totalQuestions: item.questions.length,
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
