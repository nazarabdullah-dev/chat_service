import 'package:chat_service/src/data/model/message.dart';
import 'package:equatable/equatable.dart';

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
