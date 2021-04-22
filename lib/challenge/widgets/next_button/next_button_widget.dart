import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz/core/app_colors.dart';

class NextButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  final Color _backgroundColor;
  final Color _fontColor;
  final Color _borderColor;

  NextButtonWidget.green({
    required String label,
    required VoidCallback onPressed,
  })   : this._backgroundColor = AppColors.darkGreen,
        this._fontColor = AppColors.white,
        this._borderColor = AppColors.darkGreen,
        this.label = label,
        this.onPressed = onPressed;

  NextButtonWidget.white({
    required String label,
    required VoidCallback onPressed,
  })   : this._backgroundColor = AppColors.white,
        this._fontColor = AppColors.grey,
        this._borderColor = AppColors.border,
        this.label = label,
        this.onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(_backgroundColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          side: MaterialStateProperty.all(
            BorderSide(color: _borderColor),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: GoogleFonts.notoSans(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            color: _fontColor,
          ),
        ),
      ),
    );
  }
}
