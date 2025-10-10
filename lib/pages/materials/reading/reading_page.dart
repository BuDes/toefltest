// // lib/pages/materials/reading/reading_page.dart
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:toeflapp/theme/app_colors.dart';
// import 'package:toeflapp/models/materi.dart';

// class ReadingPage extends StatefulWidget {
//   const ReadingPage({super.key});

//   @override
//   State<ReadingPage> createState() => _ReadingPageState();
// }

// class _ReadingPageState extends State<ReadingPage> {
//   List<Materi> items = [];
//   List<Materi> filtered = [];
//   bool gridMode = false;
//   String query = '';
//   final Set<String> bookmarked = {};
//   String selectedCategory = 'Semua';
//   final List<String> categories = [
//     'Semua',
//     'Academic',
//     'Scientific',
//     'Literary',
//     'Historical',
//   ];

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
//         id: 'R1',
//         nama: 'Academic Reading: Modern History',
//         documentFile: 'https://example.com/docs/history_reading.pdf',
//         content: '''
// **Teks Akademik - Sejarah Modern**

// **Topik:** Revolusi Industri dan Dampaknya terhadap Masyarakat

// **Isi Materi:**
// Revolusi Industri, yang dimulai di Inggris pada akhir abad ke-18, menandai titik balik dalam sejarah manusia. Transisi dari produksi manual ke mesin tidak hanya mengubah metode produksi tetapi juga struktur sosial, ekonomi, dan politik secara fundamental.

// **Fitur Pembelajaran:**
// • Vocabulary Building: Industrialization, urbanization, mechanization
// • Reading Strategy: Skimming untuk ide utama
// • Comprehension: Memahami cause-effect relationships
// • Critical Thinking: Analisis dampak sosial

// **Kosakata Penting:**
// - Industrialization
// - Urbanization
// - Mechanization
// - Socioeconomic
// - Infrastructure

// **Tips Membaca:**
// 1. Baca cepat untuk mendapatkan gambaran umum
// 2. Identifikasi thesis statement
// 3. Temukan supporting details
// 4. Perhatikan transition words
// ''',
//         tanggal: now.subtract(const Duration(days: 12)),
//         kategori: 'Academic',
//         level: 'Menengah',
//         estimatedMinutes: 25,
//         tags: ['History', 'Academic', 'Long Passage'],
//       ),
//       Materi(
//         id: 'R2',
//         nama: 'Scientific Article: Climate Change',
//         documentFile: 'https://example.com/docs/climate_article.pdf',
//         content: '''
// **Artikel Ilmiah - Perubahan Iklim**

// **Abstrak:**
// Artikel ini membahas bukti-bukti ilmiah terkini tentang perubahan iklim, faktor penyebab, dan dampaknya terhadap ekosistem global. Fokus pada pemahaman data statistik dan interpretasi grafik.

// **Struktur Teks:**
// 1. Introduction: Latar belakang penelitian
// 2. Methodology: Metode pengumpulan data
// 3. Results: Temuan dan analisis
// 4. Discussion: Interpretasi hasil
// 5. Conclusion: Implikasi dan rekomendasi

// **Keterampilan yang Dikembangkan:**
// • Memahami bahasa teknis ilmiah
// • Interpretasi data dan grafik
// • Mengidentifikasi bias dalam penelitian
// • Membuat inference dari data

// **Complex Sentences Analysis:**
// - Passive voice dalam tulisan ilmiah
// - Conditional sentences
// - Reduced relative clauses
// ''',
//         tanggal: now.subtract(const Duration(days: 6)),
//         kategori: 'Scientific',
//         level: 'Lanjut',
//         estimatedMinutes: 30,
//         tags: ['Science', 'Environment', 'Data Analysis'],
//       ),
//       Materi(
//         id: 'R3',
//         nama: 'Literary Analysis: Classic Literature',
//         documentFile: 'https://example.com/docs/literary_analysis.pdf',
//         content: '''
// **Analisis Sastra - Karya Klasik**

// **Teks:** Excerpt dari novel klasik dengan fokus pada karakter development dan tema universal.

// **Elemen Sastra yang Dipelajari:**
// • Character Development: Perkembangan karakter utama
// • Plot Structure: Alur cerita dan konflik
// • Theme: Tema utama dan pesan moral
// • Symbolism: Simbol dan metafora
// • Setting: Pengaruh latar terhadap cerita

// **Teknik Membaca Sastra:**
// 1. Close reading untuk detail
// 2. Memahami konteks historis
// 3. Analisis gaya bahasa penulis
// 4. Interpretasi makna tersirat

// **Vocabulary Building:**
// - Protagonist vs Antagonist
// - Climax dan Resolution
// - Foreshadowing
// - Irony dan Satire

// **Contoh Analysis:**
// Analisis penggunaan figurative language dan rhetorical devices dalam teks.
// ''',
//         tanggal: now.subtract(const Duration(days: 30)),
//         kategori: 'Literary',
//         level: 'Menengah',
//         estimatedMinutes: 35,
//         tags: ['Literature', 'Analysis', 'Classic'],
//       ),
//       Materi(
//         id: 'R4',
//         nama: 'Historical Documents Analysis',
//         documentFile: 'https://example.com/docs/historical_docs.pdf',
//         content: '''
// **Dokumen Sejarah - Analisis Sumber Primer**

// **Jenis Dokumen:**
// - Surat resmi bersejarah
// - Pidato penting
// - Dokumen perjanjian
// - Catatan peristiwa sejarah

// **Keterampilan Analisis:**
// • Memahami konteks historis
// • Mengidentifikasi bias penulis
// • Menganalisis tujuan penulisan
// • Membandingkan perspektif berbeda
// • Mengevaluasi reliabilitas sumber

// **Metode Pembelajaran:**
// 1. Contextual Reading
// 2. Source Criticism
// 3. Comparative Analysis
// 4. Synthesis of Information

// **Vocabulary Specialist:**
// - Historiography
// - Primary vs Secondary Sources
// - Bias dan Perspective
// - Historical Context

// **Contoh Dokumen:**
// Analisis Declaration of Independence dari segi rhetorical structure dan persuasive techniques.
// ''',
//         tanggal: now.subtract(const Duration(days: 2)),
//         kategori: 'Historical',
//         level: 'Lanjut',
//         estimatedMinutes: 40,
//         tags: ['History', 'Documents', 'Analysis'],
//       ),
//     ];
//   }

//   void _search(String q) {
//     setState(() {
//       query = q;
//       _applyFilters();
//     });
//   }

//   void _filterByCategory(String category) {
//     setState(() {
//       selectedCategory = category;
//       _applyFilters();
//     });
//   }

//   void _applyFilters() {
//     filtered = items.where((m) {
//       final matchesSearch =
//           m.nama.toLowerCase().contains(query.toLowerCase()) ||
//           (m.content).toLowerCase().contains(query.toLowerCase()) ||
//           m.tags.any((tag) => tag.toLowerCase().contains(query.toLowerCase()));

//       final matchesCategory =
//           selectedCategory == 'Semua' || m.kategori == selectedCategory;

//       return matchesSearch && matchesCategory;
//     }).toList();
//   }

//   void _openDetail(Materi m) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (_) => DraggableScrollableSheet(
//         initialChildSize: 0.9,
//         minChildSize: 0.5,
//         maxChildSize: 0.95,
//         builder: (_, controller) => _detailSheet(m, controller),
//       ),
//     );
//   }

//   Widget _detailSheet(Materi m, ScrollController controller) {
//     final df = DateFormat.yMMMMd('id');
//     return Container(
//       padding: const EdgeInsets.all(20),
//       decoration: const BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       child: Column(
//         children: [
//           Center(
//             child: Container(
//               width: 44,
//               height: 5,
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
//                           if (bookmarked.contains(m.id))
//                             bookmarked.remove(m.id);
//                           else
//                             bookmarked.add(m.id);
//                         });
//                         Navigator.pop(context);
//                       },
//                       icon: Icon(
//                         bookmarked.contains(m.id)
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

//                 // Document Preview Section
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
//                         Icons.article_rounded,
//                         size: 48,
//                         color: AppColors.primary,
//                       ),
//                       const SizedBox(height: 12),
//                       const Text(
//                         'Dokumen Materi',
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         m.documentFile ?? 'No document file',
//                         style: TextStyle(
//                           fontSize: 12,
//                           color: Colors.grey.shade600,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                       const SizedBox(height: 16),
//                       ElevatedButton.icon(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: AppColors.primary,
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 20,
//                             vertical: 12,
//                           ),
//                         ),
//                         onPressed: () {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               content: Text('Membuka dokumen: ${m.nama}'),
//                             ),
//                           );
//                         },
//                         icon: const Icon(Icons.open_in_new),
//                         label: const Text('Buka Dokumen'),
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

//                 // Reading Tips
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.blue.shade50,
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: Colors.blue.shade100),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Text(
//                         '📚 Tips Membaca Efektif',
//                         style: TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontSize: 16,
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       const Text(
//                         '• Skimming: Baca cepat untuk ide utama\n'
//                         '• Scanning: Cari informasi spesifik\n'
//                         '• Active Reading: Tandai poin penting\n'
//                         '• Vocabulary Note: Catat kata baru\n'
//                         '• Summary: Buat ringkasan setelah membaca',
//                         style: TextStyle(fontSize: 14, height: 1.5),
//                       ),
//                     ],
//                   ),
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
//                 const SizedBox(height: 20),
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

//   Widget _searchBar() {
//     return TextField(
//       onChanged: _search,
//       decoration: InputDecoration(
//         hintText: 'Cari materi reading...',
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

//   Widget _buildCategoryFilter() {
//     return SizedBox(
//       height: 50,
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         children: categories.map((category) {
//           final isSelected = selectedCategory == category;
//           return Padding(
//             padding: const EdgeInsets.only(right: 8),
//             child: FilterChip(
//               selected: isSelected,
//               onSelected: (_) => _filterByCategory(category),
//               label: Text(category),
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

//   Widget _listItem(Materi m) {
//     final df = DateFormat('d MMM', 'id');
//     final bookmarkedFlag = bookmarked.contains(m.id);
//     return Card(
//       margin: const EdgeInsets.symmetric(vertical: 8),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       elevation: 2,
//       child: ListTile(
//         onTap: () => _openDetail(m),
//         leading: Container(
//           width: 56,
//           height: 56,
//           decoration: BoxDecoration(
//             color: AppColors.primary.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: const Icon(
//             Icons.article_rounded,
//             color: AppColors.primary,
//             size: 30,
//           ),
//         ),
//         title: Row(
//           children: [
//             Expanded(
//               child: Text(
//                 m.nama,
//                 style: const TextStyle(fontWeight: FontWeight.bold),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//             IconButton(
//               onPressed: () {
//                 setState(() {
//                   if (bookmarkedFlag)
//                     bookmarked.remove(m.id);
//                   else
//                     bookmarked.add(m.id);
//                 });
//               },
//               icon: Icon(
//                 bookmarkedFlag ? Icons.bookmark : Icons.bookmark_border,
//                 color: AppColors.primary,
//                 size: 20,
//               ),
//             ),
//           ],
//         ),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 4),
//             Text(
//               m.content.split('\n').first,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//               style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
//             ),
//             const SizedBox(height: 8),
//             Row(
//               children: [
//                 _buildChip(m.level, _getLevelColor(m.level)),
//                 const SizedBox(width: 8),
//                 Text(
//                   '${m.estimatedMinutes}m',
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//                 const Spacer(),
//                 Text(
//                   df.format(m.tanggal),
//                   style: TextStyle(
//                     fontSize: 12,
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _gridItem(Materi m) {
//     final bookmarkedFlag = bookmarked.contains(m.id);
//     final df = DateFormat.yMMMd('id');
//     return GestureDetector(
//       onTap: () => _openDetail(m),
//       child: Container(
//         padding: const EdgeInsets.all(12),
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
//               height: 100,
//               decoration: BoxDecoration(
//                 color: AppColors.primary.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: const Center(
//                 child: Icon(
//                   Icons.article_rounded,
//                   size: 40,
//                   color: AppColors.primary,
//                 ),
//               ),
//             ),
//             const SizedBox(height: 10),
//             Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     m.nama,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.w700,
//                       fontSize: 14,
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 IconButton(
//                   onPressed: () {
//                     setState(() {
//                       if (bookmarkedFlag)
//                         bookmarked.remove(m.id);
//                       else
//                         bookmarked.add(m.id);
//                     });
//                   },
//                   icon: Icon(
//                     bookmarkedFlag ? Icons.bookmark : Icons.bookmark_border,
//                     color: AppColors.primary,
//                     size: 18,
//                   ),
//                   padding: EdgeInsets.zero,
//                   constraints: const BoxConstraints(),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 6),
//             Text(
//               m.content.split('\n').first,
//               style: TextStyle(
//                 color: Colors.grey.shade700,
//                 fontSize: 12,
//               ),
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//             const SizedBox(height: 8),
//             Row(
//               children: [
//                 _buildChip(m.level, _getLevelColor(m.level)),
//                 const Spacer(),
//                 Text(
//                   df.format(m.tanggal),
//                   style: TextStyle(
//                     fontSize: 10,
//                     color: Colors.grey.shade600,
//                   ),
//                 ),
//               ],
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
//         title: const Text('Reading Materials'),
//         backgroundColor: AppColors.primary,
//         foregroundColor: Colors.white,
//         actions: [
//           IconButton(
//             onPressed: () => setState(() => gridMode = !gridMode),
//             icon: Icon(gridMode ? Icons.view_list : Icons.grid_view),
//           ),
//         ],
//       ),
//       body: Container(
//         color: const Color(0xffF6F9FB),
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             _searchBar(),
//             const SizedBox(height: 16),
//             _buildCategoryFilter(),
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
//                             Icons.article_outlined,
//                             size: 64,
//                             color: Colors.grey.shade400,
//                           ),
//                           const SizedBox(height: 16),
//                           const Text(
//                             'Tidak ada materi reading',
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
//                             childAspectRatio: 0.75,
//                             mainAxisSpacing: 16,
//                             crossAxisSpacing: 16,
//                           ),
//                       itemCount: filtered.length,
//                       itemBuilder: (_, i) => _gridItem(filtered[i]),
//                     )
//                   : ListView.builder(
//                       itemCount: filtered.length,
//                       itemBuilder: (_, i) => _listItem(filtered[i]),
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
