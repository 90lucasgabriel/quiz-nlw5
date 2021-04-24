import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import 'package:quiz/core/core.dart';
import 'package:quiz/challenge/widgets/next_button/next_button_widget.dart';

class ResultPage extends StatelessWidget {
  final String title;
  final int totalRightAnswers;
  final int totalQuestions;

  const ResultPage({
    Key? key,
    required this.title,
    required this.totalRightAnswers,
    required this.totalQuestions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 32),
                  child: Image.asset(AppImages.trophy),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 16),
                  child: Text(
                    'Parabéns!',
                    style: AppTextStyles.heading40,
                  ),
                ),
                Text.rich(
                  TextSpan(
                    text: 'Você concluiu',
                    style: AppTextStyles.body,
                    children: [
                      TextSpan(
                        text: '\n$title',
                        style: AppTextStyles.bodyBold,
                      ),
                      TextSpan(
                        text:
                            '\ncom $totalRightAnswers de $totalQuestions acertos.',
                        style: AppTextStyles.body,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: NextButtonWidget.purple(
                          label: 'Compartilhar',
                          onPressed: () {
                            Share.share(
                                'Resultado do quiz $title:\n${totalRightAnswers / totalQuestions}% de aproveitamento.\n\nhttps://github.com/90lucasgabriel/quiz-nlw5');
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 32),
                        child: NextButtonWidget.transparent(
                          label: 'Voltar ao início',
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
