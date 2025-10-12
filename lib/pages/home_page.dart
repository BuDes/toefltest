import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toeflapp/pages/materials/materi_page.dart';
import 'package:toeflapp/pages/practice/practice_page.dart';
import 'package:toeflapp/theme/app_colors.dart';
import 'package:toeflapp/view_models/materi_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future _jenisFuture;

  void _goTo(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page));
  }

  @override
  void initState() {
    super.initState();
    _jenisFuture = context.read<MateriViewModel>().getJenisMateri();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(pi),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bg1.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationY(pi),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "Selamat Datang.. 👋",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Jenis Materi',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 20),
                    FutureBuilder(
                      future: _jenisFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Wrap(
                            spacing: 16,
                            runSpacing: 16,
                            children: [
                              _loadingMenuCard(context),
                              _loadingMenuCard(context),
                              _loadingMenuCard(context),
                            ],
                          );
                        }
                        final listJenis = context.read<MateriViewModel>().jenis;
                        // final listJenis = [
                        //   {
                        //     'nama': 'Listening',
                        //     'deskripsi':
                        //         'Latih kemampuan mendengarkan percakapan.',
                        //     'gambar':
                        //         'https://cdn-icons-png.flaticon.com/512/2920/2920323.png',
                        //     'page': const ListeningPage(),
                        //   },
                        //   {
                        //     'nama': 'Reading',
                        //     'deskripsi':
                        //         'Tingkatkan pemahaman bacaan akademik.',
                        //     'gambar':
                        //         'https://cdn-icons-png.flaticon.com/512/2232/2232688.png',
                        //     'page': const ReadingPage(),
                        //   },
                        //   {
                        //     'nama': 'Writing',
                        //     'deskripsi':
                        //         'Asah kemampuan menulis esai dan struktur kalimat.',
                        //     'gambar':
                        //         'https://cdn-icons-png.flaticon.com/512/3131/3131607.png',
                        //     'page': const WritingPage(),
                        //   },
                        //   {
                        //     'nama': 'Structure',
                        //     'deskripsi':
                        //         'Pelajari tata bahasa dan pola kalimat TOEFL.',
                        //     'gambar':
                        //         'https://cdn-icons-png.flaticon.com/512/1995/1995574.png',
                        //     'page': const StructurePage(),
                        //   },
                        // ];
                        return Wrap(
                          spacing: 16,
                          runSpacing: 16,
                          children: listJenis.map((jenis) {
                            return _menuCard(
                              context,
                              Image.network(
                                jenis.gambar,
                                height: 35,
                                width: 35,
                              ),
                              jenis.nama,
                              jenis.deskripsi,
                              onTap: () {
                                _goTo(
                                  context,
                                  MateriPage(jenis: jenis),
                                );
                              },
                            );
                          }).toList(),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Practice Test",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => _goTo(context, const PracticeTestPage()),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: const Color(0xffF5EFE6),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color.fromARGB(255, 154, 186, 212),
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xffE8DFCA),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: const Icon(
                                Icons.app_registration_rounded,
                                color: AppColors.primary,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            const Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Full Practice Test",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  Text(
                                    "Simulasi lengkap ujian TOEFL",
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 18,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // IDEA: progress belajar
                    // const Text(
                    //   "Progress Belajar",
                    //   style: TextStyle(
                    //     fontSize: 18,
                    //     fontWeight: FontWeight.w700,
                    //     color: Colors.white,
                    //   ),
                    // ),
                    // ListView(
                    //   shrinkWrap: true,
                    //   physics: const NeverScrollableScrollPhysics(),
                    //   padding: const EdgeInsets.only(bottom: 20),
                    //   children: [
                    //     const SizedBox(height: 8),

                    //     _progressTile("Reading", 0.3, [
                    //       AppColors.accent,
                    //       const Color(0xffF5EFE6),
                    //     ]),
                    //     _progressTile("Listening", 0.8, [
                    //       AppColors.accent,
                    //       const Color(0xffF5EFE6),
                    //     ]),
                    //     _progressTile("Writing", 0.4, [
                    //       AppColors.accent,
                    //       const Color(0xffF5EFE6),
                    //     ]),
                    //     _progressTile("Structure", 0.6, [
                    //       AppColors.accent,
                    //       const Color(0xffF5EFE6),
                    //     ]),
                    //   ],
                    // ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 Card Menu
  Widget _menuCard(
    BuildContext context,
    Widget icon,
    String title,
    String subtitle, {
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 56) / 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              colors: [Color(0xffF5EFE6), Color.fromARGB(255, 255, 255, 255)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                Container(padding: const EdgeInsets.all(12), child: icon),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: Colors.black54, fontSize: 13),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _loadingMenuCard(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 56) / 2,
      height: (MediaQuery.of(context).size.width - 56) / 2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
    );
  }

  // 🔹 Progress Tile
  // Widget _progressTile(String title, double value, List<Color> gradient) {
  //   return Padding(
  //     padding: const EdgeInsets.only(bottom: 18),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text(
  //               title,
  //               style: const TextStyle(
  //                 fontWeight: FontWeight.w600,
  //                 fontSize: 15,
  //                 color: Colors.white,
  //               ),
  //             ),
  //             Text(
  //               '${(value * 100).toInt()}%',
  //               style: const TextStyle(
  //                 fontWeight: FontWeight.w600,
  //                 fontSize: 15,
  //                 color: Colors.white,
  //               ),
  //             ),
  //           ],
  //         ),
  //         const SizedBox(height: 8),
  //         Container(
  //           height: 12,
  //           decoration: BoxDecoration(
  //             color: Colors.grey.shade300,
  //             borderRadius: BorderRadius.circular(12),
  //           ),
  //           child: LayoutBuilder(
  //             builder: (context, constraints) {
  //               return ClipRRect(
  //                 borderRadius: BorderRadius.circular(12),
  //                 child: AnimatedContainer(
  //                   duration: const Duration(milliseconds: 600),
  //                   curve: Curves.easeInOut,
  //                   width: constraints.maxWidth * value,
  //                   decoration: BoxDecoration(
  //                     gradient: LinearGradient(
  //                       colors: gradient,
  //                       begin: Alignment.centerLeft,
  //                       end: Alignment.centerRight,
  //                     ),
  //                   ),
  //                 ),
  //               );
  //             },
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
