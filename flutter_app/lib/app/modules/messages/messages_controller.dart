import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/models/message_model.dart';
import '../../data/providers/api_provider.dart';
import '../../services/socket_service.dart';

class MessagesController extends GetxController {
  final ApiProvider _apiProvider = Get.find<ApiProvider>();
  final SocketService _socketService = Get.find<SocketService>();

  final messageController = TextEditingController();
  final scrollController = ScrollController();
  
  final messages = <MessageModel>[].obs;
  final isLoading = false.obs;
  final isSending = false.obs;
  
  late String conversationId;
  late String recipientId;

  @override
  void onInit() {
    super.onInit();
    conversationId = Get.arguments['conversationId'] ?? '';
    recipientId = Get.arguments['recipientId'] ?? '';
    
    if (conversationId.isNotEmpty) {
      loadMessages();
      _setupSocketListeners();
    }
  }

  @override
  void onClose() {
    messageController.dispose();
    scrollController.dispose();
    super.onClose();
  }

  Future<void> loadMessages() async {
    try {
      isLoading.value = true;
      final response = await _apiProvider.getMessages(conversationId);
      final messageList = (response.data as List)
          .map((json) => MessageModel.fromJson(json))
          .toList();
      messages.value = messageList;
      _scrollToBottom();
    } catch (e) {
      print('Error loading messages: $e');
      Get.snackbar(
        'Error',
        'Failed to load messages',
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void _setupSocketListeners() {
    // Listen for new messages via socket
    _socketService.connect();
  }

  Future<void> sendMessage() async {
    final messageText = messageController.text.trim();
    if (messageText.isEmpty) return;

    try {
      isSending.value = true;
      
      // Add message to local list immediately for better UX
      final tempMessage = MessageModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        conversationId: conversationId,
        senderId: 'current_user', // This should be the actual user ID
        recipientId: recipientId,
        message: messageText,
        isRead: false,
        createdAt: DateTime.now(),
      );
      
      messages.add(tempMessage);
      messageController.clear();
      _scrollToBottom();

      // Send via API
      await _apiProvider.sendMessage(conversationId, messageText);
      
      // Send via socket for real-time delivery
      _socketService.sendMessage(conversationId, messageText, recipientId);
      
    } catch (e) {
      print('Error sending message: $e');
      // Remove the temporary message on error
      messages.removeWhere((msg) => msg.id == tempMessage.id);
      Get.snackbar(
        'Error',
        'Failed to send message',
        backgroundColor: Colors.red,
      );
    } finally {
      isSending.value = false;
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void addNewMessage(MessageModel message) {
    messages.add(message);
    _scrollToBottom();
  }

  String formatMessageTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}