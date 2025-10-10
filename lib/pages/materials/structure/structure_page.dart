// // lib/pages/materials/structure/structure_page.dart
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:toeflapp/models/materi.dart';
// import 'package:toeflapp/theme/app_colors.dart';

// class StructurePage extends StatefulWidget {
//   const StructurePage({super.key});

//   @override
//   State<StructurePage> createState() => _StructurePageState();
// }

// class _StructurePageState extends State<StructurePage> {
//   List<Materi> items = [];
//   List<Materi> filtered = [];
//   String query = '';
//   bool gridMode = false;
//   Set<String> saved = {};
//   String selectedTopic = 'Semua';
//   final List<String> topics = ['Semua', 'Grammar', 'Sentence', 'Tenses', 'Clauses'];

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
//         id: 'S1',
//         nama: 'Grammar Fundamentals',
//         documentFile: 'https://example.com/docs/grammar_fundamentals.pdf',
//         content: '''
// **Dasar-dasar Tata Bahasa Inggris**

// **1. Parts of Speech:**
// • Noun: Kata benda (person, place, thing, idea)
// • Pronoun: Kata ganti (he, she, it, they)
// • Verb: Kata kerja (action atau state)
// • Adjective: Kata sifat (describes noun)
// • Adverb: Kata keterangan (modifies verb, adjective, adverb)
// • Preposition: Kata depan (shows relationship)
// • Conjunction: Kata hubung (connects words, phrases, clauses)
// • Interjection: Kata seru (expresses emotion)

// **2. Basic Sentence Structure:**
// - Subject + Verb (SV)
// - Subject + Verb + Object (SVO)
// - Subject + Verb + Complement (SVC)
// - Subject + Verb + Indirect Object + Direct Object (SVIO DO)

// **3. Common Errors:**
// - Subject-verb agreement
// - Pronoun-antecedent agreement
// - Verb tense consistency
// - Preposition usage

// **Contoh Analisis:**
// "The students (subject) are studying (verb) grammar (object)."
// ''',
//         tanggal: now.subtract(const Duration(days: 14)),
//         kategori: 'Grammar',
//         level: 'Pemula',
//         estimatedMinutes: 30,
//         tags: ['Basic', 'Grammar', 'Fundamentals'],
//       ),
//       Materi(
//         id: 'S2',
//         nama: 'Complex Sentences & Clauses',
//         documentFile: 'https://example.com/docs/complex_sentences.pdf',
//         content: '''
// **Kalimat Kompleks dan Klausa**

// **1. Types of Clauses:**
// • Independent Clause: Dapat berdiri sendiri sebagai kalimat
// • Dependent Clause: Tidak dapat berdiri sendiri, membutuhkan independent clause

// **2. Jenis Dependent Clauses:**
// - Adjective Clauses: Menggambarkan noun (who, which, that)
// - Adverb Clauses: Menunjukkan time, place, reason, condition
// - Noun Clauses: Berfungsi sebagai noun dalam kalimat

// **3. Sentence Combining:**
// Menggabungkan simple sentences menjadi complex sentences menggunakan:
// - Subordinating conjunctions (although, because, when)
// - Relative pronouns (who, which, that)
// - Participial phrases

// **4. Common Patterns:**
// - Complex Sentence: Independent + Dependent Clause
// - Compound-Complex: Multiple Independent + Dependent Clauses

// **Contoh:**
// "Although it was raining (dependent), we went to the park (independent)."
// ''',
//         tanggal: now.subtract(const Duration(days: 9)),
//         kategori: 'Sentence',
//         level: 'Menengah',
//         estimatedMinutes: 35,
//         tags: ['Complex', 'Clauses', 'Sentence Structure'],
//       ),
//       Materi(
//         id: 'S3',
//         nama: 'Verb Tenses Mastery',
//         documentFile: 'https://example.com/docs/verb_tenses.pdf',
//         content: '''
// **Penguasaan Tenses Bahasa Inggris**

// **1. Simple Tenses:**
// • Present Simple: Habits, facts, general truth
// • Past Simple: Completed actions in the past
// • Future Simple: Predictions, spontaneous decisions

// **2. Continuous Tenses:**
// • Present Continuous: Actions happening now
// • Past Continuous: Actions in progress in the past
// • Future Continuous: Actions in progress in the future

// **3. Perfect Tenses:**
// • Present Perfect: Past actions with present relevance
// • Past Perfect: Actions before another past action
// • Future Perfect: Actions completed before a future time

// **4. Perfect Continuous Tenses:**
// • Present Perfect Continuous: Duration from past to present
// • Past Perfect Continuous: Duration before another past action
// • Future Perfect Continuous: Duration before a future time

// **Signal Words:**
// - Present Perfect: already, yet, just, since, for
// - Past Perfect: by the time, before, after
// - Future Perfect: by, by the time

// **Contoh Perbandingan:**
// "I have lived here for 5 years." (masih tinggal)
// "I lived here for 5 years." (sudah tidak tinggal)
// ''',
//         tanggal: now.subtract(const Duration(days: 4)),
//         kategori: 'Tenses',
//         level: 'Menengah',
//         estimatedMinutes: 40,
//         tags: ['Tenses', 'Verbs', 'Grammar'],
//       ),
//       Materi(
//         id: 'S4',
//         nama: 'Advanced Clause Structures',
//         documentFile: 'https://example.com/docs/advanced_clauses.pdf',
//         content: '''
// **Struktur Klausa Tingkat Lanjut**

// **1. Reduced Clauses:**
// • Reduced Adjective Clauses: Menghilangkan relative pronoun dan verb
// • Reduced Adverb Clauses: Menggunakan participle phrases

// **2. Inversion:**
// • Negative Inversion: Never, seldom, rarely di awal kalimat
// • Conditional Inversion: Should, were, had di awal kalimat

// **3. Emphasis Structures:**
// • Cleft Sentences: It is/was... that...
// • Pseudo-cleft Sentences: What... is/was...

// **4. Advanced Connectors:**
// • Subordinating Conjunctions: whereas, insofar as, inasmuch as
// • Correlative Conjunctions: not only... but also, either... or

// **5. Stylistic Variations:**
// • Fronting: Memindahkan element non-subject ke awal kalimat
// • Postponement: Memindahkan heavy elements ke akhir kalimat

// **Contoh Advanced Structures:**
// "Not only did she complete the project, but she also exceeded expectations."
// "Had I known earlier, I would have helped."
// "What we need is more time."
// ''',
//         tanggal: now.subtract(const Duration(days: 1)),
//         kategori: 'Clauses',
//         level: 'Lanjut',
//         estimatedMinutes: 45,
//         tags: ['Advanced', 'Clauses', 'Stylistic'],
//       ),
//     ];
//   }

//   void _search(String q) {
//     setState(() {
//       query = q;
//       _applyFilters();
//     });
//   }

//   void _filterByTopic(String topic) {
//     setState(() {
//       selectedTopic = topic;
//       _applyFilters();
//     });
//   }

//   void _applyFilters() {
//     filtered = items.where((m) {
//       final matchesSearch = m.nama.toLowerCase().contains(query.toLowerCase()) ||
//           (m.content).toLowerCase().contains(query.toLowerCase()) ||
//           m.tags.any((tag) => tag.toLowerCase().contains(query.toLowerCase()));
      
//       final matchesTopic = selectedTopic == 'Semua' || m.kategori == selectedTopic;
      
//       return matchesSearch && matchesTopic;
//     }).toList();
//   }

//   void _openDetail(Materi m) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (_) => DraggableScrollableSheet(
//         initialChildSize: 0.85,
//         minChildSize: 0.5,
//         maxChildSize: 0.95,
//         builder: (_, controller) => Container(
//           padding: const EdgeInsets.all(20),
//           decoration: const BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//           ),
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
//                       'Diterbitkan: ${DateFormat.yMMMMd('id').format(m.tanggal)}',
//                       style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
//                     ),
//                     const SizedBox(height: 20),

//                     // Document Section
//                     Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: const Color(0xffF5EFE6),
//                         borderRadius: BorderRadius.circular(16),
//                         border: Border.all(color: AppColors.primary.withOpacity(0.2)),
//                       ),
//                       child: Column(
//                         children: [
//                           const Icon(
//                             Icons.architecture_rounded,
//                             size: 48,
//                             color: AppColors.primary,
//                           ),
//                           const SizedBox(height: 12),
//                           const Text(
//                             'Materi Struktur',
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

//                     // Grammar Tips
//                     Container(
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: Colors.orange.shade50,
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(color: Colors.orange.shade100),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             '💡 Tips Belajar Grammar',
//                             style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               fontSize: 16,
//                             ),
//                           ),
//                           const SizedBox(height: 8),
//                           const Text(
//                             '• Pahami pola dasar terlebih dahulu\n'
//                             '• Practice dengan contoh nyata\n'
//                             '• Perhatikan konteks penggunaan\n'
//                             '• Bandingkan dengan bahasa Indonesia\n'
//                             '• Buat catatan kesalahan umum',
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
//                       children: m.tags.map((tag) => Chip(
//                         label: Text(tag),
//                         backgroundColor: Colors.grey.shade100,
//                       )).toList(),
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
//       case 'Pemula': return Colors.green;
//       case 'Menengah': return Colors.orange;
//       case 'Lanjut': return Colors.red;
//       default: return Colors.grey;
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
//         hintText: 'Cari materi structure & grammar...',
//         prefixIcon: const Icon(Icons.search),
//         suffixIcon: query.isNotEmpty
//             ? IconButton(
//                 icon: const Icon(Icons.clear),
//                 onPressed: () => _search(''),
//               )
//             : null,
//         filled: true,
//         fillColor: Colors.white,
//         contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14),
//           borderSide: BorderSide.none,
//         ),
//       ),
//     );
//   }

//   Widget _buildTopicFilter() {
//     return SizedBox(
//       height: 50,
//       child: ListView(
//         scrollDirection: Axis.horizontal,
//         children: topics.map((topic) {
//           final isSelected = selectedTopic == topic;
//           return Padding(
//             padding: const EdgeInsets.only(right: 8),
//             child: FilterChip(
//               selected: isSelected,
//               onSelected: (_) => _filterByTopic(topic),
//               label: Text(topic),
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

//   Widget _listTile(Materi m) {
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
//             Icons.architecture_rounded,
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
//                   Icons.architecture_rounded,
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
//         title: const Text('Structure & Grammar'),
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
//         padding: const EdgeInsets.all(16),
//         color: const Color(0xffF5F8FA),
//         child: Column(
//           children: [
//             _searchBar(),
//             const SizedBox(height: 16),
//             _buildTopicFilter(),
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
//                             Icons.architecture_outlined,
//                             size: 64,
//                             color: Colors.grey.shade400,
//                           ),
//                           const SizedBox(height: 16),
//                           const Text(
//                             'Tidak ada materi structure',
//                             style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.grey,
//                             ),
//                           ),
//                         ],
//                       ),
//                     )
//                   : gridMode
//                       ? GridView.builder(
//                           gridDelegate:
//                               const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 2,
//                             childAspectRatio: 0.75,
//                             mainAxisSpacing: 16,
//                             crossAxisSpacing: 16,
//                           ),
//                           itemCount: filtered.length,
//                           itemBuilder: (_, i) => _gridItem(filtered[i]),
//                         )
//                       : ListView.builder(
//                           itemCount: filtered.length,
//                           itemBuilder: (_, i) => _listTile(filtered[i]),
//                         ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }