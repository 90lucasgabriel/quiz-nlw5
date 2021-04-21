import 'package:quiz/shared/models/question_model.dart';

enum Level { facil, medio, dificil, perito }

class QuizModel {
  final String title;
  final int quantityAnswered;
  final String image;
  final Level level;
  final List<QuestionModel> questions;

  QuizModel({
    required this.title,
    this.quantityAnswered = 0,
    required this.image,
    required this.level,
    required this.questions,
  });
}
