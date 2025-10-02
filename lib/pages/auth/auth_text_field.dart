import 'package:flutter/material.dart';
import 'package:toeflapp/theme/app_colors.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField({
    super.key,
    required this.icon,
    required this.hint,
    this.isPassword = false,
    this.keyboardType,
    required this.controller,
    this.validator,
  });

  final TextEditingController controller;
  final IconData icon;
  final String hint;
  final bool isPassword;
  final TextInputType? keyboardType;
  final String? Function(String? value)? validator;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool _show = false;

  String? _defaultValiator(String? value) {
    if (value == null || value.isEmpty) {
      return "${widget.hint} tidak boleh kosong";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Stack(
        children: [
          TextFormField(
            controller: widget.controller,
            obscureText: widget.isPassword && !_show,
            style: TextStyle(color: AppColors.primary),
            keyboardType: widget.keyboardType,
            validator: widget.validator ?? _defaultValiator,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: const TextStyle(color: AppColors.primary),
              prefixIcon: Icon(widget.icon, color: AppColors.primary),
              filled: true,
              fillColor: Colors.white12,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: const BorderSide(color: Colors.white),
              ),
            ),
          ),
          if (widget.isPassword)
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                onPressed: () => setState(() => _show = !_show),
                icon: Icon(
                  _show
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
