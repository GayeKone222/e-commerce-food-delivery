import 'dart:convert';

import 'package:e_commerce/core/error/failure.dart';
import 'package:e_commerce/core/utils/api_constants.dart';
import 'package:e_commerce/features/data/models/auth_token_model.dart';
import 'package:e_commerce/features/data/models/user_model.dart';
import 'package:e_commerce/features/domain/entities/auth_token_entity.dart';
import 'package:http/http.dart' as http;

abstract class ApiAuthRemoteDataSource {
  Future<void> signUp({required UserModel user});
  Future<AuthTokenEntity> signIn({required UserModel user});
}

class ApiAuthRemoteDataSourceImpl implements ApiAuthRemoteDataSource {
  final http.Client httpClient;

  ApiAuthRemoteDataSourceImpl({required this.httpClient});

  @override
  Future<void> signUp({required UserModel user}) async {
    final url = Uri.parse(ApiConstant.authSignUpUrl);

    try {
      final response = await httpClient.post(url,
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            //'Authorization': 'Bearer token'
          },
          body:  json.encode(user.toJson()));
      // print("responses = ${response.body.toString()}");
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        // return List<ProductEntity>.from(
        //     data['products'].map((e) => ProductModel.fromJson(e)));
      } else {
        throw Failure(message: "message");
      }
    } catch (e) {
      print("signUP error ${e.toString()}");

      throw Failure(message: e.toString());
    }
  }

  @override
  Future<AuthTokenEntity> signIn({required UserModel user}) async {
    final url = Uri.parse(ApiConstant.authSignInUrl);

    try {
      final response = await httpClient.post(url,
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            //'Authorization': 'Bearer token'
          },
          body: json.encode(user.toJson()));
      // print("responses = ${response.body.toString()}");
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        AuthTokenEntity authTokenEntity = AuthTokenModel.fromJson(data);
        return authTokenEntity;
        //return data['token'];
      } else {
        print("signIn error ${response.body}");
        throw Failure(message: "message");
      }
    } catch (e) {
      print("signIn error ${e.toString()}");

      throw Failure(message: e.toString());
    }
  }
}
