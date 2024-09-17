import 'package:chat_service/src/data/model/message.dart';
import 'package:chat_service/src/data/repository/login_repository.dart';
import 'package:chat_service/src/data/repository/message_repository.dart';
import 'package:chat_service/src/data/state/chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Define the ChatCubit
class ChatCubit extends Cubit<ChatState> {
  final MessageRepository _messageRepository;
  final LoginRepository _loginRepository;

  ChatCubit(this._messageRepository, this._loginRepository)
      : super(const ChatState());

  void sendMessage(String message) async {
    try {
      emit(state.copyWith(isLoading: true));
      await _messageRepository.sendMessage(Message(
        text: message,
        timestamp: DateTime.now(),
        senderId: _loginRepository.getCurrentUser()?.uid ?? "",
      ));
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void listenToMessages() {
    _messageRepository.getMessages().listen((event) {
      final updatedMessages = event;
      emit(state.copyWith(messages: updatedMessages));
    });
  }
}
