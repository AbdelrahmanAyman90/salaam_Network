import 'package:dartz/dartz.dart';
import 'package:halqahquran/feature/Auth/data/model/user_model.dart';
import 'package:halqahquran/feature/chat/data/model/chat_model.dart';
import 'package:halqahquran/feature/chat/data/model/massage_model.dart';

abstract class ChatRepo {
  Future<Either<String, List<UserModel>>> getAllUser(String currentUserId);

  Future<bool> createChat(
      {required String currentUserId, required String otherUserId});

  Future<UserModel> getUserInfo({required String idUser});

  Stream<List<ChatsModel>> getUserChats();

  Future<void> sendMessage(
      {required String chatId, required MessageModel message});

  Stream<List<MessageModel>> getMassage({required String chatId});

  Future<void> updateLastSean({required String status});

  Stream<String> getlastSeanUser(String userId);

  Stream<List<UserModel>> getActiveUsers();

  void markMessagesAsRead(String chatId);

  Future<bool> deletUser({required String chatId});
}
