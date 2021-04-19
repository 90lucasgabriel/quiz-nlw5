import 'package:flutter/material.dart';
import 'package:quiz/core/core.dart';

class AppbarWidget extends PreferredSize {
  AppbarWidget()
      : super(
          preferredSize: Size.fromHeight(250),
          child: Container(
              height: 250,
              decoration: BoxDecoration(gradient: AppGradients.linear),
              child: Container(
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
              )),
        );
}
