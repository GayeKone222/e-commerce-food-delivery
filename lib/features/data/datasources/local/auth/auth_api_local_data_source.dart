import 'dart:convert';

import 'package:e_commerce/core/error/failure.dart';
import 'package:e_commerce/core/utils/api_constants.dart';
import 'package:e_commerce/features/data/models/auth_token_model.dart';
import 'package:e_commerce/features/data/models/user_model.dart';
import 'package:e_commerce/features/domain/entities/auth_token_entity.dart';
import 'package:e_commerce/features/domain/entities/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthLocalDataSource {
  String? getToken();

  void storeToken({required String token});

  void clearTokenData();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  void clearTokenData() {
    try {
      if (sharedPreferences.containsKey(SharedPreferencesKeys.APP_TOKEN)) {
        sharedPreferences.remove(SharedPreferencesKeys.APP_TOKEN);
      }
    } catch (e) {
      print("clearTokenData error $e");
      throw Failure(message: "$e");
    }
  }

  @override
  String? getToken() {
    try {
      String? token;
      if (sharedPreferences.containsKey(SharedPreferencesKeys.APP_TOKEN)) {
        final data =
            sharedPreferences.getString(SharedPreferencesKeys.APP_TOKEN);

        AuthTokenEntity auth = AuthTokenModel.fromJson(jsonDecode(data!));

        token = auth.token;
        print("getToken token 1 : $token");
      }

      return token;
    } catch (e) {
      print("getToken error $e");
      throw Failure(message: "$e");
    }
  }

  @override
  void storeToken({required String token}) {
    try {
      sharedPreferences.setString(SharedPreferencesKeys.APP_TOKEN, token);
    } catch (e) {
      print("storeToken error : $e");
      throw Failure(message: "$e");
    }
  }
}
