// // lib/pages/materials/listening/listening_page.dart
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:toeflapp/theme/app_colors.dart';
// import 'package:toeflapp/models/materi.dart';

// class ListeningPage extends StatefulWidget {
//   const ListeningPage({super.key});

//   @override
//   State<ListeningPage> createState() => _ListeningPageState();
// }

// class _ListeningPageState extends State<ListeningPage> {
//   List<Materi> items = [];
//   List<Materi> filtered = [];
//   bool gridMode = false;
//   String query = '';
//   Set<String> favorites = {};
//   String selectedLevel = 'Semua';
//   final List<String> levels = ['Semua', 'Pemula', 'Menengah', 'Lanjut'];

//   @override
//   void initState() {
//     super.initState();
//     items = _buildDummy();
//     filtered = List.from(items);
//   }

//   List<Materi> _buildDummy() {
//     final now = DateTime.now();
//     return [
//       Materi(
//         id: 'L1',
//         nama: 'Campus Conversation - Basic',
//         audioFile: 'https://example.com/audio/campus_convo.mp3',
//         content: '''
// Dalam materi ini, Anda akan mempelajari:
// • Percakapan sehari-hari di lingkungan kampus
// • Kosakata yang sering digunakan dalam percakapan akademik
// • Cara memahami intonasi dan penekanan kata
// • Teknik menangkap informasi penting dalam dialog

// **Tips Mendengarkan:**
// 1. Fokus pada pembicara pertama dan kedua
// 2. Perhatikan pertanyaan yang diajukan
// 3. Identifikasi tujuan percakapan
// 4. Catat informasi spesifik seperti nama, tempat, dan waktu
// ''',
//         tanggal: now.subtract(const Duration(days: 10)),
//         kategori: 'Conversation',
//         level: 'Pemula',
//         estimatedMinutes: 20,
//         tags: ['Campus', 'Basic', 'Dialogue'],
//       ),
//       Materi(
//         id: 'L2',
//         nama: 'Academic Lecture: Biology',
//         audioFile: 'https://example.com/audio/lecture_bio.mp3',
//         content: '''
// Materi kuliah akademik tentang biologi yang mencakup:
// • Struktur presentasi akademik
// • Terminologi khusus bidang biologi
// • Pola organisasi informasi dalam kuliah
// • Teknik mencatat yang efektif

// **Topik Pembahasan:**
// - Sistem reproduksi tanaman
// - Fotosintesis dan respirasi
// - Adaptasi organisme
// - Ekosistem dan rantai makanan

// Durasi: 25 menit
// Level: Menengah
// ''',
//         tanggal: now.subtract(const Duration(days: 20)),
//         kategori: 'Lecture',
//         level: 'Menengah',
//         estimatedMinutes: 25,
//         tags: ['Academic', 'Science', 'Lecture'],
//       ),
//       Materi(
//         id: 'L3',
//         nama: 'Everyday Dialog & Idioms',
//         audioFile: 'https://example.com/audio/everyday_dialog.mp3',
//         content: '''
// Pelajari percakapan sehari-hari dengan fokus pada:
// • Idiom dan ekspresi informal
// • Percakapan di restoran, bandara, dan hotel
// • Pemahaman konteks budaya
// • Respons yang tepat dalam berbagai situasi

// **Contoh Idiom:**
// - "Break the ice"
// - "Hit the books"
// - "On cloud nine"
// - "Piece of cake"

// Setiap dialog dilengkapi dengan transkrip dan penjelasan.
// ''',
//         tanggal: now.subtract(const Duration(days: 3)),
//         kategori: 'Dialogue',
//         level: 'Pemula',
//         estimatedMinutes: 15,
//         tags: ['Idioms', 'Daily', 'Conversation'],
//       ),
//       Materi(
//         id: 'L4',
//         nama: 'Advanced Academic Discussion',
//         audioFile: 'https://example.com/audio/academic_discussion.mp3',
//         content: '''
// Diskusi akademik tingkat lanjut tentang topik sosial:
// • Analisis argumen yang kompleks
// • Pemahaman sudut pandang multiple
// • Identifikasi bias dan asumsi
// • Evaluasi bukti dan supporting details

// **Fitur Materi:**
// - Diskusi panel 3 pembicara
// - Topik kontroversial aktual
// - Latihan critical thinking
// - Vocabulary advanced

// Recommended untuk level advanced.
// ''',
//         tanggal: now.subtract(const Duration(days: 1)),
//         kategori: 'Discussion',
//         level: 'Lanjut',
//         estimatedMinutes: 30,
//         tags: ['Advanced', 'Academic', 'Discussion'],
//       ),
//     ];
//   }

//   void _search(String q) {
//     setState(() {
//       query = q;
//       _applyFilters();
//     });
//   }

//   void _filterByLevel(String level) {
//     setState(() {
//       selectedLevel = level;
//       _applyFilters();
//     });
//   }

//   void _applyFilters() {
//     filtered = items.where((m) {
//       final matchesSearch =
//           m.nama.toLowerCase().contains(query.toLowerCase()) ||
//           (m.content).toLowerCase().contains(query.toLowerCase()) ||
//           m.tags.any((tag) => tag.toLowerCase().contains(query.toLowerCase()));

//       final matchesLevel = selectedLevel == 'Semua' || m.level == selectedLevel;

//       return matchesSearch && matchesLevel;
//     }).toList();
//   }

//   void _openDetail(Materi m) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (_) => DraggableScrollableSheet(
//         maxChildSize: 0.95,
//         initialChildSize: 0.85,
//         minChildSize: 0.5,
//         builder: (_, controller) => _detailSheet(m, controller),
//       ),
//     );
//   }

//   Widget _detailSheet(Materi m, ScrollController controller) {
//     final df = DateFormat.yMMMMd('id');
//     return Container(
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
//       ),
//       padding: const EdgeInsets.all(20),
//       child: Column(
//         children: [
//           Center(
//             child: Container(
//               width: 60,
//               height: 6,
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade300,
//                 borderRadius: BorderRadius.circular(6),
//               ),
//             ),
//           ),
//           const SizedBox(height: 16),
//           Expanded(
//             child: ListView(
//               controller: controller,
//               children: [
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text(
//                         m.nama,
//                         style: const TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.w700,
//                           color: AppColors.primary,
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       onPressed: () {
//                         setState(() {
//                           if (favorites.contains(m.id)) {
//                             favorites.remove(m.id);
//                           } else {
//                             favorites.add(m.id);
//                           }
//                         });
//                         Navigator.of(context).pop();
//                       },
//                       icon: Icon(
//                         favorites.contains(m.id)
//                             ? Icons.bookmark
//                             : Icons.bookmark_border,
//                         color: AppColors.primary,
//                         size: 28,
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 Row(
//                   children: [
//                     _buildChip(m.level, _getLevelColor(m.level)),
//                     const SizedBox(width: 8),
//                     _buildChip('${m.estimatedMinutes}m', Colors.blue),
//                     const SizedBox(width: 8),
//                     _buildChip(m.kategori, Colors.green),
//                   ],
//                 ),
//                 const SizedBox(height: 12),
//                 Text(
//                   'Diterbitkan: ${df.format(m.tanggal)}',
//                   style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
//                 ),
//                 const SizedBox(height: 20),

//                 // Audio Player Section
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: const Color(0xffF5EFE6),
//                     borderRadius: BorderRadius.circular(16),
//                     border: Border.all(
//                       color: AppColors.primary.withOpacity(0.2),
//                     ),
//                   ),
//                   child: Column(
//                     children: [
//                       const Icon(
//                         Icons.audiotrack,
//                         size: 48,
//                         color: AppColors.primary,
//                       ),
//                       const SizedBox(height: 12),
//                       const Text(
//                         'Audio Materi',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         m.audioFile ?? 'No audio file',
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey.shade600,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 16),
//                       Slider(
//                         value: 0.3,
//                         onChanged: (value) {},
//                         activeColor: AppColors.primary,
//                       ),
//                       const SizedBox(height: 8),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             '0:00',
//                             style: TextStyle(color: Colors.grey.shade600),
//                           ),
//                           Text(
//                             '${m.estimatedMinutes}:00',
//                             style: TextStyle(color: Colors.grey.shade600),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 16),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           IconButton(
//                             onPressed: () {},
//                             icon: const Icon(Icons.skip_previous, size: 32),
//                           ),
//                           IconButton(
//                             onPressed: () {},
//                             icon: const Icon(
//                               Icons.play_arrow,
//                               size: 40,
//                               color: AppColors.primary,
//                             ),
//                           ),
//                           IconButton(
//                             onPressed: () {},
//                             icon: const Icon(Icons.skip_next, size: 32),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 24),

//                 // Content Section
//                 const Text(
//                   'Deskripsi Materi',
//                   style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(height: 12),
//                 Text(
//                   m.content,
//                   style: const TextStyle(fontSize: 15, height: 1.6),
//                 ),
//                 const SizedBox(height: 16),

//                 // Tags
//                 Wrap(
//                   spacing: 8,
//                   runSpacing: 8,
//                   children: m.tags
//                       .map(
//                         (tag) => Chip(
//                           label: Text(tag),
//                           backgroundColor: Colors.grey.shade100,
//                         ),
//                       )
//                       .toList(),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Color _getLevelColor(String level) {
//     switch (level) {
//       case 'Pemula':
//         return Colors.green;
//       case 'Menengah':
//         return Colors.orange;
//       case 'Lanjut':
//         return Colors.red;
//       default:
//         return Colors.grey;
//     }
//   }

//   Widget _buildChip(String text, Color color) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//       decoration: BoxDecoration(
//         color: color.withOpacity(0.1),
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: color.withOpacity(0.3)),
//       ),
//       child: Text(
//         text,
//         style: TextStyle(
//           color: color,
//           fontSize: 12,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//     );
//   }

//   Widget _buildSearchBar() {
//     return TextField(
//       onChanged: _search,
//       decoration: InputDecoration(
//         hintText: 'Cari materi listening...',
//         prefixIcon: const Icon(Icons.search),
//         suffixIcon: query.isNotEmpty
//             ? IconButton(
//                 icon: const Icon(Icons.clear),
//                 onPressed: () => _search(''),
//               )
//             : null,
//         filled: true,
//         fillColor: Colors.white,
//         contentPadding: const EdgeInsets.symmetric(
//           vertical: 12,
//           horizontal: 16,
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14),
//           borderSide: BorderSide.none,
//         ),
//       ),
//     );
//   }

//   Widget _buildLevelFilter() {
//     return SizedBox(
//       height: 50,
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         children: levels.map((level) {
//           final isSelected = selectedLevel == level;
//           return Padding(
//             padding: const EdgeInsets.only(right: 8),
//             child: FilterChip(
//               selected: isSelected,
//               onSelected: (_) => _filterByLevel(level),
//               label: Text(level),
//               backgroundColor: Colors.white,
//               selectedColor: AppColors.primary.withOpacity(0.2),
//               checkmarkColor: AppColors.primary,
//               labelStyle: TextStyle(
//                 color: isSelected ? AppColors.primary : Colors.grey.shade700,
//                 fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }

//   Widget _buildCard(Materi m) {
//     final df = DateFormat.yMMMd('id');
//     final isFav = favorites.contains(m.id);
//     return GestureDetector(
//       onTap: () => _openDetail(m),
//       child: Card(
//         margin: const EdgeInsets.symmetric(vertical: 8),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         elevation: 2,
//         child: Container(
//           padding: const EdgeInsets.all(16),
//           child: Row(
//             children: [
//               Container(
//                 width: 64,
//                 height: 64,
//                 decoration: BoxDecoration(
//                   color: AppColors.primary.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Icon(
//                   Icons.headphones_rounded,
//                   size: 32,
//                   color: AppColors.primary,
//                 ),
//               ),
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             m.nama,
//                             style: const TextStyle(
//                               fontWeight: FontWeight.w700,
//                               fontSize: 16,
//                             ),
//                             maxLines: 2,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             setState(() {
//                               if (isFav)
//                                 favorites.remove(m.id);
//                               else
//                                 favorites.add(m.id);
//                             });
//                           },
//                           icon: Icon(
//                             isFav ? Icons.bookmark : Icons.bookmark_border,
//                             color: AppColors.primary,
//                             size: 20,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 6),
//                     Text(
//                       m.content.split('\n').first,
//                       style: TextStyle(
//                         color: Colors.grey.shade700,
//                         fontSize: 13,
//                       ),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         _buildChip(m.level, _getLevelColor(m.level)),
//                         const SizedBox(width: 8),
//                         Text(
//                           '${m.estimatedMinutes}m',
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey.shade600,
//                           ),
//                         ),
//                         const Spacer(),
//                         Text(
//                           df.format(m.tanggal),
//                           style: TextStyle(
//                             fontSize: 12,
//                             color: Colors.grey.shade600,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildGridCard(Materi m) {
//     final df = DateFormat.yMMMd('id');
//     final isFav = favorites.contains(m.id);
//     return GestureDetector(
//       onTap: () => _openDetail(m),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 8,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               height: 120,
//               decoration: BoxDecoration(
//                 color: AppColors.primary.withOpacity(0.1),
//                 borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(16),
//                   topRight: Radius.circular(16),
//                 ),
//               ),
//               child: Center(
//                 child: Icon(
//                   Icons.headphones_rounded,
//                   size: 48,
//                   color: AppColors.primary,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           m.nama,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.w700,
//                             fontSize: 14,
//                           ),
//                           maxLines: 2,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       IconButton(
//                         onPressed: () {
//                           setState(() {
//                             if (isFav)
//                               favorites.remove(m.id);
//                             else
//                               favorites.add(m.id);
//                           });
//                         },
//                         icon: Icon(
//                           isFav ? Icons.bookmark : Icons.bookmark_border,
//                           color: AppColors.primary,
//                           size: 18,
//                         ),
//                         padding: EdgeInsets.zero,
//                         constraints: const BoxConstraints(),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(height: 6),
//                   Text(
//                     m.content.split('\n').first,
//                     style: TextStyle(
//                       color: Colors.grey.shade700,
//                       fontSize: 12,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     children: [
//                       _buildChip(m.level, _getLevelColor(m.level)),
//                       const Spacer(),
//                       Text(
//                         df.format(m.tanggal),
//                         style: TextStyle(
//                           fontSize: 10,
//                           color: Colors.grey.shade600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Listening Materials'),
//         backgroundColor: AppColors.primary,
//         foregroundColor: Colors.white,
//         actions: [
//           IconButton(
//             onPressed: () {
//               setState(() {
//                 gridMode = !gridMode;
//               });
//             },
//             icon: Icon(gridMode ? Icons.view_list : Icons.grid_view),
//           ),
//         ],
//       ),
//       body: Container(
//         padding: const EdgeInsets.all(16),
//         color: const Color(0xffF8FAFC),
//         child: Column(
//           children: [
//             _buildSearchBar(),
//             const SizedBox(height: 16),
//             _buildLevelFilter(),
//             const SizedBox(height: 16),
//             Row(
//               children: [
//                 Text(
//                   '${filtered.length} materi ditemukan',
//                   style: const TextStyle(
//                     fontWeight: FontWeight.w600,
//                     fontSize: 16,
//                   ),
//                 ),
//                 const Spacer(),
//                 PopupMenuButton<String>(
//                   onSelected: (v) {
//                     setState(() {
//                       if (v == 'new') {
//                         filtered.sort((a, b) => b.tanggal.compareTo(a.tanggal));
//                       } else if (v == 'old') {
//                         filtered.sort((a, b) => a.tanggal.compareTo(b.tanggal));
//                       } else if (v == 'name') {
//                         filtered.sort((a, b) => a.nama.compareTo(b.nama));
//                       }
//                     });
//                   },
//                   itemBuilder: (_) => const [
//                     PopupMenuItem(value: 'new', child: Text('Terbaru')),
//                     PopupMenuItem(value: 'old', child: Text('Terlama')),
//                     PopupMenuItem(value: 'name', child: Text('A-Z')),
//                   ],
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 12,
//                       vertical: 8,
//                     ),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(color: Colors.grey.shade300),
//                     ),
//                     child: Row(
//                       children: const [
//                         Text('Urutkan'),
//                         SizedBox(width: 6),
//                         Icon(Icons.keyboard_arrow_down, size: 16),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 16),
//             Expanded(
//               child: filtered.isEmpty
//                   ? Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.search_off,
//                             size: 64,
//                             color: Colors.grey.shade400,
//                           ),
//                           const SizedBox(height: 16),
//                           const Text(
//                             'Tidak ada materi yang cocok',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   : gridMode
//                   ? GridView.builder(
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             mainAxisSpacing: 16,
//                             crossAxisSpacing: 16,
//                             childAspectRatio: 0.75,
//                           ),
//                       itemCount: filtered.length,
//                       itemBuilder: (_, i) => _buildGridCard(filtered[i]),
//                     )
//                   : ListView.builder(
//                       itemCount: filtered.length,
//                       itemBuilder: (_, i) => _buildCard(filtered[i]),
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
