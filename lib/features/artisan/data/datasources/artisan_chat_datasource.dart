import '../../../core/constants/firestore_collections.dart';
import '../../../core/services/firebase/firestore_service.dart';
import '../../../core/shared_models/chat_message_model.dart';

/// Assigned to: KUMARI R. P. G. D.
/// Branch: feature/artisan-management
class ArtisanChatDataSource {
  final FirestoreService _firestoreService;

  ArtisanChatDataSource({FirestoreService? firestoreService})
      : _firestoreService = firestoreService ?? FirestoreService();

  Stream<List<ChatMessageModel>> streamConversation(String chatId) {
    return _firestoreService.instance
        .collection(FirestoreCollections.chatMessages(chatId))
        .orderBy('timestamp', descending: false)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => ChatMessageModel.fromMap(doc.data(), doc.id)).toList());
  }

  Future<void> replyToBuyer(String chatId, ChatMessageModel message) async {
    await _firestoreService.addDocument(
      collection: FirestoreCollections.chatMessages(chatId),
      data: message.toMap(),
    );
  }
}
