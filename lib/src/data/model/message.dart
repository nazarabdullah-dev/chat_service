import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class Message {
  final String id;
  final String text;
  final DateTime timestamp;
  final String senderId;

  Message({
    String? id,
    required this.text,
    required this.timestamp,
    required this.senderId,
  }) : id = id ?? const Uuid().v4();

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      text: json['text'],
      senderId: json['senderId'],
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp']),
    );
  }
  factory Message.fromDocumentMap(Map<String, dynamic> documentMap) {
    return Message(
      text: documentMap['text'] as String,
      senderId: documentMap['senderId'] as String,
      timestamp: (documentMap['timestamp'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toDocumentMap() {
    return {
      'text': text,
      'timestamp': DateTime.timestamp(),
      'senderId': senderId,
    };
  }
}
