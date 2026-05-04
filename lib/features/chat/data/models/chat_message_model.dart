class ChatMessageModel {
  final String role;
  final String text;
  final DateTime createdAt;

  ChatMessageModel({
    required this.role,
    required this.text,
    required this.createdAt,
  });

  static String _pickString(Map<String, dynamic> json, List<String> keys) {
    for (final k in keys) {
      final v = json[k];
      if (v != null && v.toString().trim().isNotEmpty) {
        return v.toString();
      }
    }
    return '';
  }

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    final roleRaw =
        _pickString(json, ['role', 'Role', 'sender', 'Sender']).toLowerCase();
    final role =
        roleRaw.contains('user') ||
            roleRaw == 'human' ||
            roleRaw.contains('client')
        ? 'user'
        : 'model';

    final text = _pickString(json, [
      'text',
      'Text',
      'message',
      'Message',
      'content',
      'Content',
      'body',
      'Body',
      'reply',
      'Reply',
    ]);

    DateTime createdAt = DateTime.now();
    final timeRaw =
        json['createdAt'] ??
        json['CreatedAt'] ??
        json['timestamp'] ??
        json['Timestamp'] ??
        json['created_at'];
    if (timeRaw != null) {
      createdAt =
          DateTime.tryParse(timeRaw.toString()) ??
          DateTime.fromMillisecondsSinceEpoch(0);
    }

    return ChatMessageModel(role: role, text: text, createdAt: createdAt);
  }

  Map<String, dynamic> toJson() => {
    'role': role,
    'text': text,
    'createdAt': createdAt.toIso8601String(),
  };
}
