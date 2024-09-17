import 'package:chat_service/src/data/cubit/chat_cubit.dart';
import 'package:chat_service/src/data/repository/login_repository.dart';
import 'package:chat_service/src/data/repository/message_repository.dart';
import 'package:chat_service/src/data/state/chat_state.dart';
import 'package:chat_service/src/di/dependency_injection.dart';
import 'package:chat_service/src/util/screen_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  static const routeName = '/chat';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            ChatCubit(getIt<MessageRepository>(), getIt<LoginRepository>()),
        child: const ChatScreenWidget());
  }
}

class ChatScreenWidget extends StatefulWidget {
  const ChatScreenWidget({super.key});

  @override
  State<ChatScreenWidget> createState() => _ChatScreenWidgetState();
}

class _ChatScreenWidgetState extends State<ChatScreenWidget> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    context.read<ChatCubit>().listenToMessages();
    super.initState();
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    context.read<ChatCubit>().sendMessage(text);
  }

  Widget _buildTextComposer() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: InputDecoration.collapsed(
                  hintText: AppLocalizations.of(context)!.send),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () => _handleSubmitted(_textController.text),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ScreenUtil.isTablet(context)
          ? null
          : AppBar(title: const Text('Chat')),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BlocBuilder<ChatCubit, ChatState>(builder: (context, state) {
            final messages = state.messages;
            if (messages.isEmpty) {
              return Expanded(
                  child: Center(
                      child:
                          Text(AppLocalizations.of(context)!.no_new_message)));
            }
            return Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                reverse: true,
                itemCount: messages.length,
                itemBuilder: (_, int index) => SizedBox(
                  width: double.infinity,
                  child: Container(
                    width: 200,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        messages[index].text,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }
}
