import 'package:chat_service/src/data/model/message.dart';
import 'package:chat_service/src/data/repository/login_repository.dart';
import 'package:chat_service/src/data/repository/message_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

// Define the ChatState
class ChatState extends Equatable {
  final List<Message> messages;
  final bool isLoading;
  final String room;
  final String? error;

  const ChatState({
    this.room = '',
    this.messages = const [],
    this.isLoading = false,
    this.error,
  });

  ChatState copyWith({
    List<Message>? messages,
    bool? isLoading,
    String? error,
    String? room,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      room: room ?? this.room,
    );
  }

  @override
  List<Object?> get props => [messages, isLoading, error, room];
}

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
