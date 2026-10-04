import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/empty_state_view.dart';
import '../../../../core/widgets/loading_indicator.dart';
import '../../purchase/presentation/widgets/chat_bubble.dart';
import '../state/artisan_chat_provider.dart';

/// Assigned to: KUMARI R. P. G. D.
/// Branch: feature/artisan-management
class ArtisanChatScreen extends StatefulWidget {
  final String chatId;
  final String artisanId;
  final String buyerId;
  final String buyerName;

  const ArtisanChatScreen({
    Key? key,
    required this.chatId,
    required this.artisanId,
    required this.buyerId,
    required this.buyerName,
  }) : super(key: key);

  @override
  State<ArtisanChatScreen> createState() => _ArtisanChatScreenState();
}

class _ArtisanChatScreenState extends State<ArtisanChatScreen> {
  final TextEditingController _replyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ArtisanChatProvider()..listenToMessages(widget.chatId),
      child: Consumer<ArtisanChatProvider>(
        builder: (context, provider, _) {
          return Scaffold(
            appBar: CustomAppBar(title: 'Customer: ${widget.buyerName}'),
            body: Column(
              children: [
                Expanded(
                  child: provider.isLoading
                      ? const LoadingIndicator(message: 'Loading conversation...')
                      : provider.messages.isEmpty
                          ? const EmptyStateView(
                              icon: Icons.chat_bubble_outline,
                              title: 'Customer Messages',
                              description: 'Respond to buyer questions about your handcrafted items.',
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                              itemCount: provider.messages.length,
                              itemBuilder: (context, index) {
                                final msg = provider.messages[index];
                                final isMe = msg.senderId == widget.artisanId;
                                return ChatBubble(message: msg, isMe: isMe);
                              },
                            ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: const BoxDecoration(
                    color: AppColors.surface,
                    border: Border(top: BorderSide(color: AppColors.border)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _replyController,
                          decoration: const InputDecoration(
                            hintText: 'Reply to customer...',
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send, color: AppColors.primary),
                        onPressed: () {
                          final text = _replyController.text.trim();
                          if (text.isNotEmpty) {
                            provider.sendReply(
                              chatId: widget.chatId,
                              artisanId: widget.artisanId,
                              buyerId: widget.buyerId,
                              replyText: text,
                            );
                            _replyController.clear();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
