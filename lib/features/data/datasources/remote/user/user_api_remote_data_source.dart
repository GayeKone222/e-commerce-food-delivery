import 'dart:convert';

import 'package:e_commerce/core/error/failure.dart';
import 'package:e_commerce/core/utils/api_constants.dart';
import 'package:e_commerce/features/data/models/user_model.dart';
import 'package:e_commerce/features/domain/entities/user_entity.dart';
import 'package:http/http.dart' as http;

abstract class ApiUserRemoteDataSource {
  Future<UserEntity> getUser({required String token});
}

class ApiUserRemoteDataSourceImpl implements ApiUserRemoteDataSource {
  final http.Client httpClient;

  ApiUserRemoteDataSourceImpl({required this.httpClient});

  @override
  Future<UserEntity> getUser({required String token}) async {
    final url = Uri.parse(ApiConstant.userInfoUrl);

    try {
      final response = await httpClient.get(
        url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      // print("responses = ${response.body.toString()}");
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        UserEntity userEntity = UserModel.fromJson(data);
        return userEntity;
      } else {
        print("getUser error ${response.body}");
        throw Failure(message: "message");
      }
    } catch (e) {
      print("getUser error ${e.toString()}");

      throw Failure(message: e.toString());
    }
  }
}
