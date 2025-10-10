import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:toeflapp/models/materi.dart';
import 'package:toeflapp/pages/materials/materi_content_page.dart';
import 'package:toeflapp/theme/app_colors.dart';

class DetailMateri extends StatelessWidget {
  const DetailMateri({
    super.key,
    required this.m,
    required this.controller,
  });

  final Materi m;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    final df = DateFormat.yMMMMd('id');
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Center(
            child: Container(
              width: 60,
              height: 6,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView(
              controller: controller,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        m.nama,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    // TODO: use viewmodel
                    // IconButton(
                    //   onPressed: () {
                    //     setState(() {
                    //       if (favorites.contains(m.id)) {
                    //         favorites.remove(m.id);
                    //       } else {
                    //         favorites.add(m.id);
                    //       }
                    //     });
                    //   },
                    //   icon: Icon(
                    //     favorites.contains(m.id)
                    //         ? Icons.bookmark
                    //         : Icons.bookmark_border,
                    //     color: AppColors.primary,
                    //     size: 28,
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'Diterbitkan: ${df.format(m.tanggal)}',
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
                const SizedBox(height: 20),

                // Audio Player Section
                // Container(
                //   padding: const EdgeInsets.all(16),
                //   decoration: BoxDecoration(
                //     color: const Color(0xffF5EFE6),
                //     borderRadius: BorderRadius.circular(16),
                //     border: Border.all(
                //       color: AppColors.primary.withOpacity(0.2),
                //     ),
                //   ),
                //   child: Column(
                //     children: [
                //       const Icon(
                //         Icons.audiotrack,
                //         size: 48,
                //         color: AppColors.primary,
                //       ),
                //       const SizedBox(height: 12),
                //       const Text(
                //         'Audio Materi',
                //         style: TextStyle(
                //           fontSize: 16,
                //           fontWeight: FontWeight.w600,
                //         ),
                //       ),
                //       const SizedBox(height: 8),
                //       Text(
                //         m.audioFile ?? 'No audio file',
                //         style: TextStyle(
                //           fontSize: 12,
                //           color: Colors.grey.shade600,
                //         ),
                //         textAlign: TextAlign.center,
                //       ),
                //       const SizedBox(height: 16),
                //       Slider(
                //         value: 0.3,
                //         onChanged: (value) {},
                //         activeColor: AppColors.primary,
                //       ),
                //       const SizedBox(height: 8),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           Text(
                //             '0:00',
                //             style: TextStyle(color: Colors.grey.shade600),
                //           ),
                //           Text(
                //             '${m.estimatedMinutes}:00',
                //             style: TextStyle(color: Colors.grey.shade600),
                //           ),
                //         ],
                //       ),
                //       const SizedBox(height: 16),
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           IconButton(
                //             onPressed: () {},
                //             icon: const Icon(Icons.skip_previous, size: 32),
                //           ),
                //           IconButton(
                //             onPressed: () {},
                //             icon: const Icon(
                //               Icons.play_arrow,
                //               size: 40,
                //               color: AppColors.primary,
                //             ),
                //           ),
                //           IconButton(
                //             onPressed: () {},
                //             icon: const Icon(Icons.skip_next, size: 32),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),
                // const SizedBox(height: 24),

                // Content Section
                const Text(
                  'Tentang Materi Ini',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  m.intro,
                  style: const TextStyle(fontSize: 15, height: 1.6),
                ),
                const SizedBox(height: 64),
                MaterialButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MateriContentPage(materi: m),
                      ),
                    );
                  },
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(8),
                  ),
                  color: AppColors.primary,
                  child: const Text(
                    "Mulai",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
