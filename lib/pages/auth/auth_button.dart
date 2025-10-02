import 'package:flutter/material.dart';
import 'package:toeflapp/theme/app_colors.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.loading = false,
  });

  final String text;
  final void Function() onPressed;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: loading ? Colors.white54 : Colors.white,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(
            vertical: 18,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: const BorderSide(
              color: AppColors.primary,
              width: 1,
            ),
          ),
          elevation: 0,
        ),
        onPressed: loading ? () {} : onPressed,
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
