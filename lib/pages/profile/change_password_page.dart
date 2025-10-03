import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:toeflapp/pages/profile/profile_text_field.dart';
import 'package:toeflapp/theme/app_colors.dart';
import 'package:toeflapp/view_models/auth_view_model.dart';
import 'package:toeflapp/widgets/app_button.dart';
import 'package:toeflapp/widgets/error_view.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPasswordControlller = TextEditingController();
  final TextEditingController _newPasswordControlller = TextEditingController();
  final TextEditingController _cNewPasswordControlller =
      TextEditingController();

  bool _loading = false;
  String? _error;

  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Password cannot be empty";
    }
    if (_newPasswordControlller.text != _cNewPasswordControlller.text) {
      return "Kedua password tidak sama";
    }
    return null;
  }

  void _submitUpdatePassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
      _error = null;
    });

    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final oldPassword = _oldPasswordControlller.text;
    final newPassword = _newPasswordControlller.text;
    final error = await context.read<AuthViewModel>().updatePassword(
      oldPassword,
      newPassword,
    );

    if (error == null) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text("Password changed!"),
          backgroundColor: Colors.green,
        ),
      );
      navigator.pop();
    }

    setState(() {
      _loading = false;
      _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EFE6),
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: AppColors.primary,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(height: 24),
              Center(child: ErrorView(error: _error)),

              ProfileTextField(
                controller: _oldPasswordControlller,
                icon: Iconsax.lock,
                label: "Old Password",
                textInputAction: TextInputAction.next,
                isPassword: true,
              ),
              const SizedBox(height: 16),
              ProfileTextField(
                controller: _newPasswordControlller,
                icon: Iconsax.lock,
                label: "New Password",
                textInputAction: TextInputAction.next,
                validator: _passwordValidator,
                isPassword: true,
              ),
              const SizedBox(height: 16),
              ProfileTextField(
                controller: _cNewPasswordControlller,
                icon: Iconsax.lock,
                label: "Confirm New Password",
                validator: _passwordValidator,
                isPassword: true,
              ),
              const SizedBox(height: 24),

              // 🔹 Save Button
              AppButton(
                onPressed: _submitUpdatePassword,
                icon: Iconsax.save_2,
                label: "Update Password",
                loading: _loading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
