import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toeflapp/theme/app_colors.dart';
import 'package:toeflapp/view_models/materi_view_model.dart';

class FavoriteIconButton extends StatefulWidget {
  const FavoriteIconButton({
    super.key,
    required this.id,
    required this.size,
  });

  final String id;
  final double size;

  @override
  State<FavoriteIconButton> createState() => _FavoriteIconButtonState();
}

class _FavoriteIconButtonState extends State<FavoriteIconButton> {
  late MateriViewModel _materiVM;
  bool? _isFav;

  void _toggleFavorite() async {
    await _materiVM.toggleFavorite(widget.id);
    _checkFavorite();
  }

  void _checkFavorite() async {
    final isFav = await _materiVM.isFavorite(widget.id);
    setState(() => _isFav = isFav);
  }

  @override
  void initState() {
    super.initState();
    _materiVM = context.read<MateriViewModel>();
    _checkFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: _toggleFavorite,
      icon: Icon(
        (_isFav ?? false) ? Icons.bookmark : Icons.bookmark_border,
        color: AppColors.primary,
        size: widget.size,
      ),
    );
  }
}
