import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toeflapp/models/jenis_materi.dart';
import 'package:toeflapp/pages/materials/detail_materi.dart';
import 'package:toeflapp/pages/materials/materi_card.dart';
import 'package:toeflapp/pages/materials/materi_grid_card.dart';
import 'package:toeflapp/theme/app_colors.dart';
import 'package:toeflapp/models/materi.dart';
import 'package:toeflapp/view_models/materi_view_model.dart';

class MateriPage extends StatefulWidget {
  const MateriPage({super.key, required this.jenis});

  final JenisMateri jenis;

  @override
  State<MateriPage> createState() => _MateriPageState();
}

class _MateriPageState extends State<MateriPage> {
  List<Materi> items = [];
  List<Materi> filtered = [];
  bool gridMode = false;
  String query = '';
  // TODO: shared preferences
  // Set<String> favorites = {};
  bool _loading = true;
  final _searchController = TextEditingController();
  late MateriViewModel _materiVM;

  void _search(String q) {
    setState(() {
      query = q;
      _applyFilters();
    });
  }

  void _applyFilters() {
    filtered = items.where((m) {
      final matchesSearch =
          m.nama.toLowerCase().contains(query.toLowerCase()) ||
          (m.intro).toLowerCase().contains(query.toLowerCase());

      return matchesSearch;
    }).toList();
  }

  void _openDetail(Materi m) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => DraggableScrollableSheet(
        maxChildSize: 0.95,
        initialChildSize: 0.85,
        minChildSize: 0.5,
        builder: (_, controller) {
          return DetailMateri(
            m: m,
            controller: controller,
          );
        },
      ),
    );
  }

  void _loadMateri() async {
    _materiVM = context.read<MateriViewModel>();
    items = await _materiVM.getMateriByJenis(
      widget.jenis.id,
    );
    _materiVM.currentMateri = items;
    setState(() {
      filtered = items;
      _loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadMateri();
    _materiVM.currentMateri = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.jenis.nama} Materials'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                gridMode = !gridMode;
              });
            },
            icon: Icon(gridMode ? Icons.view_list : Icons.grid_view),
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        color: const Color(0xffF8FAFC),
        child: Column(
          children: [
            _buildSearchBar(),
            const SizedBox(height: 16),
            if (query.isNotEmpty)
              Text(
                '${filtered.length} materi ditemukan',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            const SizedBox(height: 16),
            Expanded(
              child: _buildMateriView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchController,
      onChanged: _search,
      decoration: InputDecoration(
        hintText: 'Cari materi ${widget.jenis.nama}...',
        prefixIcon: const Icon(Icons.search),
        suffixIcon: query.isNotEmpty
            ? IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _search('');
                  _searchController.text = "";
                },
              )
            : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildMateriView() {
    if (_loading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Colors.grey,
            ),
            SizedBox(height: 16),
            Text(
              'Sedang memuat...',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      );
    }

    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            const Text(
              'Tidak ada materi yang cocok',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    if (gridMode) {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 3 / 5,
        ),
        itemCount: filtered.length,
        itemBuilder: (_, i) => MateriGridCard(
          m: filtered[i],
          openDetails: _openDetail,
        ),
      );
    }

    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (_, i) => MateriCard(
        m: filtered[i],
        openDetails: _openDetail,
      ),
    );
  }
}
