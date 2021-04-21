import 'package:flutter/material.dart';
import 'package:quiz/core/core.dart';
import 'package:quiz/home/widgets/score_card/score_card_widget.dart';

class AppbarWidget extends PreferredSize {
  AppbarWidget()
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
                        Text.rich(
                          TextSpan(
                            text: 'Olá, ',
                            style: AppTextStyles.title,
                            children: [
                              TextSpan(
                                  text: 'Lucas Gabriel',
                                  style: AppTextStyles.titleBold),
                            ],
                          ),
                        ),
                        Container(
                          width: 58,
                          height: 58,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://avatars.githubusercontent.com/u/9625765?v=4'),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment(0, 1),
                  child: ScoreCardWidget(),
                ),
              ],
            ),
          ),
        );
}
