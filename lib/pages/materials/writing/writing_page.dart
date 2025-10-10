// // lib/pages/materials/writing/writing_page.dart
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:toeflapp/models/materi.dart';
// import 'package:toeflapp/theme/app_colors.dart';

// class WritingPage extends StatefulWidget {
//   const WritingPage({super.key});

//   @override
//   State<WritingPage> createState() => _WritingPageState();
// }

// class _WritingPageState extends State<WritingPage> {
//   List<Materi> items = [];
//   List<Materi> filtered = [];
//   String query = '';
//   bool gridMode = false;
//   final Set<String> saved = {};
//   String selectedType = 'Semua';
//   final List<String> types = [
//     'Semua',
//     'Essay',
//     'Academic',
//     'Creative',
//     'Business',
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
//         id: 'W1',
//         nama: 'Academic Essay Writing',
//         documentFile: 'https://example.com/docs/academic_essay.pdf',
//         content: '''
// **Menulis Esai Akademik yang Efektif**

// **Struktur Esai Akademik:**
// 1. **Introduction:**
//    - Hook: Kalimat pembuka yang menarik
//    - Background: Konteks dan latar belakang
//    - Thesis Statement: Pernyataan posisi utama

// 2. **Body Paragraphs:**
//    - Topic Sentence: Ide utama paragraf
//    - Supporting Details: Bukti dan contoh
//    - Analysis: Penjelasan dan interpretasi
//    - Concluding Sentence: Ringkasan paragraf

// 3. **Conclusion:**
//    - Restate Thesis: Ulang thesis dengan kata berbeda
//    - Summary: Ringkasan poin utama
//    - Final Thought: Pesan penutup atau implikasi

// **Jenis Esai Akademik:**
// - Argumentative Essay: Menyajikan argumen dengan bukti
// - Expository Essay: Menjelaskan konsep atau ide
// - Comparative Essay: Membandingkan dua atau lebih hal
// - Cause-Effect Essay: Menganalisis sebab dan akibat

// **Tips Menulis:**
// • Gunakan bahasa formal dan objektif
// • Hindari kontraksi (don't → do not)
// • Gunakan transition words yang tepat
// • Proofread untuk grammar dan spelling
// ''',
//         tanggal: now.subtract(const Duration(days: 8)),
//         kategori: 'Essay',
//         level: 'Menengah',
//         estimatedMinutes: 45,
//         tags: ['Academic', 'Essay', 'Structure'],
//       ),
//       Materi(
//         id: 'W2',
//         nama: 'TOEFL Integrated Writing',
//         documentFile: 'https://example.com/docs/toefl_integrated.pdf',
//         content: '''
// **Integrated Writing Task - TOEFL**

// **Format Task:**
// 1. **Reading Passage** (3 menit)
//    - Topik akademik
//    - 250-300 kata
//    - Main points dan supporting details

// 2. **Listening Lecture** (2-3 menit)
//    - Membahas topik yang sama
//    - Memberikan perspektif berbeda
//    - Counterarguments terhadap reading

// 3. **Writing Response** (20 menit)
//    - 150-225 kata
//    - Summarize points dari listening
//    - Jelaskan bagaimana mereka relate ke reading

// **Strategi Menulis:**

// **1. Note-Taking:**
// - Reading: Catat main idea dan 3 key points
// - Listening: Fokus pada bagaimana lecture menanggapi reading

// **2. Template Response:**
// - Paragraf 1: Introduksi + hubungan reading-listening
// - Paragraf 2-4: Masing-masing point + bagaimana lecture menanggapinya
// - Paragraf 5: Kesimpulan (opsional)

// **3. Language untuk Integration:**
// - "The lecturer challenges the point made in the reading that..."
// - "Contrary to the reading passage, the speaker argues that..."
// - "While the reading states..., the lecture provides evidence that..."

// **Scoring Criteria:**
// - Accurate content (hubungan reading-listening)
// - Organization yang jelas
// - Language use dan vocabulary
// - Grammar dan mechanics
// ''',
//         tanggal: now.subtract(const Duration(days: 16)),
//         kategori: 'Academic',
//         level: 'Lanjut',
//         estimatedMinutes: 50,
//         tags: ['TOEFL', 'Integrated', 'Academic'],
//       ),
//       Materi(
//         id: 'W3',
//         nama: 'Creative Writing Techniques',
//         documentFile: 'https://example.com/docs/creative_writing.pdf',
//         content: '''
// **Teknik Menulis Kreatif dalam Bahasa Inggris**

// **1. Show, Don't Tell:**
// • Telling: "She was sad."
// • Showing: "Tears streamed down her face as she stared at the empty chair."

// **2. Character Development:**
// - Physical Description: Penampilan fisik karakter
// - Personality Traits: Sifat dan karakteristik
// - Background: Latar belakang dan motivasi
// - Dialogue: Percakapan yang mencerminkan karakter

// **3. Setting dan Atmosphere:**
// - Sensory Details: Penggunaan five senses
// - Mood Creation: Menciptakan suasana tertentu
// - Time and Place: Konteks temporal dan spasial

// **4. Plot Structure:**
// - Exposition: Pengenalan karakter dan setting
// - Rising Action: Konflik mulai berkembang
// - Climax: Puncak ketegangan
// - Falling Action: Resolusi konflik
// - Resolution: Akhir cerita

// **5. Literary Devices:**
// - Metaphor dan Simile
// - Personification
// - Imagery
// - Symbolism
// - Foreshadowing

// **Contoh Creative Writing Prompts:**
// • "Write about a character who discovers a hidden talent..."
// • "Describe a place that holds special meaning for you..."
// • "Create a story that begins with: 'The door shouldn't have been open...'"
// ''',
//         tanggal: now.subtract(const Duration(days: 2)),
//         kategori: 'Creative',
//         level: 'Menengah',
//         estimatedMinutes: 35,
//         tags: ['Creative', 'Fiction', 'Techniques'],
//       ),
//       Materi(
//         id: 'W4',
//         nama: 'Business & Professional Writing',
//         documentFile: 'https://example.com/docs/business_writing.pdf',
//         content: '''
// **Penulisan Bisnis dan Profesional**

// **1. Business Email:**
// • Subject Line: Jelas dan informatif
// • Salutation: Formal atau semi-formal
// • Body: Ringkas dan to the point
// • Closing: Professional sign-off
// • Signature: Informasi kontak

// **2. Formal Report Writing:**
// - Executive Summary: Ringkasan untuk manajemen
// - Introduction: Latar belakang dan tujuan
// - Methodology: Cara pengumpulan data
// - Findings: Hasil dan temuan
// - Recommendations: Saran tindakan

// **3. Proposal Writing:**
// - Problem Statement: Identifikasi masalah
// - Proposed Solution: Solusi yang ditawarkan
// - Methodology: Implementasi solusi
// - Budget: Estimasi biaya
// - Timeline: Jadwal pelaksanaan

// **4. Professional Correspondence:**
// - Cover Letters
// - Memos dan Internal Communications
// - Meeting Minutes
// - Project Updates

// **5. Business Vocabulary:**
// - Action-oriented language
// - Professional terminology
// - Positive phrasing
// - Clear calls to action

// **Contoh Email Structure:**
// Subject: Quarterly Marketing Report - Q3 2024

// Dear [Name],

// I am writing to share the Q3 2024 marketing performance report...

// Key highlights include:
// • 15% increase in website traffic
// • 25% growth in social media engagement
// • 10% rise in lead conversion

// Please find the detailed report attached...

// Best regards,
// [Your Name]
// ''',
//         tanggal: now.subtract(const Duration(days: 5)),
//         kategori: 'Business',
//         level: 'Lanjut',
//         estimatedMinutes: 40,
//         tags: ['Business', 'Professional', 'Email'],
//       ),
//     ];
//   }

//   void _search(String q) {
//     setState(() {
//       query = q;
//       _applyFilters();
//     });
//   }

//   void _filterByType(String type) {
//     setState(() {
//       selectedType = type;
//       _applyFilters();
//     });
//   }

//   void _applyFilters() {
//     filtered = items.where((m) {
//       final matchesSearch =
//           m.nama.toLowerCase().contains(query.toLowerCase()) ||
//           (m.content).toLowerCase().contains(query.toLowerCase()) ||
//           m.tags.any((tag) => tag.toLowerCase().contains(query.toLowerCase()));

//       final matchesType = selectedType == 'Semua' || m.kategori == selectedType;

//       return matchesSearch && matchesType;
//     }).toList();
//   }

//   void _openDetail(Materi m) {
//     final df = DateFormat.yMMMMd('id');
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (_) => DraggableScrollableSheet(
//         initialChildSize: 0.9,
//         minChildSize: 0.5,
//         maxChildSize: 0.95,
//         builder: (_, controller) => Container(
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//           ),
//           padding: const EdgeInsets.all(20),
//           child: Column(
//             children: [
//               Center(
//                 child: Container(
//                   width: 44,
//                   height: 6,
//                   decoration: BoxDecoration(
//                     color: Colors.grey.shade300,
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Expanded(
//                 child: ListView(
//                   controller: controller,
//                   children: [
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Text(
//                             m.nama,
//                             style: const TextStyle(
//                               fontSize: 22,
//                               fontWeight: FontWeight.w700,
//                               color: AppColors.primary,
//                             ),
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             setState(() {
//                               if (saved.contains(m.id))
//                                 saved.remove(m.id);
//                               else
//                                 saved.add(m.id);
//                             });
//                             Navigator.pop(context);
//                           },
//                           icon: Icon(
//                             saved.contains(m.id)
//                                 ? Icons.bookmark
//                                 : Icons.bookmark_border,
//                             color: AppColors.primary,
//                             size: 28,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         _buildChip(m.level, _getLevelColor(m.level)),
//                         const SizedBox(width: 8),
//                         _buildChip('${m.estimatedMinutes}m', Colors.blue),
//                         const SizedBox(width: 8),
//                         _buildChip(m.kategori, Colors.green),
//                       ],
//                     ),
//                     const SizedBox(height: 12),
//                     Text(
//                       'Diterbitkan: ${df.format(m.tanggal)}',
//                       style: TextStyle(
//                         color: Colors.grey.shade600,
//                         fontSize: 14,
//                       ),
//                     ),
//                     const SizedBox(height: 20),

//                     // Document Section
//                     Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: const Color(0xffF5EFE6),
//                         borderRadius: BorderRadius.circular(16),
//                         border: Border.all(
//                           color: AppColors.primary.withOpacity(0.2),
//                         ),
//                       ),
//                       child: Column(
//                         children: [
//                           const Icon(
//                             Icons.edit_document,
//                             size: 48,
//                             color: AppColors.primary,
//                           ),
//                           const SizedBox(height: 12),
//                           const Text(
//                             'Materi Menulis',
//                             style: TextStyle(
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           Text(
//                             m.documentFile ?? 'No document file',
//                             style: TextStyle(
//                               fontSize: 12,
//                               color: Colors.grey.shade600,
//                             ),
//                             textAlign: TextAlign.center,
//                           ),
//                           const SizedBox(height: 16),
//                           ElevatedButton.icon(
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: AppColors.primary,
//                               padding: const EdgeInsets.symmetric(
//                                 horizontal: 20,
//                                 vertical: 12,
//                               ),
//                             ),
//                             onPressed: () {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text('Membuka materi: ${m.nama}'),
//                                 ),
//                               );
//                             },
//                             icon: const Icon(Icons.open_in_new),
//                             label: const Text('Buka Materi'),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 24),

//                     // Content Section
//                     const Text(
//                       'Deskripsi Materi',
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(height: 12),
//                     Text(
//                       m.content,
//                       style: const TextStyle(fontSize: 15, height: 1.6),
//                     ),
//                     const SizedBox(height: 16),

//                     // Writing Tips
//                     Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.purple.shade50,
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(color: Colors.purple.shade100),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             '✍️ Tips Menulis Efektif',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 16,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           const Text(
//                             '• Outline sebelum mulai menulis\n'
//                             '• Write first, edit later\n'
//                             '• Gunakan vocabulary yang variatif\n'
//                             '• Perhatikan coherence dan cohesion\n'
//                             '• Always proofread sebelum submit',
//                             style: TextStyle(fontSize: 14, height: 1.5),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 16),

//                     // Tags
//                     Wrap(
//                       spacing: 8,
//                       runSpacing: 8,
//                       children: m.tags
//                           .map(
//                             (tag) => Chip(
//                               label: Text(tag),
//                               backgroundColor: Colors.grey.shade100,
//                             ),
//                           )
//                           .toList(),
//                     ),
//                     const SizedBox(height: 20),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
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
//         hintText: 'Cari materi writing...',
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

//   Widget _buildTypeFilter() {
//     return SizedBox(
//       height: 50,
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         children: types.map((type) {
//           final isSelected = selectedType == type;
//           return Padding(
//             padding: const EdgeInsets.only(right: 8),
//             child: FilterChip(
//               selected: isSelected,
//               onSelected: (_) => _filterByType(type),
//               label: Text(type),
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

//   Widget _tile(Materi m) {
//     final savedFlag = saved.contains(m.id);
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
//             Icons.edit_document,
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
//                   if (savedFlag)
//                     saved.remove(m.id);
//                   else
//                     saved.add(m.id);
//                 });
//               },
//               icon: Icon(
//                 savedFlag ? Icons.bookmark : Icons.bookmark_border,
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
//                   DateFormat('d MMM').format(m.tanggal),
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
//     final savedFlag = saved.contains(m.id);
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
//                   Icons.edit_document,
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
//                       if (savedFlag)
//                         saved.remove(m.id);
//                       else
//                         saved.add(m.id);
//                     });
//                   },
//                   icon: Icon(
//                     savedFlag ? Icons.bookmark : Icons.bookmark_border,
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
//         title: const Text('Writing Materials'),
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
//         color: const Color(0xffF7F9FB),
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             _searchBar(),
//             const SizedBox(height: 16),
//             _buildTypeFilter(),
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
//                             Icons.edit_outlined,
//                             size: 64,
//                             color: Colors.grey.shade400,
//                           ),
//                           const SizedBox(height: 16),
//                           const Text(
//                             'Tidak ada materi writing',
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
//                       itemBuilder: (_, i) => _gridItem(filtered[i]),
//                     )
//                   : ListView.builder(
//                       itemCount: filtered.length,
//                       itemBuilder: (_, i) => _tile(filtered[i]),
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
