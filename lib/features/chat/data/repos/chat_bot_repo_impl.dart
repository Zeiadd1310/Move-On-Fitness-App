import 'package:move_on/core/services/local_storage_service.dart';
import 'package:move_on/core/utils/functions/api_service.dart';
import 'package:move_on/features/chat/data/models/chat_message_model.dart';
import 'package:move_on/features/chat/data/repos/chat_bot_repo.dart';

class ChatBotRepoImpl implements ChatBotRepo {
  final ApiService apiService;
  final LocalStorageService localStorageService;

  ChatBotRepoImpl({
    required this.apiService,
    required this.localStorageService,
  });

  @override
  Future<String> sendMessage(String message) async {
    final token = await localStorageService.getToken();
    final response = await apiService.post(
      endPoint: 'Chatbot/send',
      body: {'message': message},
      token: token,
    );
    return response['reply'];
  }

  @override
  Future<List<ChatMessageModel>> getHistory() async {
    final token = await localStorageService.getToken();
    final response = await apiService.get(
      endPoint: 'Chatbot/history',
      token: token,
    );
    return (response as List).map((e) => ChatMessageModel.fromJson(e)).toList();
  }

  @override
  Future<void> clearHistory() async {
    final token = await localStorageService.getToken();
    await apiService.delete(endPoint: 'Chatbot/history', token: token);
  }
}
