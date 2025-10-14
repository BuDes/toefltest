import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:toeflapp/models/soal.dart';
import 'package:toeflapp/models/test_section.dart';
import 'package:toeflapp/theme/app_colors.dart';
import 'package:toeflapp/view_models/materi_view_model.dart';
import 'package:toeflapp/view_models/test_view_model.dart';
import 'package:toeflapp/widgets/app_button.dart';
import 'package:toeflapp/widgets/error_view.dart';
import 'package:toeflapp/widgets/gradient_border.dart';

const Color primaryBlue = AppColors.primary;
const Color cream1 = Color(0xffF5EFE6);

class PracticeTestDetailPage extends StatefulWidget {
  final String testType;
  const PracticeTestDetailPage({super.key, required this.testType});

  @override
  State<PracticeTestDetailPage> createState() => _PracticeTestDetailPageState();
}

class _PracticeTestDetailPageState extends State<PracticeTestDetailPage> {
  bool _isStarted = false;
  int _currentSection = 0;
  int _currentQuestion = 0;
  bool _loading = false;
  String? _error;
  String? _currentUrl;

  final _player = AudioPlayer();

  // User answers disimpan di sini
  final Map<String, String?> _userAnswers = {};

  List<TestSection> _sections = [];

  void _startTest() async {
    if (_loading) return;
    setState(() {
      _loading = true;
      _error = null;
    });
    final testVM = context.read<TestViewModel>();
    final sections = await testVM.getPracticeTest();
    if (sections == null) {
      setState(() {
        _loading = false;
        _error = "Terjadi Kesalahan";
      });
      return;
    }
    for (var section in sections) {
      for (var soal in section.soal) {
        _userAnswers[soal.id] = null;
      }
    }
    setState(() {
      _loading = false;
      _sections = sections;
      _isStarted = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _player.setReleaseMode(ReleaseMode.stop);

    // When playback completes
    _player.onPlayerComplete.listen((event) async {
      await Future.delayed(const Duration(milliseconds: 300));
      await _player.seek(Duration.zero);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cream1,
      appBar: AppBar(
        backgroundColor: primaryBlue,
        elevation: 2,
        title: Text(
          widget.testType,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: !_isStarted ? _buildIntro() : _buildTestUI(),
    );
  }

  /// 🔹 Intro
  Widget _buildIntro() {
    final materiVM = context.read<MateriViewModel>();
    final jlhBagian = materiVM.jenis.length;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 12),
        const Text(
          "📘 Petunjuk",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primaryBlue,
          ),
        ),
        const SizedBox(height: 12),
        const GradientBorderContainer(
          child: Text(
            "Latihan ini meniru ujian TOEFL yang sesungguhnya.\n\n"
            "Materi test tediri dari beberapa bagian: Listening, Reading, Writing, & Structure.\n"
            "Pastikan kamu berada di tempat yang tenang dan memiliki waktu yang cukup.",
            style: TextStyle(fontSize: 14, height: 1.5),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: _infoCard(
                Iconsax.clock,
                "Perkiraan Waktu",
                widget.testType == "Full Test" ? "3 jam" : "1 jam",
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _infoCard(
                Iconsax.document,
                "Jumlah Bagian",
                "$jlhBagian bagian",
              ),
            ),
          ],
        ),
        const SizedBox(height: 28),
        Center(child: ErrorView(error: _error)),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: _loading
                ? primaryBlue.withAlpha(125)
                : primaryBlue,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onPressed: _startTest,
          child: const Text(
            "Mulai Tes",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  /// 🔹 Test UI
  Widget _buildTestUI() {
    final section = _sections[_currentSection];
    final questions = section.soal;
    final question = questions[_currentQuestion];

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        LinearProgressIndicator(
          value: (_currentSection + 1) / _sections.length,
          color: primaryBlue,
          backgroundColor: Colors.grey.shade300,
          minHeight: 8,
          borderRadius: BorderRadius.circular(8),
        ),
        const SizedBox(height: 20),
        Text(
          "Section ${_currentSection + 1}: ${section.nama}",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: primaryBlue,
          ),
        ),
        const SizedBox(height: 16),

        // 🔹 Content per Section
        _buildSoal(question),

        // if (section["title"] == "Reading") _buildReading(section, question),
        // if (section["title"] == "Structure") _buildStructure(question),
        const SizedBox(height: 28),
        _buildNavButtons(questions),
      ],
    );
  }

  void _handleAudioChange(String? audioFile) async {
    if (audioFile == null) {
      _player.stop();
    }
    if (audioFile != null && audioFile != _currentUrl) {
      _currentUrl = audioFile;
      _player.stop();
      _player.setSource(UrlSource(audioFile));
    }
  }

  /// 🔹 Listening Section
  Widget _buildSoal(Soal question) {
    final audioFile = question.attachment?.audioFile;
    _handleAudioChange(audioFile);

    return GradientBorderContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPassage(question.attachment),
          _AttachmentAudioPlayer(
            attachment: question.attachment,
            player: _player,
          ),
          const SizedBox(height: 12),
          Text(
            question.pertanyaan,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),

          const SizedBox(height: 12),
          ...List.generate(question.opsi.length, (index) {
            final opsi = question.opsi[index];
            return RadioListTile(
              value: opsi.id,
              groupValue: _userAnswers[question.id],
              onChanged: (val) => setState(() {
                _userAnswers[question.id] = opsi.id;
              }),
              title: Text(question.opsi[index].isi),
              activeColor: primaryBlue,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildPassage(Attachment? attachment) {
    if (attachment?.passage == null) return const SizedBox();

    return Column(
      children: [
        Text(
          attachment!.passage!,
          style: const TextStyle(
            fontSize: 13,
            height: 1.4,
            color: Colors.black87,
          ),
        ),
        const Divider(height: 24, thickness: 1),
      ],
    );
  }

  /// 🔹 Reading Section
  // Widget _buildReading(
  //   Map<String, dynamic> section,
  //   Map<String, dynamic> question,
  // ) {
  //   return GradientBorderContainer(
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           section["passage"],
  //           style: const TextStyle(
  //             fontSize: 13,
  //             height: 1.4,
  //             color: Colors.black87,
  //           ),
  //         ),
  //         const Divider(height: 24, thickness: 1),
  //         Text(
  //           question["question"],
  //           style: const TextStyle(fontWeight: FontWeight.w500),
  //         ),
  //         const SizedBox(height: 12),
  //         ...List.generate(question["options"].length, (i) {
  //           return RadioListTile(
  //             value: i,
  //             groupValue: _userAnswers["Q$_currentSection-$_currentQuestion"],
  //             onChanged: (val) => setState(
  //               () => _userAnswers["Q$_currentSection-$_currentQuestion"] = val,
  //             ),
  //             title: Text(question["options"][i]),
  //             activeColor: primaryBlue,
  //           );
  //         }),
  //       ],
  //     ),
  //   );
  // }

  // /// 🔹 structure Section
  // Widget _buildStructure(Map<String, dynamic> question) {
  //   return GradientBorderContainer(
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           question["question"],
  //           style: const TextStyle(fontWeight: FontWeight.w500),
  //         ),
  //         const SizedBox(height: 12),
  //         ...List.generate(question["options"].length, (i) {
  //           return RadioListTile(
  //             value: i,
  //             groupValue: _userAnswers["Q$_currentSection-$_currentQuestion"],
  //             onChanged: (val) => setState(
  //               () => _userAnswers["Q$_currentSection-$_currentQuestion"] = val,
  //             ),
  //             title: Text(question["options"][i]),
  //             activeColor: primaryBlue,
  //           );
  //         }),
  //       ],
  //     ),
  //   );
  // }

  /// 🔹 Navigation Buttons
  Widget _buildNavButtons(List<Soal> questions) {
    return Row(
      children: [
        if (_currentSection > 0 || _currentQuestion > 0)
          Expanded(
            child: OutlinedButton(
              onPressed: _goBack,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: primaryBlue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text("Back", style: TextStyle(color: primaryBlue)),
            ),
          ),
        if (_currentSection > 0 || _currentQuestion > 0)
          const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: _goNext,
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              (_currentSection == _sections.length - 1 &&
                      _currentQuestion == questions.length - 1)
                  ? "Finish Test"
                  : "Next",
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// 🔹 Info Card
  Widget _infoCard(IconData icon, String title, String value) {
    return GradientBorderContainer(
      child: Column(
        children: [
          Icon(icon, color: primaryBlue, size: 28),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(
            title,
            style: const TextStyle(color: Colors.black54, fontSize: 12),
          ),
        ],
      ),
    );
  }

  /// 🔹 Navigation Logic
  void _goNext() {
    final questions = List<Soal>.from(
      _sections[_currentSection].soal,
    );
    if (_currentQuestion < questions.length - 1) {
      setState(() => _currentQuestion++);
    } else if (_currentSection < _sections.length - 1) {
      setState(() {
        _currentSection++;
        _currentQuestion = 0;
      });
    } else {
      _showFinishDialog();
    }
  }

  void _goBack() {
    if (_currentQuestion > 0) {
      setState(() => _currentQuestion--);
    } else if (_currentSection > 0) {
      setState(() {
        _currentSection--;
        _currentQuestion =
            List<Soal>.from(
              _sections[_currentSection].soal,
            ).length -
            1;
      });
    }
  }

  void _showFinishDialog() async {
    showPopup({required Function() builder}) {
      return showDialog(context: context, builder: (_) => builder());
    }

    final confirm = await showPopup(
      builder: () => _ConfirmationPopup(userAnswers: _userAnswers),
    );
    if (confirm != true) return;

    showPopup(
      builder: () {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text("Test Completed 🎉"),
          content: const Text(
            "You have finished the practice test",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text("OK", style: TextStyle(color: primaryBlue)),
            ),
          ],
        );
      },
    );
  }
}

class _AttachmentAudioPlayer extends StatefulWidget {
  const _AttachmentAudioPlayer({
    required this.attachment,
    required this.player,
  });

  final Attachment? attachment;
  final AudioPlayer player;

  @override
  State<_AttachmentAudioPlayer> createState() => _AttachmentAudioPlayerState();
}

class _AttachmentAudioPlayerState extends State<_AttachmentAudioPlayer> {
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  Attachment? get _attachment => widget.attachment;
  AudioPlayer get _player => widget.player;
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
    _player.setSource(UrlSource(_attachment!.audioFile!));
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
  Widget build(BuildContext context) {
    if (_attachment?.audioFile == null) return const SizedBox();

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

class _ConfirmationPopup extends StatefulWidget {
  const _ConfirmationPopup({required this.userAnswers});

  final Map<String, String?> userAnswers;

  @override
  State<_ConfirmationPopup> createState() => _ConfirmationPopupState();
}

class _ConfirmationPopupState extends State<_ConfirmationPopup> {
  bool _loading = false;
  String? _error;

  void _submitAnswers() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    final testVM = context.read<TestViewModel>();
    final navigator = Navigator.of(context);
    final error = await testVM.submitAnswers(widget.userAnswers);

    if (error == null) {
      navigator.pop(true);
      return;
    }

    setState(() {
      _loading = false;
      _error = error;
    });
  }

  @override
  Widget build(BuildContext context) {
    final unfinished = widget.userAnswers.values.contains(null);

    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        unfinished ? "Questions not anwsered" : "Submit Answers?",
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ErrorView(error: _error),
          Text(
            unfinished
                ? "There are questions that you haven't answered, do you want to continue?"
                : "Are you sure double checked and want to submit the answers?",
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text(
            "Cancel",
            style: TextStyle(color: primaryBlue),
          ),
        ),
        AppButton(
          onPressed: _submitAnswers,
          label: "Continue",
          loading: _loading,
        ),
      ],
    );
  }
}
