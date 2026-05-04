import 'package:move_on/features/chat/data/models/chat_message_model.dart';

/// Locally stored finished or backgrounded chat threads (titles + full message list).
class ArchivedChatSession {
  final String id;
  final String title;
  final DateTime updatedAt;
  final List<ChatMessageModel> messages;

  const ArchivedChatSession({
    required this.id,
    required this.title,
    required this.updatedAt,
    required this.messages,
  });

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'updatedAt': updatedAt.toIso8601String(),
    'messages': messages.map((e) => e.toJson()).toList(),
  };

  factory ArchivedChatSession.fromJson(Map<String, dynamic> json) {
    final rawMsgs = json['messages'] as List? ?? const [];
    return ArchivedChatSession(
      id: json['id']?.toString() ?? '',
      title: () {
        final t = json['title']?.toString().trim() ?? '';
        return t.isNotEmpty ? t : 'Chat';
      }(),
      updatedAt: DateTime.tryParse(json['updatedAt']?.toString() ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0),
      messages: rawMsgs
          .whereType<Map>()
          .map((e) => ChatMessageModel.fromJson(Map<String, dynamic>.from(e)))
          .toList(),
    );
  }
}

/// Picks a short title from the first substantive user line (or a dated fallback).
class ChatSessionTitle {
  ChatSessionTitle._();

  static String fromMessages(List<ChatMessageModel> messages) {
    for (final m in messages) {
      if (m.role == 'user') {
        final raw = m.text.trim().replaceAll(RegExp(r'\s+'), ' ');
        if (raw.isNotEmpty) {
          return raw.length > 56 ? '${raw.substring(0, 53)}…' : raw;
        }
      }
    }
    if (messages.isNotEmpty) {
      final raw = messages.first.text.trim().replaceAll(RegExp(r'\s+'), ' ');
      if (raw.isNotEmpty) {
        return raw.length > 56 ? '${raw.substring(0, 53)}…' : raw;
      }
    }
    final n = DateTime.now();
    return 'Chat ${n.day}/${n.month}/${n.year}';
  }
}
