import 'package:flutter/material.dart';
import 'package:quiz/core/app_images.dart';

import 'package:quiz/home/home_state.dart';

import 'package:quiz/shared/models/answer_model.dart';
import 'package:quiz/shared/models/question_model.dart';
import 'package:quiz/shared/models/quiz_model.dart';
import 'package:quiz/shared/models/user_model.dart';

class HomeController {
  final stateNotifier = ValueNotifier<HomeState>(HomeState.empty);
  set state(HomeState state) => stateNotifier.value = state;
  HomeState get state => stateNotifier.value;

  UserModel? user;
  List<QuizModel>? quizList;

  void getUser() async {
    state = HomeState.loading;
    await Future.delayed(Duration(seconds: 2));

    user = UserModel(
        name: 'Lucas Gabriel',
        photoUrl: 'https://avatars.githubusercontent.com/u/9625765?v=4');
    state = HomeState.success;
  }

  void getQuizList() async {
    state = HomeState.loading;
    await Future.delayed(Duration(seconds: 2));

    quizList = [
      QuizModel(
        title: 'NLW 5 Flutter',
        image: AppImages.blocks,
        level: Level.facil,
        quantityAnswered: 1,
        questions: [
          QuestionModel(
            title: 'Está curtindo Flutter',
            answers: [
              AnswerModel(title: 'Estou curtindo.'),
              AnswerModel(title: 'Amando Flutter.'),
              AnswerModel(title: 'Muito top.'),
              AnswerModel(
                title: 'Show de bola.',
                isRight: true,
              ),
            ],
          ),
          QuestionModel(
            title: 'Está curtindo Flutter',
            answers: [
              AnswerModel(title: 'Estou curtindo.'),
              AnswerModel(title: 'Amando Flutter.'),
              AnswerModel(title: 'Muito top.'),
              AnswerModel(
                title: 'Show de bola.',
                isRight: true,
              ),
            ],
          ),
        ],
      ),
    ];
    state = HomeState.success;
  }
}
