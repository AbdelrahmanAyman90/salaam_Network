import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:halqahquran/feature/Auth/data/model/user_model.dart';
import 'package:halqahquran/feature/chat/data/model/massage_model.dart';

class ChatsModel {
  final String chatId;
  final List<String> member;
  final String? lastMessage;
  final int? timestamp;
  final UserModel otherUser;
  final UserModel currentUser;
  final String? timelastMessage;

  ChatsModel(
      {required this.chatId,
      required this.member,
      this.lastMessage,
      required this.currentUser,
      required this.otherUser,
      required this.timelastMessage,
      required this.timestamp});

  factory ChatsModel.fromDocument(Map<String, dynamic> doc) {
    return ChatsModel(
        chatId: doc['chatId'],
        member: List<String>.from(doc['member']),
        lastMessage: doc['lastMessage'],
        timestamp: doc['timestamp'],
        currentUser: UserModel.fromDocument(doc['currentUserData']),
        otherUser: UserModel.fromDocument(doc['otherUserData']),
        timelastMessage: doc['timelastMessage']);
  }
}
