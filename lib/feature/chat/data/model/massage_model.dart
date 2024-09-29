import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String senderId;
  final String messageText;
  final int timestamp;
  final bool isRead;
  final String type; // 'text', 'image', etc.
  final String timeSendMassage;

  MessageModel(
      {required this.senderId,
      required this.messageText,
      required this.timestamp,
      required this.isRead,
      required this.type,
      required this.timeSendMassage});

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'messageText': messageText,
      'timestamp': timestamp,
      'isRead': isRead,
      'type': type,
      'timeSendMassage': timeSendMassage
    };
  }

  static MessageModel fromMap(Map<String, dynamic> map) {
    return MessageModel(
        senderId: map['senderId'],
        messageText: map['messageText'],
        timestamp: (map['timestamp']),
        isRead: map['isRead'],
        type: map['type'],
        timeSendMassage: map['timeSendMassage']);
  }
}
