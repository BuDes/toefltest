import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:toeflapp/pages/auth/login_page.dart';
import 'package:toeflapp/pages/edit_profile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
        padding: const EdgeInsets.fromLTRB(16, 60, 16, 24),
        children: [
          // 🔹 Header User
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6D94C5), Color(0xffffa97a)],
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
                          Color(0xFF6D94C5), // Starting color
                          Color(0xffffa97a), // Ending color
                          // You can add more colors to the list
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ).createShader(bounds);
                    },
                    child: const Text(
                      "User Name",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors
                            .white, // The color here doesn't matter, but it's good practice to set it to a solid color like white to avoid rendering issues.
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "userexample@email.com",
                    style: TextStyle(color: Colors.black54),
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
                    child: Row(
                      children: const [
                        Icon(Iconsax.edit, size: 16, color: Color(0xFF6D94C5)),
                        SizedBox(width: 6),
                        Text(
                          "Edit Profile",
                          style: TextStyle(
                            color: Color(0xFF6D94C5),
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
          Text(
            "Progress",
            style: theme.textTheme.titleMedium?.copyWith(
              color: const Color(0xFF6D94C5),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: _progressCard("Materi", "12", Iconsax.book)),
              const SizedBox(width: 12),
              Expanded(child: _progressCard("Test", "3", Iconsax.task_square)),
            ],
          ),

          const SizedBox(height: 16),

          // 🔹 History Section
          Text(
            "Riwayat",
            style: theme.textTheme.titleMedium?.copyWith(
              color: const Color(0xFF6D94C5),
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          _historyCard("Reading Test 1", "Score: 85", Iconsax.document_text),
          _historyCard("Listening Test 2", "Score: 90", Iconsax.headphone),
          _historyCard("Speaking Topic 5", "Completed", Iconsax.microphone),

          const SizedBox(height: 16),

          // 🔹 Logout
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6D94C5), // 🎨 warna utama
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false,
              );
            },
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
          colors: [Color(0xFF6D94C5), Color(0xFFCBDCEB)], // 🎨 gradasi lembut
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 6),
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

  Widget _historyCard(String title, String subtitle, IconData icon) {
    return Card(
      color: const Color(0xFFE8DFCA), // 🌿 sesuai palet, bukan putih polos
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      // elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFCBDCEB),
          child: Icon(icon, color: const Color(0xFF6D94C5)),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.black54)),
        trailing: const Icon(Iconsax.arrow_right_3, color: Colors.black45),
        onTap: () {}, // TODO: lihat detail
      ),
    );
  }
}
