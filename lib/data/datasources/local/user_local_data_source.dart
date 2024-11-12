import 'dart:convert';

import 'package:youapp/data/datasources/sp_data.dart';
import 'package:youapp/data/models/user_model.dart';

class UserLocalDataSource {
  Future<void> saveUser(UserModel user) async {
    await SPData.save<String>("user", jsonEncode(user.toJson()));
  }

  Future<UserModel?> fetchUser() async {
    String? s = await SPData.load<String>("user");
    if (s == null) {
      return null;
    }

    return UserModel.fromJson(jsonDecode(s));
  }

  Future<String?> fetchToken() async {
    return SPData.load<String>("token");
  }
}
