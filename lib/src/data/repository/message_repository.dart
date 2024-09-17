import 'package:chat_service/src/data/model/message.dart';

abstract class MessageRepository {
  Future<void> sendMessage(Message message);
  Stream<List<Message>> getMessages();
}
