import 'package:move_on/features/chat/data/models/chat_message_model.dart';

sealed class ChatBotState {}

class ChatBotInitial extends ChatBotState {}

class ChatBotLoading extends ChatBotState {}

class ChatBotSuccess extends ChatBotState {
  final List<ChatMessageModel> messages;
  ChatBotSuccess(this.messages);
}

class ChatBotError extends ChatBotState {
  final String message;
  ChatBotError(this.message);
}
