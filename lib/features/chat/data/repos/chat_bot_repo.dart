import 'package:move_on/features/chat/data/models/chat_message_model.dart';

abstract class ChatBotRepo {
  Future<String> sendMessage(String message);
  Future<List<ChatMessageModel>> getHistory();
  Future<void> clearHistory();
}
