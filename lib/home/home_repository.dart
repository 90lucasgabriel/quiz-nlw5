import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:quiz/shared/models/user_model.dart';
import 'package:quiz/shared/models/quiz_model.dart';

class HomeRepository {
  Future<UserModel> getUser() async {
    final response = await rootBundle.loadString('assets/database/user.json');
    final user = UserModel.fromJson(response);

    return user;
  }

  Future<List<QuizModel>> getQuizList() async {
    final response = await rootBundle.loadString('assets/database/quiz.json');
    final list = jsonDecode(response) as List;
    final quizList = list.map((quiz) => QuizModel.fromMap(quiz)).toList();

    return quizList;
  }
}
