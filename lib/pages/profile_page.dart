import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:toeflapp/pages/auth/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: const Text(
            "Profile 👤",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white, // dummy, ketimpa shader
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 100, 16, 24),
        children: [
          // 🔹 Header User
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
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
                children: const [
                  Text(
                    "John Doe",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "johndoe@email.com",
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          // 🔹 Progress Section
          Text("Progress", style: theme.textTheme.titleMedium),
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
          Text("Riwayat", style: theme.textTheme.titleMedium),
          const SizedBox(height: 12),
          _historyCard("Reading Test 1", "Score: 85", Iconsax.document_text),
          _historyCard("Listening Test 2", "Score: 90", Iconsax.headphone),
          _historyCard("Speaking Topic 5", "Completed", Iconsax.microphone),

          const SizedBox(height: 16),

          // 🔹 Logout
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
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
          colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(title, style: const TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }

  Widget _historyCard(String title, String subtitle, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFEFF3FF),
          child: Icon(icon, color: const Color(0xFF2575FC)),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Iconsax.arrow_right_3),
        onTap: () {}, // TODO: lihat detail
      ),
    );
  }
}
