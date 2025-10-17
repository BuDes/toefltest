import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:toeflapp/models/jadwal.dart';
import 'package:toeflapp/models/soal.dart';
import 'package:toeflapp/models/test_section.dart';
import 'package:toeflapp/theme/app_colors.dart';
import 'package:toeflapp/utils/app_constants.dart';
import 'package:toeflapp/view_models/materi_view_model.dart';
import 'package:toeflapp/view_models/riwayat_view_model.dart';
import 'package:toeflapp/view_models/test_view_model.dart';
import 'package:toeflapp/widgets/test_result_page.dart';

// --- Reusable Widgets (Tidak ada perubahan di sini) ---
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

// --- MOCK DATA (Tidak ada perubahan) ---
// enum TestSection { reading, listening, writing, structure }

// class Question {
//   final String id;
//   final String text;
//   final List<String> options;
//   final int correctAnswerIndex;

//   Question({
//     required this.id,
//     required this.text,
//     required this.options,
//     required this.correctAnswerIndex,
//   });
// }

// class MockData {
//   static final Map<TestSection, List<Question>> questions = {
//     TestSection.reading: [
//       Question(
//         id: 'r_1',
//         text: 'What is the main topic of the first paragraph?',
//         options: [
//           'History of solar power',
//           'Benefits of renewable energy',
//           'Challenges of wind energy',
//           'Global climate change',
//         ],
//         correctAnswerIndex: 1,
//       ),
//       Question(
//         id: 'r_2',
//         text:
//             'According to the text, which country is a leader in solar energy production?',
//         options: ['United States', 'China', 'Germany', 'Australia'],
//         correctAnswerIndex: 2,
//       ),
//     ],
//     TestSection.listening: [
//       Question(
//         id: 'l_1',
//         text: 'What is the speaker\'s opinion on the new library policy?',
//         options: [
//           'They are in favor of it',
//           'They are against it',
//           'They are indifferent',
//           'They do not mention it',
//         ],
//         correctAnswerIndex: 0,
//       ),
//       Question(
//         id: 'l_2',
//         text: 'What time is the meeting scheduled?',
//         options: ['9:00 AM', '10:30 AM', '1:00 PM', '2:00 PM'],
//         correctAnswerIndex: 3,
//       ),
//     ],
//     TestSection.writing: [
//       Question(
//         id: 'w_1',
//         text: 'Write an essay discussing the pros and cons of remote work.',
//         options: [],
//         correctAnswerIndex: -1,
//       ),
//     ],
//     TestSection.structure: [
//       Question(
//         id: 'st_1',
//         text: 'The committee has met and _______.',
//         options: [
//           'they reached a decision',
//           'it has reached a decision',
//           'its decision was reached',
//           'it reached a decision',
//         ],
//         correctAnswerIndex: 1,
//       ),
//       Question(
//         id: 'st_2',
//         text:
//             'Not until a student has mastered algebra _______ the principles of geometry.',
//         options: [
//           'he can begin to understand',
//           'can he begin to understand',
//           'he begins to understand',
//           'begins to understand',
//         ],
//         correctAnswerIndex: 1,
//       ),
//     ],
//   };
// }

// --- PAGES & WIDGETS (Tidak ada perubahan)---

class TestDetailPage extends StatelessWidget {
  final Jadwal jadwal;

  const TestDetailPage({super.key, required this.jadwal});

  String formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);

    List<String> parts = [];

    if (hours > 0) {
      parts.add('$hours hour${hours == 1 ? '' : 's'}');
    }

    if (minutes > 0 || hours == 0) {
      parts.add('$minutes minute${minutes == 1 ? '' : 's'}');
    }

    return parts.join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final listJenis = context.read<MateriViewModel>().jenis;
    final durasi = AppConstants.testSectionDuration * listJenis.length;
    final namaJenis = listJenis.map((e) => e.nama);
    final formatString = namaJenis.join(", ");

    return Scaffold(
      backgroundColor: const Color(0xffF5EFE6),
      appBar: AppBar(
        title: Text(
          jadwal.nama,
          style: const TextStyle(
            color: AppColors.primary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Test Overview Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xffCBDCEB), width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SectionHeader(
                    title: "Test Details",
                    icon: Iconsax.document_text5,
                  ),
                  const SizedBox(height: 16),
                  _buildDetailRow(
                    Iconsax.clock,
                    "Duration",
                    formatDuration(durasi),
                  ),
                  _buildDetailRow(
                    Iconsax.calendar_1,
                    "Date",
                    "Available Anytime",
                  ),
                  _buildDetailRow(
                    Iconsax.document,
                    "Format",
                    formatString,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "This practice test is designed to simulate the real TOEFL exam. It covers all four key sections and helps you familiarize yourself with the format, timing, and question types. It's an excellent tool for self-assessment.",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black54,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Start Test Button
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return TestPreparationPage(jadwal: jadwal);
                    },
                  ),
                );
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.accent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Text(
                  "Start Test",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: AppColors.accent, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(fontSize: 13, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- TEST PREPARATION PAGE ---

class TestPreparationPage extends StatelessWidget {
  final Jadwal jadwal;

  const TestPreparationPage({
    super.key,
    required this.jadwal,
  });

  void _startTest(BuildContext context) async {
    final testVM = context.read<TestViewModel>();
    final navigator = Navigator.of(context);
    final sections = await testVM.getRealTest();
    if (sections == null) return;
    navigator.push(
      MaterialPageRoute(
        builder: (context) {
          return TestPageContainer(
            jadwal: jadwal,
            sections: sections,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5EFE6),
      appBar: AppBar(
        title: const Text(
          "Get Ready!",
          style: TextStyle(
            color: AppColors.primary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primary),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Important things to check before you start the test.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
            _buildPreparationItem(
              icon: Iconsax.monitor,
              title: "Check Your Connection",
              description:
                  "Ensure you have a stable internet connection for a smooth test experience.",
            ),
            _buildPreparationItem(
              icon: Iconsax.headphone,
              title: "Headphones Required",
              description:
                  "Make sure your headphones are working properly for the Listening section.",
            ),
            _buildPreparationItem(
              icon: Iconsax.document_1,
              title: "Find a Quiet Place",
              description:
                  "Choose a quiet environment to focus without interruptions.",
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _startTest(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: AppColors.accent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "I'm Ready, Start Test Now!",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreparationItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xffCBDCEB), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          AppIcon(
            icon: icon,
            backgroundColor: const Color(0xffE8DFCA),
            iconColor: AppColors.primary,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// --- MAIN TEST CONTAINER (Tidak ada perubahan) ---
class TestPageContainer extends StatefulWidget {
  final Jadwal jadwal;
  final List<TestSection> sections;

  const TestPageContainer({
    super.key,
    required this.sections,
    required this.jadwal,
  });

  @override
  State<TestPageContainer> createState() => _TestPageContainerState();
}

class _TestPageContainerState extends State<TestPageContainer> {
  final PageController _pageController = PageController();
  int _currentSectionIndex = 0;

  late Timer _timer;
  int _start = AppConstants.testSectionDuration.inSeconds;

  Map<String, String?> get _selectedAnswers {
    return context.read<TestViewModel>().currentAnswers;
  }

  // final Map<TestSection, int> _sectionDurations = {
  //   TestSection.reading: 900,
  //   TestSection.listening: 900,
  //   TestSection.writing: 1200,
  //   TestSection.structure: 900,
  // };

  @override
  void initState() {
    super.initState();
    // _start = _sectionDurations[_sections[_currentSectionIndex]] ?? 0;
    _startTimer();
    final allSoal = widget.sections.fold<List<Soal>>([], (v, e) {
      return [...v, ...e.soal];
    });
    for (var soal in allSoal) {
      _selectedAnswers[soal.id] = null;
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
        });
        _pageController.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeIn,
        );
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final hours = minutes ~/ 60;
    final remainingSeconds = seconds % 60;
    final remainingMinutes = minutes % 60;

    if (hours > 0) {
      return '$hours:${remainingMinutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
    }
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  String _getSectionTitle(TestSection section) {
    return section.nama;
  }

  List<TestSection> get _sections => widget.sections;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5EFE6),
      appBar: AppBar(
        title: Text(
          widget.jadwal.nama,
          style: const TextStyle(color: AppColors.primary),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Iconsax.close_circle, color: AppColors.accent),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                const Icon(Iconsax.clock, color: AppColors.primary, size: 20),
                const SizedBox(width: 4),
                Text(
                  _formatTime(_start),
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _sections.asMap().entries.map((entry) {
                int index = entry.key;
                bool isCurrent = index == _currentSectionIndex;
                bool isCompleted = index < _currentSectionIndex;

                return Expanded(
                  child: Container(
                    height: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: isCompleted
                          ? AppColors.accent
                          : isCurrent
                          ? AppColors.primary
                          : const Color(0xffCBDCEB),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              _getSectionTitle(_sections[_currentSectionIndex]),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics:
                  const NeverScrollableScrollPhysics(), // Prevent manual swiping
              itemCount: _sections.length,
              onPageChanged: (index) {
                setState(() {
                  _currentSectionIndex = index;
                  _start = AppConstants.testSectionDuration.inSeconds;
                  _timer.cancel();
                  _startTimer();
                });
              },
              itemBuilder: (context, index) {
                final section = _sections[index];
                return TestSectionWidget(
                  section: section,
                  isFirst: _currentSectionIndex == 0,
                  isLast: _currentSectionIndex + 1 == _sections.length,
                  onBack: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeIn,
                    );
                  },
                  onNext: () {
                    if (_currentSectionIndex < _sections.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeIn,
                      );
                    } else {
                      _showCompletionDialog(context);
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showCompletionDialog(BuildContext context) async {
    final navigator = Navigator.of(context);
    showDialog(
      context: context,
      builder: (_) => _CompletionDialog(idJadwal: widget.jadwal.id),
    ).then((_) {
      navigator.pop();
      navigator.pop();
      navigator.pushReplacement(
        MaterialPageRoute(
          builder: (context) => TestResultPage(
            idJadwal: widget.jadwal.id,
          ),
        ),
      );
    });
  }
}

class _CompletionDialog extends StatefulWidget {
  const _CompletionDialog({required this.idJadwal});
  final String idJadwal;

  @override
  State<_CompletionDialog> createState() => _CompletionDialogState();
}

class _CompletionDialogState extends State<_CompletionDialog> {
  bool _loading = true;

  void _submitAnswers() async {
    final testVM = context.read<TestViewModel>();
    final riwayatVM = context.read<RiwayatViewModel>();
    final answers = testVM.currentAnswers;
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);
    final error = await testVM.submitAnswers(
      answers,
      idJadwal: widget.idJadwal,
    );
    if (error != null) {
      navigator.pop();
      messenger.showSnackBar(
        SnackBar(
          content: Text(error),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    setState(() => _loading = false);
    riwayatVM.getRiwayat();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _submitAnswers();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: AppColors.primary,
            ),
          ],
        ),
      );
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: const Color(0xffF5EFE6),
      title: const Text(
        "Test Selesai!",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset('assets/images/trophy.svg', height: 80),
          const SizedBox(height: 16),
          const Text(
            "Selamat, Anda telah menyelesaikan test ini. Hasil akan tersedia di halaman profil Anda.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(
            "Lihat hasil test",
            style: TextStyle(
              color: AppColors.accent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

// --- INDIVIDUAL TEST SECTIONS WIDGETS (Tidak ada perubahan) ---
class TestSectionWidget extends StatefulWidget {
  final TestSection section;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final bool isFirst;
  final bool isLast;

  const TestSectionWidget({
    super.key,
    required this.section,
    required this.onNext,
    required this.onBack,
    required this.isFirst,
    required this.isLast,
  });

  @override
  State<TestSectionWidget> createState() => _TestSectionWidgetState();
}

class _TestSectionWidgetState extends State<TestSectionWidget> {
  // bool _isPlaying = false;
  // Timer? _audioTimer;
  // final Duration _audioDuration = const Duration(minutes: 2, seconds: 40);
  // Duration _audioPosition = Duration.zero;

  Map<String, String?> get _selectedAnswers {
    return context.read<TestViewModel>().currentAnswers;
  }

  List<Soal> get _questions => widget.section.soal;

  @override
  void dispose() {
    // _audioTimer?.cancel();
    super.dispose();
  }

  // String _formatDuration(Duration d) {
  //   String twoDigits(int n) => n.toString().padLeft(2, '0');
  //   final minutes = twoDigits(d.inMinutes.remainder(60));
  //   final seconds = twoDigits(d.inSeconds.remainder(60));
  //   return '$minutes:$seconds';
  // }

  // void _toggleAudioPlayback() {
  //   if (_isPlaying) {
  //     _audioTimer?.cancel();
  //   } else {
  //     if (_audioPosition >= _audioDuration) {
  //       _audioPosition = Duration.zero;
  //     }
  //     _audioTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //       if (_audioPosition >= _audioDuration) {
  //         timer.cancel();
  //         setState(() {
  //           _isPlaying = false;
  //         });
  //       } else {
  //         setState(() {
  //           _audioPosition += const Duration(seconds: 1);
  //         });
  //       }
  //     });
  //   }
  //   setState(() {
  //     _isPlaying = !_isPlaying;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // if (widget.section == TestSection.reading) _buildReadingSection(),
          // if (widget.section == TestSection.listening) _buildListeningSection(),
          // if (widget.section == TestSection.writing) _buildWritingSection(),
          // if (widget.section == TestSection.structure) _buildStructureSection(),
          _buildTestSection(),
          const SizedBox(height: 40),
          _buildNextButton(context),
        ],
      ),
    );
  }

  Widget _buildTestSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // _buildPassageCard(),
        const SizedBox(height: 24),
        ...List.generate(_questions.length, (index) {
          final question = _questions[index];
          return Column(
            children: [
              if (question.attachment != null) _buildAttachment(index),
              _buildQuestionCard(question, index + 1),
            ],
          );
        }),
      ],
    );
  }

  // Widget _buildReadingSection() {
  //   final readingQuestions = MockData.questions[TestSection.reading]!;
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       _buildPassageCard(),
  //       const SizedBox(height: 24),
  //       ...readingQuestions.asMap().entries.map((entry) {
  //         int index = entry.key;
  //         Question question = entry.value;
  //         return _buildQuestionCard(question, index + 1);
  //       }),
  //     ],
  //   );
  // }

  // Widget _buildPassageCard() {
  //   return Container(
  //     padding: const EdgeInsets.all(16),
  //     decoration: BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.circular(20),
  //       border: Border.all(color: const Color(0xffE8DFCA), width: 2),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.black.withOpacity(0.05),
  //           blurRadius: 8,
  //           offset: const Offset(0, 4),
  //         ),
  //       ],
  //     ),
  //     child: const Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           "Passage:",
  //           style: TextStyle(
  //             fontWeight: FontWeight.bold,
  //             fontSize: 16,
  //             color: AppColors.primary,
  //           ),
  //         ),
  //         SizedBox(height: 8),
  //         Text(
  //           "The rapid advancement of technology has profoundly impacted our daily lives, transforming how we communicate, work, and access information. From the proliferation of smartphones to the rise of artificial intelligence, these innovations have created new opportunities and challenges. However, as we embrace these changes, it's crucial to consider their social and environmental implications, particularly in areas like data privacy and sustainability.",
  //           style: TextStyle(fontSize: 14, color: Colors.black87),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _buildListeningSection() {
  //   final listeningQuestions = MockData.questions[TestSection.listening]!;
  //   return Column(
  //     children: [
  //       Container(
  //         padding: const EdgeInsets.all(20),
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(20),
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.black.withOpacity(0.05),
  //               blurRadius: 10,
  //               offset: const Offset(0, 5),
  //             ),
  //           ],
  //         ),
  //         child: Column(
  //           children: [
  //             const Text(
  //               "Now, listen to the audio and answer the questions below.",
  //               textAlign: TextAlign.center,
  //               style: TextStyle(
  //                 fontSize: 16,
  //                 color: AppColors.primary,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //             const SizedBox(height: 16),
  //             GestureDetector(
  //               onTap: _toggleAudioPlayback,
  //               child: Icon(
  //                 _isPlaying ? Iconsax.pause_circle5 : Iconsax.play_circle5,
  //                 size: 80,
  //                 color: AppColors.accent,
  //               ),
  //             ),
  //             const SizedBox(height: 8),
  //             Text(
  //               "${_formatDuration(_audioPosition)} / ${_formatDuration(_audioDuration)}",
  //               style: const TextStyle(fontSize: 12, color: Colors.black54),
  //             ),
  //           ],
  //         ),
  //       ),
  //       const SizedBox(height: 24),
  //       ...listeningQuestions.asMap().entries.map((entry) {
  //         int index = entry.key;
  //         Question question = entry.value;
  //         return _buildQuestionCard(question, index + 1);
  //       }),
  //     ],
  //   );
  // }

  // Widget _buildWritingSection() {
  //   final writingQuestion = MockData.questions[TestSection.writing]!.first;
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       _buildQuestionCard(writingQuestion, 1),
  //       const SizedBox(height: 16),
  //       Container(
  //         padding: const EdgeInsets.all(16),
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(16),
  //           border: Border.all(color: const Color(0xffCBDCEB)),
  //         ),
  //         child: const TextField(
  //           maxLines: 10,
  //           decoration: InputDecoration(
  //             hintText: "Start writing your essay here...",
  //             border: InputBorder.none,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildStructureSection() {
  //   final structureQuestions = MockData.questions[TestSection.structure]!;
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       ...structureQuestions.asMap().entries.map((entry) {
  //         int index = entry.key;
  //         Question question = entry.value;
  //         return _buildQuestionCard(question, index + 1);
  //       }),
  //     ],
  //   );
  // }

  Widget _buildAttachment(int index) {
    final attachment = _questions[index].attachment!;
    if (index != 0) {
      final prevAttachment = _questions[index - 1].attachment;
      if (prevAttachment?.id == attachment.id) {
        return const SizedBox();
      }
    }

    if (attachment.audioFile != null) {
      return _QuestionContainer(
        child: _AttachmentAudioPlayer(attachment: attachment),
      );
    }
    return _QuestionContainer(
      child: Text(attachment.passage ?? ""),
    );
  }

  Widget _buildQuestionCard(Soal question, int number) {
    return _QuestionContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Question $number:",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            question.pertanyaan,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
          if (question.opsi.isNotEmpty)
            ...question.opsi.asMap().entries.map((entry) {
              final opsi = entry.value;
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: _buildOptionTile(question.id, opsi),
              );
            }),
        ],
      ),
    );
  }

  Widget _buildOptionTile(String questionId, Opsi opsi) {
    bool isSelected = _selectedAnswers[questionId] == opsi.id;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAnswers[questionId] = opsi.id;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accent : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xffCBDCEB)),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Iconsax.tick_circle5 : Iconsax.record_circle,
              color: isSelected ? Colors.white : Colors.black54,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                opsi.isi,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: widget.onNext,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          widget.isLast ? "Finish Test" : "Next Section",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _AttachmentAudioPlayer extends StatefulWidget {
  const _AttachmentAudioPlayer({required this.attachment});
  final Attachment attachment;

  @override
  State<_AttachmentAudioPlayer> createState() => _AttachmentAudioPlayerState();
}

class _AttachmentAudioPlayerState extends State<_AttachmentAudioPlayer> {
  final _player = AudioPlayer();
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  bool get _isPlayingAudio => _player.state == PlayerState.playing;

  void _pausePlay() async {
    if (_isPlayingAudio) {
      _player.pause();
    } else {
      _player.resume();
    }
  }

  @override
  void initState() {
    super.initState();
    _player.setReleaseMode(ReleaseMode.stop);
    _player.setSourceUrl(widget.attachment.audioFile!);

    // When playback completes
    _player.onPlayerComplete.listen((event) async {
      await Future.delayed(const Duration(milliseconds: 300));
      await _player.seek(Duration.zero);
    });

    // Listen for duration changes
    _player.onDurationChanged.listen((Duration d) {
      setState(() => _duration = d);
    });

    // Listen for audio position changes
    _player.onPositionChanged.listen((Duration p) {
      setState(() => _position = p);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            _isPlayingAudio ? Icons.pause_circle : Icons.play_circle,
            size: 36,
            color: primaryBlue,
          ),
          onPressed: _pausePlay,
        ),
        Expanded(
          child: Slider(
            min: 0,
            max: _duration.inSeconds.toDouble(),
            value: _position.inSeconds.toDouble().clamp(
              0,
              _duration.inSeconds.toDouble(),
            ),
            onChanged: (value) async {
              final position = Duration(seconds: value.toInt());
              await _player.seek(position);
            },
            activeColor: primaryBlue,
            inactiveColor: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }
}

class _QuestionContainer extends StatelessWidget {
  const _QuestionContainer({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xffE8DFCA).withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xffCBDCEB)),
      ),
      child: child,
    );
  }
}
