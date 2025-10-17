import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toeflapp/models/message.dart';
import 'package:toeflapp/models/user.dart';
import 'package:toeflapp/theme/app_colors.dart';
import 'package:toeflapp/view_models/auth_view_model.dart';
import 'package:toeflapp/view_models/message_view_model.dart';

const Color primaryBlue = AppColors.primary;
const Color accentOrange = AppColors.accent;

class ChatDetailPage extends StatefulWidget {
  const ChatDetailPage({super.key, required this.oppose});
  final User oppose;

  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.trim().isEmpty) return;
    final idPengirim = context.read<AuthViewModel>().currentUser!.id;
    final pesan = ChatMessage(
      id: null,
      isi: _controller.text.trim(),
      status: StatusPesan.pending,
      waktuKirim: DateTime.now(),
      idPengirim: idPengirim,
      idPenerima: widget.oppose.id,
    );
    context.read<MessageViewModel>().createMessage(pesan, widget.oppose);
    _controller.text = "";
    // setState(() {
    //   messages.add({"sender": "user", "text": _controller.text.trim()});
    // });
    // _controller.clear();

    // // Simulasi balasan bot
    // Future.delayed(const Duration(milliseconds: 800), () {
    //   setState(() {
    //     messages.add({"sender": "bot", "text": "Oke, saya catat ya! ✨"});
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    final messages = context.watch<MessageViewModel>().getPesanByUser(
      widget.oppose.id,
    );
    context.read<MessageViewModel>().readPesan(widget.oppose.id);

    return Scaffold(
      backgroundColor: const Color(0xFFF5EFE6),
      appBar: AppBar(
        backgroundColor: primaryBlue,
        elevation: 2,
        title: Text(
          widget.oppose.name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final msg = messages[index];
                final id = context.read<AuthViewModel>().currentUser!.id;
                final isPengirim = msg.isPengirim(id);
                return Align(
                  alignment: isPengirim
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isPengirim
                          ? accentOrange
                          : primaryBlue.withOpacity(0.9),
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: isPengirim
                            ? const Radius.circular(16)
                            : Radius.zero,
                        bottomRight: isPengirim
                            ? Radius.zero
                            : const Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Text(
                            msg.isi,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        if (msg.status == StatusPesan.pending)
                          const SizedBox(width: 8),
                        if (msg.status == StatusPesan.pending)
                          const Icon(
                            Icons.pending_outlined,
                            size: 15,
                            color: Colors.white54,
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      minLines: 1,
                      maxLines: 4,
                      decoration: InputDecoration(
                        hintText: "Ketik pesan...",
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: const BoxDecoration(
                        color: primaryBlue,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
