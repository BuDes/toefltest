import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:toeflapp/pages/profile/change_password_page.dart';
import 'package:toeflapp/pages/profile/profile_text_field.dart';
import 'package:toeflapp/theme/app_colors.dart';
import 'package:toeflapp/view_models/auth_view_model.dart';
import 'package:toeflapp/widgets/app_button.dart';
import 'package:toeflapp/widgets/error_view.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late final AuthViewModel _authVM;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  // TODO: change password page
  // final TextEditingController _passwordController = TextEditingController();

  bool _loading = false;
  String? _error;

  void _submitEditProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
      _error = null;
    });

    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final error = await _authVM.updateProfile(
      name,
      email,
    );

    if (error == null) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text("Profile updated successfully!"),
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
  void initState() {
    super.initState();
    _authVM = context.read<AuthViewModel>();
    final user = _authVM.currentUser!;
    _nameController.text = user.name;
    _emailController.text = user.email;
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
              // 🔹 Avatar dengan tombol ubah foto
              Center(
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.primary, AppColors.accent],
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Icon(Iconsax.user, size: 50, color: Colors.black54),
                  ),
                ),
              ),

              const SizedBox(height: 24),
              Center(child: ErrorView(error: _error)),

              // 🔹 Nama
              ProfileTextField(
                controller: _nameController,
                icon: Iconsax.user,
                label: "Full Name",
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
              ),

              const SizedBox(height: 16),

              // 🔹 Email
              ProfileTextField(
                controller: _emailController,
                icon: Iconsax.sms,
                label: "Email",
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 32),

              // 🔹 Password Button
              AppButton(
                onPressed: _submitEditProfile,
                icon: Iconsax.save_2,
                label: "Save Changes",
                loading: _loading,
              ),
              const SizedBox(height: 8),
              // 🔹 Save Button
              AppButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChangePasswordPage(),
                    ),
                  );
                },
                icon: Iconsax.lock,
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
