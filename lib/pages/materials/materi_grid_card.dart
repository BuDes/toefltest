import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toeflapp/models/materi.dart';
import 'package:toeflapp/pages/materials/favorite_icon_button.dart';
import 'package:toeflapp/theme/app_colors.dart';

class MateriGridCard extends StatelessWidget {
  const MateriGridCard({
    super.key,
    required this.m,
    required this.openDetails,
  });

  final Materi m;
  final void Function(Materi m) openDetails;

  @override
  Widget build(BuildContext context) {
    final df = DateFormat.yMMMd('id');
    // final isFav = favorites.contains(m.id);
    return GestureDetector(
      onTap: () => openDetails(m),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.headphones_rounded,
                  size: 48,
                  color: AppColors.primary,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          m.nama,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      FavoriteIconButton(
                        id: m.id,
                        size: 18,
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    m.intro.split('\n').first,
                    style: TextStyle(
                      color: Colors.grey.shade700,
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    df.format(m.tanggal),
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey.shade600,
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
