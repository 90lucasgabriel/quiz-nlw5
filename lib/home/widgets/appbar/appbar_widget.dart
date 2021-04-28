import 'package:flutter/material.dart';

import 'package:quiz/core/core.dart';
import 'package:quiz/home/home_controller.dart';
import 'package:quiz/shared/models/user_model.dart';
import 'package:quiz/home/widgets/score_card/score_card_widget.dart';

class AppbarWidget extends PreferredSize {
  final UserModel? user;
  final VoidCallback loginAction;
  final VoidCallback logoutAction;

  AppbarWidget(
      {required this.user,
      required this.loginAction,
      required this.logoutAction})
      : super(
          preferredSize: Size.fromHeight(250),
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
                            user?.photoUrl != null
                                ? Container(
                                    width: 58,
                                    height: 58,
                                    margin: EdgeInsets.only(right: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      image: DecorationImage(
                                        image: NetworkImage(user!.photoUrl),
                                      ),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: loginAction,
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
                              onTap: user?.name == null ? loginAction : null,
                              child: Text.rich(
                                TextSpan(
                                  text: 'Olá, ',
                                  style: AppTextStyles.title,
                                  children: [
                                    TextSpan(
                                        text: user?.name ?? 'visitante',
                                        style: AppTextStyles.titleBold),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        user?.uid != null
                            ? IconButton(
                                icon: Icon(Icons.logout),
                                color: AppColors.white,
                                onPressed: logoutAction,
                              )
                            : OutlinedButton(
                                onPressed: loginAction,
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
                  child: ScoreCardWidget(value: user?.score!.toDouble() ?? 0),
                ),
              ],
            ),
          ),
        );
}
