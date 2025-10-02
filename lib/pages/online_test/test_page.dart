import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:toeflapp/pages/online_test/test_flow_pages.dart';
import 'package:toeflapp/theme/app_colors.dart';

// [BARU] Data Model untuk merepresentasikan sebuah Test
// Ini adalah best practice untuk memisahkan data dari UI.
class TestModel {
  final String id;
  final String title;
  final String
  scheduleInfo; // Teks yang akan ditampilkan (e.g., "Available Anytime")
  final String date;
  final String time;

  TestModel({
    required this.id,
    required this.title,
    required this.scheduleInfo,
    required this.date,
    required this.time,
  });
}

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final List<TestModel> _allTests = [
    TestModel(
      id: 'p1',
      title: "TOEFL Practice Test 1",
      scheduleInfo: "Available Anytime",
      date: "Anytime",
      time: "",
    ),
    TestModel(
      id: 'p2',
      title: "TOEFL Practice Test 2",
      scheduleInfo: "Available Anytime",
      date: "Anytime",
      time: "",
    ),
    TestModel(
      id: 'moct',
      title: "Mock Test October",
      scheduleInfo: "Registration Open",
      date: "10 Oct 2025",
      time: "10:00 AM",
    ),
    TestModel(
      id: 'mnov',
      title: "Mock Test November",
      scheduleInfo: "Registration Open",
      date: "15 Nov 2025",
      time: "02:00 PM",
    ),
  ];

  // [BARU] State untuk melacak ID tes yang sudah didaftarkan oleh pengguna.
  final Set<String> _registeredTestIds = {};

  // [BARU] Method untuk menangani proses registrasi
  void _registerForTest(TestModel test) {
    setState(() {
      _registeredTestIds.add(test.id);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Berhasil mendaftar untuk: ${test.title}"),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // [BARU] Menampilkan dialog konfirmasi sebelum registrasi
  void _showRegistrationConfirmation(BuildContext context, TestModel test) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: const Color(0xffF5EFE6),
          title: Text(
            "Konfirmasi Pendaftaran",
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            "Anda yakin ingin mendaftar untuk test '${test.title}'?",
          ),
          actions: [
            TextButton(
              child: const Text(
                "Batal",
                style: TextStyle(color: Colors.black54),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Ya, Daftar",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _registerForTest(test);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // [BARU] Memfilter daftar tes secara dinamis berdasarkan state pendaftaran
    final availableTests = _allTests
        .where((test) => !_registeredTestIds.contains(test.id))
        .toList();
    final scheduledTests = _allTests
        .where((test) => _registeredTestIds.contains(test.id))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xffF5EFE6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.primary, AppColors.accent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: const Text(
            "Test Online",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔹 Section Daftar Test
            const SectionHeader(
              title: "Daftar Test",
              icon: Iconsax.document_text5,
            ),
            const SizedBox(height: 16),
            // [UBAH] Menggunakan list dinamis, tampilkan pesan jika kosong
            if (availableTests.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 32.0),
                  child: Text(
                    "Tidak ada test yang tersedia saat ini.",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              )
            else
              ...availableTests
                  .map((test) => _buildAvailableTestTile(context, test))
                  .toList(),

            const SizedBox(height: 32),

            // 🔹 Section Jadwal Test Saya
            const SectionHeader(
              title: "Jadwal Test Saya", // [UBAH] Judul lebih personal
              icon: Iconsax.calendar_25,
            ),
            const SizedBox(height: 16),
            // [UBAH] Menggunakan list dinamis, tampilkan pesan jika kosong
            if (scheduledTests.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 32.0),
                  child: Text(
                    "Anda belum mendaftar test apapun.",
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
              )
            else
              ...scheduledTests
                  .map((test) => _buildScheduledTestTile(context, test))
                  .toList(),

            const SizedBox(height: 56),
          ],
        ),
      ),
    );
  }

  // [UBAH] Widget ini sekarang untuk tes yang TERSEDIA dan memicu pendaftaran
  // [UBAH] Widget ini sekarang untuk tes yang TERSEDIA dan memicu pendaftaran
  Widget _buildAvailableTestTile(BuildContext context, TestModel test) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xffF5EFE6), Color(0xffE8DFCA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: const Color.fromARGB(255, 120, 158, 193),
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 12,
        ),
        leading: const AppIcon(
          icon: Iconsax.document_text5,
          iconColor: Colors.white,
          backgroundColor: Color.fromARGB(255, 80, 113, 149),
        ),
        title: Text(
          test.title,
          style: const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          test.scheduleInfo,
          style: const TextStyle(color: Colors.black54, fontSize: 13),
        ),
        // [UBAH] Mengganti Icon dengan Button "Daftar"
        trailing: GestureDetector(
          onTap: () {
            // Panggil dialog konfirmasi saat tombol ditekan
            _showRegistrationConfirmation(context, test);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.accent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(99),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Text(
              'Daftar',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),
        // [HAPUS] onTap pada ListTile dinonaktifkan agar hanya tombol yang berfungsi
        onTap: null,
      ),
    );
  }

  // [UBAH] Widget ini sekarang untuk tes yang SUDAH DIDAFTAR dan memulai tes
  Widget _buildScheduledTestTile(BuildContext context, TestModel test) {
    return InkWell(
      onTap: () {
        // [UBAH] Arahkan ke halaman detail test dari jadwal yang sudah terdaftar
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TestDetailPage(testTitle: test.title),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xffF5EFE6),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xffCBDCEB), width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            const AppIcon(
              icon: Iconsax.calendar_tick, // [UBAH] Icon lebih relevan
              backgroundColor: AppColors.primary,
              iconColor: Colors.white,
              isCircle: true,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    test.title,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        test.date,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 13,
                        ),
                      ),
                      if (test.time.isNotEmpty) const SizedBox(width: 8),
                      if (test.time.isNotEmpty)
                        Text(
                          test.time,
                          style: const TextStyle(
                            color: Color.fromARGB(255, 41, 59, 81),
                            fontSize: 13,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const Icon(Iconsax.arrow_right_3, color: Colors.black54),
          ],
        ),
      ),
    );
  }
}

/// 🔹 Komponen Icon Reusable (Tidak ada perubahan)
class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final bool isCircle;

  const AppIcon({
    super.key,
    required this.icon,
    this.backgroundColor = const Color(0xffCBDCEB),
    this.iconColor = AppColors.primary,
    this.isCircle = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: isCircle ? null : BorderRadius.circular(12),
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
      ),
      child: Icon(icon, color: iconColor, size: 22),
    );
  }
}

/// 🔹 Komponen Header Section (Tidak ada perubahan)
class SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;

  const SectionHeader({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppIcon(icon: icon),
        const SizedBox(width: 8),
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}
