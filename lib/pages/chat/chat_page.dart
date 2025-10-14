import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:toeflapp/models/chat_room_preview.dart';
import 'package:toeflapp/pages/chat/chat_detail_page.dart';
import 'package:toeflapp/pages/chat/list_pakar_page.dart';
import 'package:toeflapp/theme/app_colors.dart';
import 'package:toeflapp/view_models/auth_view_model.dart';
import 'package:toeflapp/view_models/message_view_model.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _loading = true;

  void _loadPreviews() async {
    await context.read<MessageViewModel>().getChatroomPreviews();
    setState(() => _loading = false);
  }

  @override
  void initState() {
    super.initState();
    _loadPreviews();
  }

  @override
  Widget build(BuildContext context) {
    final isPakar = context.read<AuthViewModel>().role == "pakar";

    return Scaffold(
      backgroundColor: const Color(0xFFF5EFE6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
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
      body: _buildPreviews(),
      floatingActionButton: isPakar
          ? null
          : Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, AppColors.accent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(50),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: FloatingActionButton(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ListPakarPage()),
                    );
                  },
                  child: const Icon(
                    Iconsax.message_add,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildPreviews() {
    if (_loading) {
      return const SizedBox();
    }

    final listPreviews = context.watch<MessageViewModel>().listPreviews;
    if (listPreviews.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("📩", style: TextStyle(fontSize: 72)),
            SizedBox(height: 20),
            Text(
              "Belum ada chat",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Tanyakan apapun seputar TOEFL\ndan pakar akan menjawab ✨",
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF8D8D8D), fontSize: 14),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 12),
      itemCount: listPreviews.length,
      itemBuilder: (context, index) {
        final preview = listPreviews[index];
        return Card(
          color: Colors.white,
          margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
          clipBehavior: Clip.hardEdge,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatDetailPage(oppose: preview.oppose),
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
                          preview.oppose.name,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "${preview.isTerakhirKirim ? "You: " : ""}${preview.pesanTerakhir}",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  _buildTrailing(preview),
                  const SizedBox(width: 12),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTrailing(ChatRoomPreview preview) {
    return Column(
      children: [
        const Text(""),
        preview.unread
            ? const CircleAvatar(
                backgroundColor: AppColors.primary,
                radius: 8,
              )
            : const SizedBox(),
        const SizedBox(height: 4),
        Text(
          preview.jamPesan,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}
