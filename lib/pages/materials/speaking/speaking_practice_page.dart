// lib/pages/materials/speaking/speaking_practice_page.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:toeflapp/models/section_model.dart';

const Color primaryBlue = Color(0xff6D94C5);
const Color cream1 = Color(0xffF5EFE6);

class SpeakingPracticePage extends StatefulWidget {
  final PracticeData practice;

  const SpeakingPracticePage({super.key, required this.practice});

  @override
  State<SpeakingPracticePage> createState() => _SpeakingPracticePageState();
}

class _SpeakingPracticePageState extends State<SpeakingPracticePage> {
  bool _isPreparing = false;
  bool _isRecording = false;
  bool _isFinished = false;

  int _prepSeconds = 15;
  int _recordSeconds = 45;
  Timer? _timer;

  void _startPreparation() {
    setState(() {
      _isPreparing = true;
      _prepSeconds = 15;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_prepSeconds == 0) {
        t.cancel();
        _startRecording();
      } else {
        setState(() => _prepSeconds--);
      }
    });
  }

  void _startRecording() {
    setState(() {
      _isPreparing = false;
      _isRecording = true;
      _recordSeconds = 45;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_recordSeconds == 0) {
        t.cancel();
        _stopRecording();
      } else {
        setState(() => _recordSeconds--);
      }
    });
  }

  void _stopRecording() {
    _timer?.cancel();
    setState(() {
      _isRecording = false;
      _isFinished = true;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Widget _buildProgressBar(double progress, Color color) {
    return LinearProgressIndicator(
      value: progress,
      backgroundColor: Colors.grey.shade200,
      color: color,
      minHeight: 10,
    );
  }

  @override
  Widget build(BuildContext context) {
    double progress = 0;
    if (_isPreparing) {
      progress = (15 - _prepSeconds) / 15;
    } else if (_isRecording) {
      progress = (45 - _recordSeconds) / 45;
    }

    return Scaffold(
      backgroundColor: cream1,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.practice.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: primaryBlue,
          ),
        ),
        iconTheme: const IconThemeData(color: primaryBlue),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Prompt
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: const Text(
                "📢 Prompt:\n\nDescribe a personal experience that taught you an important lesson. "
                "You have 15 seconds to prepare and 45 seconds to speak.",
                style: TextStyle(fontSize: 14, height: 1.5),
              ),
            ),
            const SizedBox(height: 24),

            // Status info
            if (_isPreparing)
              Text(
                "Preparation Time: $_prepSeconds s",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
                textAlign: TextAlign.center,
              ),
            if (_isRecording)
              Text(
                "Recording... $_recordSeconds s left",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
            if (_isFinished)
              const Text(
                "Recording finished 🎉",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
            const SizedBox(height: 12),

            // Progress bar
            if (_isPreparing || _isRecording)
              _buildProgressBar(
                progress,
                _isPreparing ? Colors.orange : Colors.red,
              ),
            const SizedBox(height: 24),

            // Mic / Control button
            Center(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isRecording
                      ? Colors.red
                      : (_isPreparing ? Colors.orange : primaryBlue),
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  if (_isPreparing || _isRecording) {
                    _stopRecording();
                  } else if (_isFinished) {
                    // restart
                    setState(() => _isFinished = false);
                    _startPreparation();
                  } else {
                    _startPreparation();
                  }
                },
                icon: Icon(
                  _isRecording ? Icons.stop : Icons.mic,
                  color: Colors.white,
                ),
                label: Text(
                  _isRecording
                      ? "Stop Recording"
                      : (_isPreparing ? "Preparing..." : "Start Speaking"),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Dummy playback after finished
            if (_isFinished)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("🔊 Playing your response (dummy)"),
                          ),
                        );
                      },
                      icon: const Icon(Icons.play_circle, color: primaryBlue),
                    ),
                    const SizedBox(width: 8), // kasih jarak biar rapi
                    Expanded(
                      // <= biar teks ga overflow
                      child: Text(
                        "Your recorded answer (mock playback)",
                        style: TextStyle(color: Colors.black87),
                        overflow: TextOverflow
                            .ellipsis, // kalau kepanjangan, jadi "..."
                        maxLines: 1, // tetap 1 baris
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
