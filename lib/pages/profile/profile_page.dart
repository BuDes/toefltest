import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:toeflapp/models/riwayat.dart';
import 'package:toeflapp/pages/auth/login_page.dart';
import 'package:toeflapp/pages/materials/materi_content_page.dart';
import 'package:toeflapp/widgets/test_result_page.dart';
import 'package:toeflapp/pages/profile/edit_profile.dart';
import 'package:toeflapp/theme/app_colors.dart';
import 'package:toeflapp/view_models/auth_view_model.dart';
import 'package:toeflapp/view_models/riwayat_view_model.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _logout(BuildContext context) {
    context.read<AuthViewModel>().logout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
      (route) => false,
    );
  }

  void _handleDetailRiwayat(BuildContext context, Riwayat riwayat) {
    final navigator = Navigator.of(context);
    if (riwayat.materi != null) {
      navigator.push(
        MaterialPageRoute(
          builder: (context) => MateriContentPage(materi: riwayat.materi!),
        ),
      );
      return;
    }
    if (riwayat.jadwal != null) {
      navigator.push(
        MaterialPageRoute(
          builder: (context) {
            return TestResultPage(idJadwal: riwayat.jadwal!.id);
          },
        ),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final user = context.watch<AuthViewModel>().currentUser!;
    final riwayatVM = context.watch<RiwayatViewModel>();
    final jlhMateri = riwayatVM.jlhMateri;
    final jlhTest = riwayatVM.jlhTest;
    final listRiwayat = riwayatVM.top3;

    return Scaffold(
      backgroundColor: const Color(0xFFF5EFE6), // 🌿 warna background global
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 60, 16, 100),
        children: [
          // 🔹 Header User
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.primary, AppColors.accent],
                  ),
                  shape: BoxShape.circle,
                ),
                child: const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(Iconsax.user, size: 40, color: Colors.black54),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShaderMask(
                    // The gradient is applied to the child widget
                    shaderCallback: (Rect bounds) {
                      return const LinearGradient(
                        colors: [
                          AppColors.primary, // Starting color
                          AppColors.accent, // Ending color
                          // You can add more colors to the list
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds);
                    },
                    child: Text(
                      user.name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors
                            .white, // The color here doesn't matter, but it's good practice to set it to a solid color like white to avoid rendering issues.
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.email,
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const EditProfilePage(),
                        ),
                      );
                    },
                    child: const Row(
                      children: [
                        Icon(Iconsax.edit, size: 16, color: AppColors.primary),
                        SizedBox(width: 6),
                        Text(
                          "Edit Profile",
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          // 🔹 Progress Section
          // Text(
          //   "Progress",
          //   style: theme.textTheme.titleMedium?.copyWith(
          //     color: AppColors.primary,
          //     fontWeight: FontWeight.w700,
          //   ),
          // ),
          // const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _progressCard(
                  "Materi",
                  jlhMateri.toString(),
                  Iconsax.book,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _progressCard(
                  "Test",
                  jlhTest.toString(),
                  Iconsax.task_square,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // 🔹 History Section
          Text(
            "Riwayat",
            style: theme.textTheme.titleMedium?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          if (listRiwayat.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "Anda belum ada riwayat test atau pembelajaran",
                style: TextStyle(color: Colors.grey, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ...List.generate(listRiwayat.length, (index) {
            final riwayat = listRiwayat[index];
            return _historyCard(context, riwayat);
          }),

          // _historyCard("Reading Test 1", "12:00", Iconsax.document_text),
          // _historyCard("Listening Test 2", "02/10/2025", Iconsax.headphone),
          // _historyCard("Speaking Topic 5", "01/10/2025", Iconsax.microphone),
          const SizedBox(height: 16),

          // 🔹 Logout
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary, // 🎨 warna utama
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
            ),
            onPressed: () => _logout(context),
            icon: const Icon(Iconsax.logout, color: Colors.white),
            label: const Text(
              "Logout",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _progressCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, Color(0xFFCBDCEB)], // 🎨 gradasi lembut
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 6),
          ),
        ],
        border: Border.all(
          color: const Color.fromARGB(255, 205, 228, 255),
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 32),
          const SizedBox(width: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Text(title, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _historyCard(BuildContext context, Riwayat riwayat) {
    final title =
        riwayat.materi?.nama ?? riwayat.jadwal?.nama ?? "Practice Test";
    final subtitle = riwayat.tanggal;
    final icon = riwayat.materi != null ? Iconsax.book : Iconsax.task_square;
    final isPractice = riwayat.materi == null && riwayat.jadwal == null;

    return Card(
      color: const Color(0xFFE8DFCA), // 🌿 sesuai palet, bukan putih polos
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      // elevation: 2,
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFCBDCEB),
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.black54)),
        trailing: isPractice
            ? null
            : const Icon(Iconsax.arrow_right_3, color: Colors.black45),
        onTap: isPractice ? null : () => _handleDetailRiwayat(context, riwayat),
      ),
    );
  }
}
