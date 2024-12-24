import 'package:firebase_auth/firebase_auth.dart';
import 'package:halqahquran/core/global/global_function/fun_to_convert_hour.dart';
import 'package:halqahquran/feature/Auth/domain/entity/user_entity.dart';
import 'package:intl/intl.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.email,
    required super.name,
    required super.image,
    required super.lastSean,
  });
//when i get from firebase and i want to convert it to user model
  factory UserModel.fromFirebase(User user) {
    return UserModel(
      lastSean: convertToArabicAmPm(DateFormat.Hm().format(DateTime.now())),
      id: user.uid,
      email: user.email ?? '',
      name: user.displayName ?? '',
      image: user.photoURL ?? '',
    );
  }
  factory UserModel.fromUserEntity(UserEntity userEntity) {
    return UserModel(
      lastSean: userEntity.lastSean,
      name: userEntity.name,
      email: userEntity.email,
      id: userEntity.id,
      image: userEntity.image,
    );
  }
//when i get from backend and i want to convert it to user model(get data from backend)
  factory UserModel.fromDocument(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      email: map['email'],
      name: map['name'],
      image: map['image'],
      lastSean: map['lastSean'],
    );
  }
  //   factory UserModel.fromDocument(Map<String, dynamic> doc) {
//     return UserModel(
//         userId: doc['id'], // Adjust based on your document structure
//         email: doc['email'], // Ensure the field names match
//         name: doc['name'],
//         lastSean: doc['lastSean']);
//   }
  //to add data  to backend
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'image': image,
      'lastSean': lastSean
    };
  }
}
