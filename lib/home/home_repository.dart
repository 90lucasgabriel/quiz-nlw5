import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:quiz/shared/models/question_model.dart';
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

  Future<List<QuestionModel>> getQuestionList(String id) async {
    final response = await FirebaseFirestore.instance
        .collection('quiz')
        .doc(id)
        .collection('questions')
        .get();

    var parsedResponse = response.docs
        .map(
          (question) => QuestionModel.fromMap(question.data()),
        )
        .toList();

    return parsedResponse;
  }
}
