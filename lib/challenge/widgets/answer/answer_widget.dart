import 'package:flutter/material.dart';

import 'package:quiz/core/core.dart';
import 'package:quiz/shared/models/answer_model.dart';

class AnswerWidget extends StatelessWidget {
  final AnswerModel answer;
  final VoidCallback onPressed;
  final bool disabled;
  final bool isSelected;

  AnswerWidget({
    required this.answer,
    required this.onPressed,
    this.disabled = false,
    this.isSelected = false,
  });

  Color get _selectedColorRight =>
      answer.isRight ? AppColors.darkGreen : AppColors.darkRed;

  Color get _selectedBorderRight =>
      answer.isRight ? AppColors.lightGreen : AppColors.lightRed;

  Color get _selectedColorCardRight =>
      answer.isRight ? AppColors.lightGreen : AppColors.lightRed;

  Color get _selectedBorderCardRight =>
      answer.isRight ? AppColors.green : AppColors.red;

  TextStyle get _selectedTextStyleRight =>
      answer.isRight ? AppTextStyles.bodyDarkGreen : AppTextStyles.bodyDarkRed;

  IconData get _selectedIconRight => answer.isRight ? Icons.check : Icons.close;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: disabled,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isSelected ? _selectedColorCardRight : AppColors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.fromBorderSide(
              BorderSide(
                  color:
                      isSelected ? _selectedBorderCardRight : AppColors.border),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  answer.title,
                  style:
                      isSelected ? _selectedTextStyleRight : AppTextStyles.body,
                ),
              ),
              Container(
                  width: 24,
                  height: 24,
                  child: isSelected
                      ? Icon(
                          _selectedIconRight,
                          size: 16,
                          color: AppColors.white,
                        )
                      : null,
                  decoration: BoxDecoration(
                    color: isSelected ? _selectedColorRight : AppColors.white,
                    borderRadius: BorderRadius.circular(50),
                    border: Border.fromBorderSide(
                      BorderSide(
                          color: isSelected
                              ? _selectedBorderRight
                              : AppColors.border),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
