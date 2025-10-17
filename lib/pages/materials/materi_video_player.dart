import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MateriVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const MateriVideoPlayer({super.key, required this.videoUrl});

  @override
  State<MateriVideoPlayer> createState() => _MateriVideoPlayerState();
}

class _MateriVideoPlayerState extends State<MateriVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      setState(() {
        _isLoading = true;
        _hasError = false;
      });

      log("Initializing video: ${widget.videoUrl}");

      _controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
      );

      // Add listener untuk error handling
      _controller.addListener(() {
        if (_controller.value.hasError) {
          log(
            "Video controller error: ${_controller.value.errorDescription}",
          );
          setState(() {
            _hasError = true;
          });
        }
      });

      await _controller.initialize();

      setState(() {
        _isLoading = false;
      });

      // Auto-play video setelah load
      _controller.play();
    } catch (e, stacktrace) {
      log("Error loading video: $e", stackTrace: stacktrace);
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return _buildErrorWidget();
    }

    if (_isLoading) {
      return _buildLoadingWidget();
    }

    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: Stack(
        children: [
          VideoPlayer(_controller),
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }
                });
              },
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: VideoProgressIndicator(
              _controller,
              allowScrubbing: true,
              colors: const VideoProgressColors(
                playedColor: Colors.blue,
                bufferedColor: Colors.grey,
                backgroundColor: Colors.white54,
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: IconButton(
              icon: Icon(
                _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  if (_controller.value.isPlaying) {
                    _controller.pause();
                  } else {
                    _controller.play();
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return const AspectRatio(
      aspectRatio: 16 / 9,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 30,
              width: 30,
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ),
            SizedBox(width: 12),
            Text(
              "Loading video...",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        color: Colors.grey[300],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 50),
            const SizedBox(height: 10),
            const Text(
              "Gagal memuat video",
              style: TextStyle(color: Colors.red),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _initializeVideo,
              child: const Text("Coba Lagi"),
            ),
          ],
        ),
      ),
    );
  }
}
