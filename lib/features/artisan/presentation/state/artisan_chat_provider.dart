import 'package:flutter/material.dart';
import '../../../core/shared_models/chat_message_model.dart';
import '../../data/datasources/artisan_chat_datasource.dart';

/// Assigned to: KUMARI R. P. G. D.
/// Branch: feature/artisan-management
class ArtisanChatProvider extends ChangeNotifier {
  final ArtisanChatDataSource _dataSource;

  ArtisanChatProvider({ArtisanChatDataSource? dataSource})
      : _dataSource = dataSource ?? ArtisanChatDataSource();

  List<ChatMessageModel> _messages = [];
  bool _isLoading = false;

  List<ChatMessageModel> get messages => _messages;
  bool get isLoading => _isLoading;

  void listenToMessages(String chatId) {
    _isLoading = true;
    notifyListeners();

    _dataSource.streamConversation(chatId).listen((items) {
      _messages = items;
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> sendReply({
    required String chatId,
    required String artisanId,
    required String buyerId,
    required String replyText,
  }) async {
    final message = ChatMessageModel(
      id: '',
      senderId: artisanId,
      receiverId: buyerId,
      content: replyText,
    );
    await _dataSource.replyToBuyer(chatId, message);
  }
}
