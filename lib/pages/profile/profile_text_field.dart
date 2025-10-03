import 'package:flutter/material.dart';
import 'package:toeflapp/theme/app_colors.dart';

class ProfileTextField extends StatefulWidget {
  const ProfileTextField({
    super.key,
    required this.controller,
    required this.icon,
    required this.label,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.isPassword = false,
  });

  final TextEditingController controller;
  final IconData icon;
  final String label;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String? value)? validator;
  final bool isPassword;

  @override
  State<ProfileTextField> createState() => _ProfileTextFieldState();
}

class _ProfileTextFieldState extends State<ProfileTextField> {
  bool _show = false;

  String? _defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "${widget.label} cannot be empty";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword && !_show,
          decoration: InputDecoration(
            labelText: widget.label,
            prefixIcon: Icon(widget.icon),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppColors.primary, // warna border default
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: AppColors.accent, // 🎨 warna saat fokus
                width: 2,
              ),
            ),
          ),
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          validator: widget.validator ?? _defaultValidator,
        ),
        if (widget.isPassword)
          Positioned(
            right: 0,
            top: 4,
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
    );
  }
}
