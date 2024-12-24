import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:halqahquran/core/service/firebase_sevice.dart';
import 'package:halqahquran/feature/Auth/data/model/user_model.dart';
import 'package:halqahquran/feature/chat/data/firebase_chat_operation.dart';
import 'package:halqahquran/feature/chat/data/model/chat_model.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
  FirebaseChatOperation firebaseOperation = FirebaseChatOperation();
  FirebaseService firebaseService = FirebaseService();
  List<UserModel> allUserList = [];
  getAllUser() async {
    emit(GetAllUserLoading());
    String id = firebaseService.getFirebaseUserId();

    try {
      var result = await firebaseOperation.getAllUser(id);
      //await firebaseOperation.getUserInfo(idUser: id);
      result.fold((l) {
        log(l.toString());

        emit(GetAllUserFail(errorMassage: l));
      }, (r) {
        allUserList.clear();
        allUserList.addAll(r);
        emit(GetAllUserLoaded());
      });
    } on Exception catch (e) {
      log(e.toString());
      emit(GetAllUserFail(errorMassage: e.toString()));
    }
  }

  creatNewChat({required otherUserId, required String OtherName}) async {
    emit(GetAllUserLoading());
    String currentUserId = await firebaseService.getFirebaseUserId();

    try {
      var result = await firebaseOperation.createChat(
          currentUserId: currentUserId, otherUserId: otherUserId);
      if (result) {
        emit(CreatNewChatSuccses(massage: "now can chat with  '${OtherName}'"));
      } else {
        emit(CreatNewChatFail(
            errorMassage: "chat is Already Exist with '${OtherName}' "));
      }
    } on Exception catch (e) {
      log(e.toString());
      emit(GetAllUserFail(errorMassage: e.toString()));
    }
  }

  @override
  void onChange(Change<ChatState> change) {
    log(change.toString());
    super.onChange(change);
  }
}
