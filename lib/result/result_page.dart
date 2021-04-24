import 'package:flutter/material.dart';
import 'package:quiz/challenge/widgets/next_button/next_button_widget.dart';
import 'package:quiz/core/core.dart';

class ResultPage extends StatelessWidget {
  final String title;
  final int totalQuestions;

  const ResultPage({
    Key? key,
    required this.title,
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
                        text: '\ncom 6 de $totalQuestions acertos.',
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
                          onPressed: () {},
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
