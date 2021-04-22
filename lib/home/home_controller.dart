import 'package:flutter/material.dart';

import 'package:quiz/home/home_state.dart';
import 'package:quiz/home/home_repository.dart';

import 'package:quiz/shared/models/quiz_model.dart';
import 'package:quiz/shared/models/user_model.dart';

class HomeController {
  final stateNotifier = ValueNotifier<HomeState>(HomeState.empty);
  set state(HomeState state) => stateNotifier.value = state;
  HomeState get state => stateNotifier.value;

  UserModel? user;
  List<QuizModel>? quizList;

  final repository = HomeRepository();

  void getUser() async {
    try {
      state = HomeState.loading;
      user = await repository.getUser();
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
}
