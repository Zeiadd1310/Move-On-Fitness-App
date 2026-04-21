import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_on/features/chat/Presentation/cubits/chat_bot_state.dart';
import 'package:move_on/features/chat/data/models/chat_message_model.dart';
import 'package:move_on/features/chat/data/repos/chat_bot_repo.dart';

class ChatBotCubit extends Cubit<ChatBotState> {
  final ChatBotRepo repo;
  final List<ChatMessageModel> _messages = [];

  ChatBotCubit(this.repo) : super(ChatBotInitial());

  Future<void> loadHistory() async {
    emit(ChatBotLoading());
    try {
      final history = await repo.getHistory();
      _messages
        ..clear()
        ..addAll(history);
      emit(ChatBotSuccess(List.from(_messages)));
    } catch (e) {
      emit(ChatBotError(e.toString()));
    }
  }

  Future<void> sendMessage(String message) async {
    _messages.add(
      ChatMessageModel(role: 'user', text: message, createdAt: DateTime.now()),
    );
    emit(ChatBotLoading());
    try {
      final reply = await repo.sendMessage(message);
      _messages.add(
        ChatMessageModel(role: 'model', text: reply, createdAt: DateTime.now()),
      );
      emit(ChatBotSuccess(List.from(_messages)));
    } catch (e) {
      emit(ChatBotError(e.toString()));
    }
  }

  Future<void> clearHistory() async {
    try {
      await repo.clearHistory();
      _messages.clear();
      emit(ChatBotSuccess([]));
    } catch (e) {
      emit(ChatBotError(e.toString()));
    }
  }
}
