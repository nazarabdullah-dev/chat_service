import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_service/src/data/model/message.dart';
import 'package:chat_service/src/data/repository/message_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MessageRepositoryImpl implements MessageRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String _collectionName = 'messages';

  @override
  Future<void> sendMessage(Message message) async {
    try {
      await _firestore.collection(_collectionName).add(message.toDocumentMap());
    } catch (e) {
      throw Exception('Failed to send message: ${e.toString()}');
    }
  }

  @override
  Stream<List<Message>> getMessages() {
    return _firestore
        .collection(_collectionName)
        .orderBy('timestamp', descending: true)
        .where('senderId', isEqualTo: _auth.currentUser?.uid)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Message.fromDocumentMap(doc.data()))
          .toList();
    });
  }
}
