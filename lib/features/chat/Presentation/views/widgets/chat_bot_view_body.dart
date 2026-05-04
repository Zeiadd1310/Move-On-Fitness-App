import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:move_on/constants.dart';
import 'package:move_on/features/chat/Presentation/cubits/chat_bot_cubit.dart';
import 'package:move_on/features/chat/Presentation/cubits/chat_bot_state.dart';
import 'package:move_on/features/chat/data/models/chat_message_model.dart';
import 'package:move_on/features/welcome/presentation/views/widgets/custom_back_button.dart';

class ChatBotViewBody extends StatefulWidget {
  const ChatBotViewBody({super.key});

  @override
  State<ChatBotViewBody> createState() => _ChatBotViewBodyState();
}

class _ChatBotViewBodyState extends State<ChatBotViewBody> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  static const _bubbleDark = Color(0xFF2C2C2C);

  List<ChatMessageModel> _messages = [];
  bool _isWaitingReply = false;

  final List<String> _suggestions = [
    'Workout tips',
    'Daily meal plan',
    'Fat loss advice',
  ];

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    _controller.clear();
    setState(() {
      _messages.add(
        ChatMessageModel(role: 'user', text: text, createdAt: DateTime.now()),
      );
      _isWaitingReply = true;
    });
    context.read<ChatBotCubit>().sendMessage(text);
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocListener<ChatBotCubit, ChatBotState>(
          listener: (context, state) {
            if (state is ChatBotSuccess) {
              setState(() {
                _messages = List.from(state.messages);
                _isWaitingReply = false;
              });
              _scrollToBottom();
            } else if (state is ChatBotError) {
              setState(() => _isWaitingReply = false);
              final message = state.message.contains('500')
                  ? 'You exceeded your current quota, please return back later.'
                  : state.message;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  backgroundColor: Colors.redAccent,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              );
            }
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    CustomBackButton(width: 48, height: 48),
                    const SizedBox(width: 55),
                    const Text(
                      'Move On AI Coach',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  itemCount: _messages.length + (_isWaitingReply ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == _messages.length && _isWaitingReply) {
                      return const _TypingIndicator();
                    }
                    final msg = _messages[index];
                    final isUser = msg.role == 'user';
                    return _ChatBubble(
                      text: msg.text,
                      isUser: isUser,
                      time: msg.createdAt,
                      orange: kPrimaryColor,
                      bubbleDark: _bubbleDark,
                    );
                  },
                ),
              ),
              _SuggestionChips(
                suggestions: _suggestions,
                orange: kPrimaryColor,
                onTap: _sendMessage,
              ),
              _ChatInputBar(
                controller: _controller,
                orange: kPrimaryColor,
                onSend: () => _sendMessage(_controller.text),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final String text;
  final bool isUser;
  final DateTime time;
  final Color orange;
  final Color bubbleDark;

  const _ChatBubble({
    required this.text,
    required this.isUser,
    required this.time,
    required this.orange,
    required this.bubbleDark,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUser ? Alignment.centerLeft : Alignment.centerRight,
      child: Column(
        crossAxisAlignment: isUser
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.72,
            ),
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: isUser ? bubbleDark : orange,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: Radius.circular(isUser ? 4 : 16),
                bottomRight: Radius.circular(isUser ? 16 : 4),
              ),
            ),
            child: isUser
                ? Text(
                    text,
                    style: const TextStyle(color: Colors.white, fontSize: 15),
                  )
                : MarkdownBody(
                    data: text,
                    styleSheet: MarkdownStyleSheet(
                      p: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      strong: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      listBullet: const TextStyle(color: Colors.white),
                    ),
                  ),
          ),
          if (!isUser)
            Padding(
              padding: const EdgeInsets.only(right: 4, bottom: 4),
              child: Text(
                '${time.hour}:${time.minute.toString().padLeft(2, '0')} ${time.hour >= 12 ? 'PM' : 'AM'}',
                style: const TextStyle(color: Colors.white38, fontSize: 11),
              ),
            ),
        ],
      ),
    );
  }
}

class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Text(
          'Typing...',
          style: TextStyle(color: Colors.white54, fontSize: 14),
        ),
      ),
    );
  }
}

class _SuggestionChips extends StatelessWidget {
  final List<String> suggestions;
  final Color orange;
  final void Function(String) onTap;

  const _SuggestionChips({
    required this.suggestions,
    required this.orange,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final padH = (width * 0.03).clamp(8.0, 18.0);
    final chipPadH = (width * 0.035).clamp(10.0, 18.0);
    final chipPadV = (width * 0.022).clamp(7.0, 11.0);
    final gap = width < 360 ? 6.0 : 8.0;
    final fontSize = width < 340 ? 11.0 : (width < 400 ? 12.0 : 13.0);

    return Padding(
      padding: EdgeInsets.fromLTRB(padH, 8, padH, 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (var i = 0; i < suggestions.length; i++) ...[
              if (i > 0) SizedBox(width: gap),
              GestureDetector(
                onTap: () => onTap(suggestions[i]),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: chipPadH,
                    vertical: chipPadV,
                  ),
                  decoration: BoxDecoration(
                    color: orange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    suggestions[i],
                    maxLines: 1,
                    overflow: TextOverflow.visible,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: fontSize,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final Color orange;
  final VoidCallback onSend;

  const _ChatInputBar({
    required this.controller,
    required this.orange,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: const Color(0xFF2C2C2C),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            const Icon(Icons.alternate_email, color: Colors.white38, size: 20),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: controller,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  hintText: 'Text Messages',
                  hintStyle: TextStyle(color: Colors.white38),
                  border: InputBorder.none,
                  isDense: true,
                ),
                onSubmitted: (_) => onSend(),
              ),
            ),
            GestureDetector(
              onTap: onSend,
              child: CircleAvatar(
                backgroundColor: orange,
                radius: 18,
                child: const Icon(Icons.send, color: Colors.white, size: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
