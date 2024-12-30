// import 'dart:developer';
// import 'package:halqahquran/feature/Auth/data/model/user_model.dart';
// import 'package:intl/intl.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:dartz/dartz.dart';
// import 'package:halqahquran/core/global/global_function/fun_to_convert_hour.dart';
// import 'package:halqahquran/core/service/firebase_sevice.dart';
// import 'package:halqahquran/core/error/network_error.dart';
// import 'package:halqahquran/feature/chat/data/model/chat_model.dart';
// import 'package:halqahquran/feature/chat/data/model/massage_model.dart';
// import 'package:uuid/uuid.dart';

// class FirebaseChatOperation {
//   FirebaseService firebaseService = FirebaseService();
//   var uuid = Uuid();
// //get all user
//   Future<Either<String, List<UserModel>>> getAllUser(
//       String currentUserId) async {
//     try {
//       QuerySnapshot querySnapshot =
//           await firebaseService.getAllDocuments(collection: 'user_info');

//       List<UserModel> users = querySnapshot.docs
//           .where((doc) => doc['id'] != currentUserId)
//           .map((doc) =>
//               UserModel.fromDocument(doc.data() as Map<String, dynamic>))
//           .toList();

//       return right(users);
//     } on FirebaseException catch (e) {
//       return Left(e.toString());
//     } catch (e) {
//       return Left(e.toString());
//     }
//   }

// //creat new chat
//   Future<bool> createChat(
//       {required String currentUserId, required String otherUserId}) async {
//     String chatId = uuid.v4();
//     try {
//       QuerySnapshot querySnapshot = await firebaseService
//           .getAllDocumentsWithCondition(collection: 'chats')
//           .where('member', arrayContains: currentUserId)
//           .get();

//       List<ChatsModel> existingChats = querySnapshot.docs
//           .map((doc) =>
//               ChatsModel.fromDocument(doc.data() as Map<String, dynamic>))
//           .toList();

//       bool chatExists = false;
//       String existingChatId;

//       // Loop through the existing chats and check if both participants are in the chat
//       for (var chatDoc in existingChats) {
//         List members = chatDoc.member;
//         if (members.contains(otherUserId)) {
//           chatExists = true;
//           existingChatId = chatDoc.chatId;
//           break;
//         }
//       }
//       if (!chatExists) {
//         // Create a new chat if it doesn't already exist
//         UserModel otherUser = await getUserInfo(idUser: otherUserId);
//         UserModel currentUser = await getUserInfo(idUser: currentUserId);

//         var otherUserMap = otherUser.toMap();
//         var currentUserMap = currentUser.toMap();

//         var chatDate = {
//           'member': [currentUserId, otherUserId],
//           'lastMessage': ' ', // No messages yet
//           'chatId': chatId,
//           'timestamp': DateTime.now().microsecondsSinceEpoch,
//           'otherUserData': otherUserMap,
//           'currentUserData': currentUserMap,
//           'timelastMessage': ' '
//         };
//         await firebaseService.setData(
//             collection: 'chats', documentId: chatId, data: chatDate);
//         log("created");
//         return true;
//       } else {
//         log("Chat already exists with ID:");
//         return false;
//       }
//     } catch (e) {
//       log("Error creating chat: $e");
//       return false;
//     }
//   }

//   //get user info
//   Future<UserModel> getUserInfo({required String idUser}) async {
//     DocumentSnapshot userSnapshot = await firebaseService.getData(
//       collection: 'user_info',
//       documentId: idUser,
//     );

//     var userModel =
//         UserModel.fromDocument(userSnapshot.data() as Map<String, dynamic>);

//     return userModel;
//   }

//   //get user chats
//   Stream<List<ChatsModel>> getUserChats() {
//     String currentUserId = firebaseService.getFirebaseUserId();

//     return firebaseService
//         .getAllDocumentsWithCondition(collection: 'chats')
//         .where('member', arrayContains: currentUserId)
//         .snapshots() //this whay i teel that wile be stram
//         .map((querySnapshot) {
//       // Map the snapshot to a list of ChatsModel
//       List<ChatsModel> chats = querySnapshot.docs
//           .map((doc) =>
//               ChatsModel.fromDocument(doc.data() as Map<String, dynamic>))
//           .toList();
//       chats.sort((a, b) => b.timestamp!.compareTo(a.timestamp!));

//       return chats;
//     });
//   }

// //send massage
//   Future<void> sendMessage(
//       {required String chatId, required MessageModel message}) async {
// //update
//     var partOfMassageData = {
//       'lastMessage': message.type == 'text' ? message.messageText : "image ",
//       'timestamp': DateTime.now().microsecondsSinceEpoch,
//       'timelastMessage':
//           convertToArabicAmPm(DateFormat.Hm().format(DateTime.now())),
//     };

//     await firebaseService.updateData(
//         collection: 'chats', documentId: chatId, data: partOfMassageData);

// //add massage
//     final messageRef = FirebaseFirestore.instance
//         .collection('chats')
//         .doc(chatId)
//         .collection('messages');

//     await messageRef.add(message.toMap());
//   }

//   //get massage
//   Stream<List<MessageModel>> getMassage({required String chatId}) {
//     return FirebaseFirestore.instance
//         .collection('chats')
//         .doc(chatId)
//         .collection('messages')
//         .orderBy('timestamp', descending: true)
//         .snapshots()
//         .map((querySnapshot) {
//       return querySnapshot.docs
//           .map((doc) => MessageModel.fromMap(doc.data()))
//           .toList();
//     });
//   }

//   //update lastsean
//   Future<void> updateLastSean({required String status}) async {
//     var data = {'lastSean': status};
//     await firebaseService.updateData(
//         collection: 'user_info',
//         documentId: firebaseService.getFirebaseUserId(),
//         data: data);
//   }

//   Stream<String> getlastSeanUser(String userId) {
//     return FirebaseFirestore.instance
//         .collection('user_info')
//         .doc(userId)
//         .snapshots()
//         .map((value) {
//       return value['lastSean'];
//     });
//   }

//   Stream<List<UserModel>> getActiveUsers() {
//     String currentUserId = firebaseService.getFirebaseUserId();
//     return FirebaseFirestore.instance
//         .collection('user_info')
//         .where('lastSean', isEqualTo: 'online')
//         .where(FieldPath.documentId,
//             isNotEqualTo: currentUserId) // Exclude the current user

//         .snapshots()
//         .map((snapshot) {
//       return snapshot.docs.map((doc) {
//         return UserModel.fromDocument(doc.data());
//       }).toList();
//     });
//   }

//   //mark seen massage
//   void markMessagesAsRead(String chatId) async {
//     // Get the collection of messages for the chat
//     CollectionReference messages = FirebaseFirestore.instance
//         .collection('chats')
//         .doc(chatId)
//         .collection('messages');
//     String currentUserId = firebaseService.getFirebaseUserId();
//     // Fetch all messages where isRead is false and the sender is not the current user
//     QuerySnapshot unreadMessages = await messages
//         .where('isRead', isEqualTo: false)
//         .where('senderId', isNotEqualTo: currentUserId)
//         .get();

//     // Batch write to mark all unread messages as read
//     WriteBatch batch = FirebaseFirestore.instance.batch();

//     for (var doc in unreadMessages.docs) {
//       batch.update(doc.reference, {'isRead': true});
//     }

//     // Commit the batch
//     await batch.commit();
//   }

//   //delet chat withuser
//   Future<bool> deletUser({required String chatId}) async {
//     try {
//       await FirebaseFirestore.instance.collection('chats').doc(chatId).delete();

//       return true;
//     } on Exception catch (e) {
//       return false;
//     }
//   }
// }
