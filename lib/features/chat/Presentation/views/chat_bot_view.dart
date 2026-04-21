import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:move_on/core/services/local_storage_service.dart';
import 'package:move_on/core/utils/functions/api_service.dart';
import 'package:move_on/features/chat/Presentation/cubits/chat_bot_cubit.dart';
import 'package:move_on/features/chat/Presentation/views/widgets/chat_bot_view_body.dart';
import 'package:move_on/features/chat/data/repos/chat_bot_repo_impl.dart';

class ChatBotView extends StatelessWidget {
  const ChatBotView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBotCubit(
        ChatBotRepoImpl(
          apiService: ApiService(),
          localStorageService: LocalStorageService(),
        ),
      ),
      child: const ChatBotViewBody(),
    );
  }
}
