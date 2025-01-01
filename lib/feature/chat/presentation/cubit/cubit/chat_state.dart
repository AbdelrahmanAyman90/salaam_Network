part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class GetAllUserLoading extends ChatState {}

final class GetAllUserLoaded extends ChatState {}

final class GetAllUserFail extends ChatState {
  String errorMassage;
  GetAllUserFail({required this.errorMassage});
}

final class CreatNewChatSuccses extends ChatState {
  String massage;
  CreatNewChatSuccses({required this.massage});
}

final class CreatNewChatFail extends ChatState {
  String errorMassage;
  CreatNewChatFail({required this.errorMassage});
}

final class DeleteUserSuccess extends ChatState {}

final class DeleteUserFail extends ChatState {}

final class DeleteUserLoading extends ChatState {}
