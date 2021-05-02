import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:quiz/core/core.dart';
import 'package:quiz/shared/models/user_model.dart';
import 'package:quiz/home/widgets/score_card/score_card_widget.dart';
import 'package:quiz/home/widgets/score_card/score_card_skeleton_widget.dart';

class AppbarWidget extends StatefulWidget {
  final UserModel? user;
  final VoidCallback loginAction;
  final VoidCallback logoutAction;

  AppbarWidget(
      {Key? key,
      required this.user,
      required this.loginAction,
      required this.logoutAction})
      : super(key: key);

  @override
  _AppbarWidgetState createState() => _AppbarWidgetState();
}

class _AppbarWidgetState extends State<AppbarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        height: 270,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(gradient: AppGradients.linear),
              child: Container(
                height: 181,
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        widget.user?.photoUrl != null
                            ? Container(
                                width: 58,
                                height: 58,
                                margin: EdgeInsets.only(right: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  image: DecorationImage(
                                    image: NetworkImage(widget.user!.photoUrl),
                                  ),
                                ),
                              )
                            : GestureDetector(
                                onTap: widget.loginAction,
                                child: Container(
                                  width: 58,
                                  height: 58,
                                  margin: EdgeInsets.only(right: 8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    color: AppColors.white,
                                    size: 58,
                                  ),
                                ),
                              ),
                        GestureDetector(
                          onTap: widget.user?.name == null
                              ? widget.loginAction
                              : null,
                          child: Text.rich(
                            TextSpan(
                              text: 'Olá, ',
                              style: AppTextStyles.title,
                              children: [
                                TextSpan(
                                    text: widget.user?.name ?? 'visitante',
                                    style: AppTextStyles.titleBold),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    widget.user?.uid != null
                        ? IconButton(
                            icon: Icon(Icons.logout),
                            color: AppColors.white,
                            onPressed: widget.logoutAction,
                          )
                        : OutlinedButton(
                            onPressed: widget.loginAction,
                            child: Text(
                              'Entrar',
                              style: TextStyle(color: AppColors.white),
                            ),
                          )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment(0, 1),
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('userScore')
                    .doc(widget.user?.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return ScoreCardSkeletonWidget();
                    default:
                      var currentData = snapshot.data as DocumentSnapshot;
                      double score = 0.0;
                      currentData
                          .data()
                          ?.forEach((key, value) => score += value);

                      return StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('quiz')
                            .snapshots(),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.waiting:
                              return Container();
                            default:
                              double totalQuestions = 0.0;
                              List<DocumentSnapshot> documentList =
                                  snapshot.data?.docs.toList() ?? [];

                              documentList.forEach((element) {
                                totalQuestions +=
                                    element.data()?['questions'].length ?? 0;
                              });

                              if (totalQuestions == 0.0) totalQuestions = 1.0;

                              return ScoreCardWidget(
                                value: (score / totalQuestions * 100)
                                    .toInt()
                                    .toDouble(),
                              );
                          }
                        },
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
