import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:quiz/home/home_controller.dart';
import 'package:quiz/home/home_state.dart';
import 'package:quiz/challenge/challenge_page.dart';

import 'package:quiz/home/widgets/appbar/appbar_widget.dart';
import 'package:quiz/home/widgets/level_button/level_button_widget.dart';
import 'package:quiz/home/widgets/quiz_card/quiz_card_widget.dart';
import 'package:quiz/shared/models/question_model.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();
  num score = 0;

  @override
  void initState() {
    super.initState();
    controller.getQuizList();

    controller.stateNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _firebaseInit = Firebase.initializeApp();

    return FutureBuilder(
      future: _firebaseInit,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done ||
            controller.state == HomeState.success) {
          return Scaffold(
            body: Container(
              child: Column(
                children: [
                  AppbarWidget(
                    user: controller.user,
                    loginAction: controller.getUser,
                    logoutAction: controller.logout,
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              LevelButtonWidget(label: 'Fácil'),
                              LevelButtonWidget(label: 'Médio'),
                              LevelButtonWidget(label: 'Difícil'),
                              LevelButtonWidget(label: 'Perito'),
                            ],
                          ),
                          Expanded(
                            child: StreamBuilder<QuerySnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('quiz')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                switch (snapshot.connectionState) {
                                  case ConnectionState.none:
                                  case ConnectionState.waiting:
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  default:
                                    List<DocumentSnapshot> documentList =
                                        snapshot.data?.docs.toList() ?? [];

                                    return GridView.builder(
                                      itemCount: documentList.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 16,
                                        mainAxisSpacing: 16,
                                      ),
                                      itemBuilder: (context, index) {
                                        return StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection('userScore')
                                              .doc(controller.user?.uid)
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            switch (snapshot.connectionState) {
                                              case ConnectionState.none:
                                              case ConnectionState.waiting:
                                                return Container();
                                              default:
                                                var currentData = snapshot.data
                                                    as DocumentSnapshot;

                                                score += currentData.data()?[
                                                        documentList[index]
                                                            .id] ??
                                                    0;

                                                return QuizCardWidget(
                                                  title: documentList[index]
                                                      .data()?['title'],
                                                  quantityAnswered: currentData
                                                              .data()?[
                                                          documentList[index]
                                                              .id] ??
                                                      0,
                                                  totalQuestions:
                                                      documentList[index]
                                                          .data()?['questions']
                                                          .length,
                                                  onPressed: () {
                                                    if (controller.user ==
                                                        null) {
                                                      controller.getUser();
                                                      return;
                                                    }

                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChallengePage(
                                                          id: documentList[
                                                                  index]
                                                              .id,
                                                          user:
                                                              controller.user!,
                                                          title: documentList[
                                                                  index]
                                                              .data()?['title'],
                                                          questions: documentList[
                                                                  index]
                                                              .data()?[
                                                                  'questions']
                                                              .map<QuestionModel>((item) =>
                                                                  QuestionModel
                                                                      .fromMap(
                                                                          item))
                                                              .toList(),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                            }
                                          },
                                        );
                                      },
                                    );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
