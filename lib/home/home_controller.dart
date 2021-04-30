import 'package:flutter/material.dart';

import 'package:quiz/home/home_state.dart';
import 'package:quiz/home/home_repository.dart';
import 'package:quiz/shared/models/question_model.dart';

import 'package:quiz/shared/models/quiz_model.dart';
import 'package:quiz/shared/models/user_model.dart';

class HomeController {
  final stateNotifier = ValueNotifier<HomeState>(HomeState.empty);
  set state(HomeState state) => stateNotifier.value = state;
  HomeState get state => stateNotifier.value;

  UserModel? user;
  List<QuizModel>? quizList;
  List<QuestionModel>? questionList;
  var userScore;

  final repository = HomeRepository();

  void getUser() async {
    try {
      state = HomeState.loading;

      user = await repository.getUser();
      userScore = await repository.getUserScore(user!.uid);

      state = HomeState.success;
    } catch (eror) {
      state = HomeState.error;
    }
  }

  void getUserScore() {
    try {
      state = HomeState.loading;
      userScore = repository.getUserScore(user!.uid);
      state = HomeState.success;
    } catch (eror) {
      state = HomeState.error;
    }
  }

  void logout() async {
    try {
      state = HomeState.loading;
      user = await repository.logout();
      state = HomeState.success;
    } catch (eror) {
      state = HomeState.error;
    }
  }

  void getQuizList() async {
    try {
      state = HomeState.loading;
      quizList = await repository.getQuizList();
      state = HomeState.success;
    } catch (error) {
      state = HomeState.error;
    }
  }

  void getQuestionList(String id) async {
    try {
      state = HomeState.loading;
      questionList = await repository.getQuestionList(id);
      state = HomeState.success;
    } catch (error) {
      state = HomeState.error;
    }
  }
}
