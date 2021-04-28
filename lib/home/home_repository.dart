import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quiz/shared/models/question_model.dart';
import 'package:quiz/shared/models/user_model.dart';
import 'package:quiz/shared/models/quiz_model.dart';

class HomeRepository {
  Future<UserModel?> getUser() async {
    // final response = await rootBundle.loadString('assets/database/user.json');
    // final user = UserModel.fromJson(response);

    // return user;
    //

    try {
      // if (_user.uid.length > 0) return _user;

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      UserModel user = UserModel(
        uid: userCredential.user!.uid,
        name: userCredential.user!.displayName ?? '',
        photoUrl: userCredential.user!.photoURL ?? '',
        score: 0,
      );

      return user;
    } catch (error) {
      return null;
    }
  }

  logout() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
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
