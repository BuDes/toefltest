import 'package:flutter/material.dart';

class MateriVideoPlayer extends StatelessWidget {
  const MateriVideoPlayer({super.key});

  @override
  Widget build(BuildContext context) {
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
                color: Colors.grey,
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
}
