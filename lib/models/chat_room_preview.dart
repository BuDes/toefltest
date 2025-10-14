import 'package:intl/intl.dart';
import 'package:toeflapp/models/user.dart';

class ChatRoomPreview {
  final User oppose;
  final String? pesanTerakhir;
  final bool isTerakhirKirim;
  final DateTime? tglPesan;
  final DateTime? tglBaca;

  ChatRoomPreview({
    required this.oppose,
    required this.pesanTerakhir,
    required this.isTerakhirKirim,
    required this.tglPesan,
    required this.tglBaca,
  });

  String get jamPesan {
    if (tglPesan == null) return "";
    if (_isSameDay) {
      return DateFormat("hh.mm").format(tglPesan!);
    }
    if (_isYesterday) return "Kemarin";
    return DateFormat("dd/MM/yyyy").format(tglPesan!);
  }

  bool get _isSameDay {
    final today = DateTime.now();
    return tglPesan!.year == today.year &&
        tglPesan!.month == today.month &&
        tglPesan!.day == today.day;
  }

  bool get _isYesterday {
    final today = DateTime.now();
    return tglPesan!.year == today.year &&
        tglPesan!.month == today.month &&
        tglPesan!.day == today.day - 1;
  }

  bool get unread => tglBaca == null && pesanTerakhir != null;
}
