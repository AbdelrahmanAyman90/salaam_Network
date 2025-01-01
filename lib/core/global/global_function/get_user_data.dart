import 'dart:convert';

import 'package:halqahquran/core/util/app_pref.dart';
import 'package:halqahquran/core/util/const_varible.dart';
import 'package:halqahquran/feature/Auth/domain/entity/user_entity.dart';

import '../../../feature/Auth/data/model/user_model.dart';

UserEntity getUserData() {
  var jsonString = SharedPrefService.getString(kUser);

  return UserModel.fromDocument(jsonDecode(jsonString));
}
