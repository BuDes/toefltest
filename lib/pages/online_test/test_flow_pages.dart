import 'dart:async';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final bool isCircle;

  const AppIcon({
    super.key,
    required this.icon,
    this.backgroundColor = const Color(0xffCBDCEB),
    this.iconColor = const Color(0xff6D94C5),
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
            color: const Color(0xff6D94C5),
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    );
  }
}

// --- MOCK DATA ---
enum TestSection { reading, listening, writing, speaking }

class Question {
  final String id;
  final String text;
  final List<String> options;
  final int correctAnswerIndex;

  Question({
    required this.id,
    required this.text,
    required this.options,
    required this.correctAnswerIndex,
  });
}

class MockData {
  static final Map<TestSection, List<Question>> questions = {
    TestSection.reading: [
      Question(
        id: 'r_1',
        text: 'What is the main topic of the first paragraph?',
        options: [
          'History of solar power',
          'Benefits of renewable energy',
          'Challenges of wind energy',
          'Global climate change',
        ],
        correctAnswerIndex: 1,
      ),
      Question(
        id: 'r_2',
        text:
            'According to the text, which country is a leader in solar energy production?',
        options: ['United States', 'China', 'Germany', 'Australia'],
        correctAnswerIndex: 2,
      ),
    ],
    TestSection.listening: [
      Question(
        id: 'l_1',
        text: 'What is the speaker\'s opinion on the new library policy?',
        options: [
          'They are in favor of it',
          'They are against it',
          'They are indifferent',
          'They do not mention it',
        ],
        correctAnswerIndex: 0,
      ),
      Question(
        id: 'l_2',
        text: 'What time is the meeting scheduled?',
        options: ['9:00 AM', '10:30 AM', '1:00 PM', '2:00 PM'],
        correctAnswerIndex: 3,
      ),
    ],
    TestSection.writing: [
      Question(
        id: 'w_1',
        text: 'Write an essay discussing the pros and cons of remote work.',
        options: [],
        correctAnswerIndex: -1,
      ),
    ],
    TestSection.speaking: [
      Question(
        id: 's_1',
        text:
            'Describe your hometown. What do you like most and least about it?',
        options: [],
        correctAnswerIndex: -1,
      ),
    ],
  };
}

// --- PAGES & WIDGETS ---

class TestDetailPage extends StatelessWidget {
  final String testTitle;

  const TestDetailPage({super.key, required this.testTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5EFE6),
      appBar: AppBar(
        title: Text(
          testTitle,
          style: TextStyle(
            color: Color(0xff6D94C5),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xff6D94C5)),
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
                  SectionHeader(
                    title: "Test Details",
                    icon: Iconsax.document_text5,
                  ),
                  const SizedBox(height: 16),
                  _buildDetailRow(
                    Iconsax.clock,
                    "Duration",
                    "2 hours 30 minutes",
                  ),
                  _buildDetailRow(
                    Iconsax.calendar_1,
                    "Date",
                    "Available Anytime",
                  ),
                  _buildDetailRow(
                    Iconsax.document,
                    "Format",
                    "Reading, Listening, Writing, Speaking",
                  ),
                  const SizedBox(height: 16),
                  Text(
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
            // ✅ Corrected code for the gradient button
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        TestPreparationPage(testTitle: testTitle),
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
                    colors: [Color(0xFF6D94C5), Color(0xffffa97a)],
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
          Icon(icon, color: const Color(0xffffa97a), size: 24),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xff6D94C5),
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
        ],
      ),
    );
  }
}

// --- TEST PREPARATION PAGE ---

class TestPreparationPage extends StatelessWidget {
  final String testTitle;

  const TestPreparationPage({super.key, required this.testTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5EFE6),
      appBar: AppBar(
        title: Text(
          "Get Ready!",
          style: TextStyle(
            color: Color(0xff6D94C5),
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xff6D94C5)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
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
              title: "Headphones and Microphone",
              description:
                  "Make sure your headphones and microphone are working properly for the Listening and Speaking sections.",
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
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          TestPageContainer(testTitle: testTitle),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: const Color(0xffffa97a),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  // elevation: 5,
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
            iconColor: const Color(0xff6D94C5),
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
                    color: Color(0xff6D94C5),
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

// --- MAIN TEST CONTAINER ---

class TestPageContainer extends StatefulWidget {
  final String testTitle;

  const TestPageContainer({super.key, required this.testTitle});

  @override
  State<TestPageContainer> createState() => _TestPageContainerState();
}

class _TestPageContainerState extends State<TestPageContainer> {
  final PageController _pageController = PageController();
  int _currentSectionIndex = 0;
  final List<TestSection> _sections = [
    TestSection.reading,
    TestSection.listening,
    TestSection.writing,
    TestSection.speaking,
  ];

  late Timer _timer;
  int _start = 900; // 15 minutes in seconds for a single section

  // Timer duration for each section
  final Map<TestSection, int> _sectionDurations = {
    TestSection.reading: 900, // 15 minutes
    TestSection.listening: 900, // 15 minutes
    TestSection.writing: 1200, // 20 minutes
    TestSection.speaking: 180, // 3 minutes
  };

  @override
  void initState() {
    super.initState();
    _start = _sectionDurations[_sections[_currentSectionIndex]] ?? 0;
    _startTimer();
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
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  String _getSectionTitle(TestSection section) {
    switch (section) {
      case TestSection.reading:
        return "Reading Section";
      case TestSection.listening:
        return "Listening Section";
      case TestSection.writing:
        return "Writing Section";
      case TestSection.speaking:
        return "Speaking Section";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5EFE6),
      appBar: AppBar(
        title: Text(
          widget.testTitle,
          style: TextStyle(color: Color(0xff6D94C5)),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Iconsax.close_circle, color: Color(0xffffa97a)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                const Icon(Iconsax.clock, color: Color(0xff6D94C5), size: 20),
                const SizedBox(width: 4),
                Text(
                  _formatTime(_start),
                  style: TextStyle(
                    color: Color(0xff6D94C5),
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
          // Section progress bar
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
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: isCompleted
                          ? const Color(0xffffa97a)
                          : isCurrent
                          ? const Color(0xff6D94C5)
                          : const Color(0xffCBDCEB),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 16),
          // Section title
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              _getSectionTitle(_sections[_currentSectionIndex]),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: const Color(0xff6D94C5),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Main content
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              physics:
                  const NeverScrollableScrollPhysics(), // Prevent manual swiping
              itemCount: _sections.length,
              onPageChanged: (index) {
                setState(() {
                  _currentSectionIndex = index;
                  _start = _sectionDurations[_sections[index]] ?? 0;
                  _timer.cancel();
                  _startTimer();
                });
              },
              itemBuilder: (context, index) {
                final section = _sections[index];
                return TestSectionWidget(
                  section: section,
                  onNext: () {
                    if (_currentSectionIndex < _sections.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeIn,
                      );
                    } else {
                      // Handle test completion
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

  void _showCompletionDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: const Color(0xffF5EFE6),
          title: Text(
            "Test Selesai!",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: const Color(0xff6D94C5),
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/images/trophy.svg', // Assumes you have an SVG asset
                height: 80,
              ),
              const SizedBox(height: 16),
              Text(
                "Selamat, Anda telah menyelesaikan test ini. Hasil akan tersedia di halaman profil Anda.",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Go back to TestPage
              },
              child: const Text(
                "Kembali ke Halaman Utama",
                style: TextStyle(
                  color: Color(0xffffa97a),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// --- INDIVIDUAL TEST SECTIONS WIDGETS ---
// --- INDIVIDUAL TEST SECTIONS WIDGETS ---

class TestSectionWidget extends StatefulWidget {
  final TestSection section;
  final VoidCallback onNext;

  const TestSectionWidget({
    super.key,
    required this.section,
    required this.onNext,
  });

  @override
  State<TestSectionWidget> createState() => _TestSectionWidgetState();
}

class _TestSectionWidgetState extends State<TestSectionWidget> {
  Map<String, int?> _selectedAnswers =
      {}; // Map to hold selected answer index for each question

  // --- State for Listening Section ---
  bool _isPlaying = false;
  Timer? _audioTimer;
  final Duration _audioDuration = const Duration(minutes: 2, seconds: 40);
  Duration _audioPosition = Duration.zero;

  // --- State for Speaking Section ---
  bool _isRecording = false;
  Timer? _recordingTimer;
  final Duration _recordingDuration = const Duration(minutes: 1);
  Duration _recordingPosition = Duration.zero;

  @override
  void dispose() {
    // Cancel any active timers when the widget is removed to prevent memory leaks
    _audioTimer?.cancel();
    _recordingTimer?.cancel();
    super.dispose();
  }

  // --- Helper function to format Duration into MM:SS string ---
  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  // --- Logic for Listening Section Player ---
  void _toggleAudioPlayback() {
    if (_isPlaying) {
      _audioTimer?.cancel();
    } else {
      // Reset position if it has reached the end
      if (_audioPosition >= _audioDuration) {
        _audioPosition = Duration.zero;
      }
      _audioTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_audioPosition >= _audioDuration) {
          timer.cancel();
          setState(() {
            _isPlaying = false;
          });
        } else {
          setState(() {
            _audioPosition += const Duration(seconds: 1);
          });
        }
      });
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  // --- Logic for Speaking Section Recorder ---
  void _toggleRecording() {
    if (_isRecording) {
      _recordingTimer?.cancel();
    } else {
      // Reset position if it has reached the end
      if (_recordingPosition >= _recordingDuration) {
        _recordingPosition = Duration.zero;
      }
      _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_recordingPosition >= _recordingDuration) {
          timer.cancel();
          setState(() {
            _isRecording = false;
          });
        } else {
          setState(() {
            _recordingPosition += const Duration(seconds: 1);
          });
        }
      });
    }
    setState(() {
      _isRecording = !_isRecording;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.section == TestSection.reading) _buildReadingSection(),
          if (widget.section == TestSection.listening) _buildListeningSection(),
          if (widget.section == TestSection.writing) _buildWritingSection(),
          if (widget.section == TestSection.speaking) _buildSpeakingSection(),
          const SizedBox(height: 40),
          _buildNextButton(context),
        ],
      ),
    );
  }

  Widget _buildReadingSection() {
    final readingQuestions = MockData.questions[TestSection.reading]!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Dummy passage for reading section
        _buildPassageCard(),
        const SizedBox(height: 24),
        // Questions for the passage
        ...readingQuestions.asMap().entries.map((entry) {
          int index = entry.key;
          Question question = entry.value;
          return _buildQuestionCard(question, index + 1);
        }).toList(),
      ],
    );
  }

  Widget _buildPassageCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xffE8DFCA), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Passage:",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xff6D94C5),
            ),
          ),
          SizedBox(height: 8),
          Text(
            "The rapid advancement of technology has profoundly impacted our daily lives, transforming how we communicate, work, and access information. From the proliferation of smartphones to the rise of artificial intelligence, these innovations have created new opportunities and challenges. However, as we embrace these changes, it's crucial to consider their social and environmental implications, particularly in areas like data privacy and sustainability.",
            style: TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildListeningSection() {
    final listeningQuestions = MockData.questions[TestSection.listening]!;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              const Text(
                "Now, listen to the audio and answer the questions below.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff6D94C5),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // ✅ Interactive Play/Pause Icon
              GestureDetector(
                onTap: _toggleAudioPlayback,
                child: Icon(
                  _isPlaying ? Iconsax.pause_circle5 : Iconsax.play_circle5,
                  size: 80,
                  color: const Color(0xffffa97a),
                ),
              ),
              const SizedBox(height: 8),
              // ✅ Dynamic Timer Text
              Text(
                "${_formatDuration(_audioPosition)} / ${_formatDuration(_audioDuration)}",
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ...listeningQuestions.asMap().entries.map((entry) {
          int index = entry.key;
          Question question = entry.value;
          return _buildQuestionCard(question, index + 1);
        }).toList(),
      ],
    );
  }

  Widget _buildWritingSection() {
    final writingQuestion = MockData.questions[TestSection.writing]!.first;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildQuestionCard(writingQuestion, 1),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xffCBDCEB)),
          ),
          child: const TextField(
            maxLines: 10,
            decoration: InputDecoration(
              hintText: "Start writing your essay here...",
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSpeakingSection() {
    final speakingQuestion = MockData.questions[TestSection.speaking]!.first;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildQuestionCard(speakingQuestion, 1),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              // ✅ Interactive Record Icon
              GestureDetector(
                onTap: _toggleRecording,
                child: Icon(
                  Iconsax.microphone_2,
                  size: 80,
                  // Change color to indicate recording state
                  color: _isRecording
                      ? Colors.redAccent
                      : const Color(0xffffa97a),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                _isRecording
                    ? "Recording..."
                    : "Tap the mic to start recording.",
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xff6D94C5),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // ✅ Dynamic Timer Text
              Text(
                "${_formatDuration(_recordingPosition)} / ${_formatDuration(_recordingDuration)}",
                style: const TextStyle(fontSize: 12, color: Colors.black54),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildQuestionCard(Question question, int number) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xffE8DFCA).withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xffCBDCEB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Question $number:",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xff6D94C5),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            question.text,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
          if (question.options.isNotEmpty)
            ...question.options.asMap().entries.map((entry) {
              int optionIndex = entry.key;
              String optionText = entry.value;
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: _buildOptionTile(question.id, optionIndex, optionText),
              );
            }).toList(),
        ],
      ),
    );
  }

  Widget _buildOptionTile(String questionId, int optionIndex, String text) {
    bool isSelected = _selectedAnswers[questionId] == optionIndex;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedAnswers[questionId] = optionIndex;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xffffa97a) : Colors.white,
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
                text,
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
          backgroundColor: const Color(0xff6D94C5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          widget.section == TestSection.speaking
              ? "Finish Test"
              : "Next Section",
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
