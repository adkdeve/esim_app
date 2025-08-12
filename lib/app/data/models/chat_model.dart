class ChatModel {
  final String id;
  final String name;
  final String lastMessage;
  final String time;
  final int unreadCount;

  ChatModel({
    required this.id,
    required this.name,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
  });
}
