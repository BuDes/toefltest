import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toeflapp/models/materi.dart';
import 'package:toeflapp/pages/materials/materi_video_player.dart';
import 'package:toeflapp/theme/app_colors.dart';
import 'package:toeflapp/view_models/materi_view_model.dart';

class MateriContentPage extends StatelessWidget {
  const MateriContentPage({super.key, required this.materi});
  final Materi materi;

  void _nextMateri(BuildContext context, Materi nextMateri) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MateriContentPage(materi: nextMateri),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final materiVM = context.read<MateriViewModel>();
    final nextMateri = materiVM.nextMateri(materi);

    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primary,
        title: Text(materi.nama),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 32),
        child: Column(
          children: [
            if (materi.videoFile != null) const MateriVideoPlayer(),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(materi.content ?? ""),
            ),
            if (nextMateri != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  MaterialButton(
                    onPressed: () => _nextMateri(context, nextMateri),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 24,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(8),
                    ),
                    color: AppColors.primary,
                    disabledColor: AppColors.primary.withAlpha(125),
                    child: const Text(
                      "Materi Beirkutnya",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
