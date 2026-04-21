class ChatMessageModel {
  final String role;
  final String text;
  final DateTime createdAt;

  ChatMessageModel({
    required this.role,
    required this.text,
    required this.createdAt,
  });

  factory ChatMessageModel.fromJson(Map<String, dynamic> json) =>
      ChatMessageModel(
        role: json['role'],
        text: json['text'],
        createdAt: DateTime.parse(json['createdAt']),
      );
}
