import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toeflapp/models/user.dart';
import 'package:toeflapp/pages/chat/chat_detail_page.dart';
import 'package:toeflapp/theme/app_colors.dart';
import 'package:toeflapp/view_models/message_view_model.dart';

class ListPakarPage extends StatefulWidget {
  const ListPakarPage({super.key});

  @override
  State<ListPakarPage> createState() => _ListPakarPageState();
}

class _ListPakarPageState extends State<ListPakarPage> {
  List<User> _listPakar = [];

  void _getPakar() async {
    final listPakar = await context.read<MessageViewModel>().getPakar();
    setState(() => _listPakar = listPakar);
  }

  @override
  void initState() {
    super.initState();
    _getPakar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EFE6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.primary,
        elevation: 0,
        title: ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.primary, AppColors.accent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ).createShader(bounds),
          child: const Text(
            "Tanya Pakar",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 12),
        itemCount: _listPakar.length,
        itemBuilder: (context, index) {
          final pakar = _listPakar[index];
          return Card(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
            clipBehavior: Clip.hardEdge,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatDetailPage(oppose: pakar),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Row(
                  children: [
                    const SizedBox(width: 12),
                    const Icon(
                      Icons.account_circle,
                      size: 50,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            pakar.name,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const Text(
                            "Ketuk untuk mulai chat",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(
                      Icons.keyboard_arrow_right,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
