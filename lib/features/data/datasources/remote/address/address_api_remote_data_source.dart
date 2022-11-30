import 'dart:convert';

import 'package:e_commerce/core/error/failure.dart';
import 'package:e_commerce/core/utils/api_constants.dart';
import 'package:e_commerce/features/data/models/address_model.dart';
import 'package:e_commerce/features/domain/entities/address_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

abstract class ApiAddressRemoteDataSource {
  Future<String> getAddressFromGeocode(
      {required LatLng latLng, required String token});

  Future<AddressEntity> getAddress(
      {
      //required int userId,
      required String token});

  Future<void> addAddress(
      {required AddressEntity addressEntity, required String token});

  Future<void> updateAddress(
      {required AddressEntity addressEntity, required String token});
}

class ApiAddressRemoteDataSourceImpl implements ApiAddressRemoteDataSource {
  final http.Client httpClient;

  ApiAddressRemoteDataSourceImpl({required this.httpClient});

  @override
  Future<String> getAddressFromGeocode(
      {required LatLng latLng, required String token}) async {
    final url = Uri.parse(
        "${ApiConstant.geocodeUrl}?lat=${latLng.latitude}&lng=${latLng.longitude}");
    print("getAddressFromGeocode url = $url");

    try {
      final response = await httpClient.get(
        url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      );
      print("getAddressFromGeocode = ${response.body.toString()}");
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        String address = data['results'][0]['formatted_address'].toString();
        print("getAddressFromGeocode : $address");
        return address;
        //return data['token'];
      } else {
        print("getAddressFromGeocode error1 ${response.body}");
        throw Failure(message: "message");
      }
    } catch (e) {
      print("getAddressFromGeocode error2 ${e.toString()}");

      throw Failure(message: e.toString());
    }
  }

  @override
  Future<void> addAddress(
      {required AddressEntity addressEntity, required String token}) async {
    final url = Uri.parse(ApiConstant.addUserAddressUrl);
    try {
      final response = await httpClient.post(url,
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: json.encode(
              AddressModel.fromEntity(addressEntity: addressEntity).toJson()));

      if (response.statusCode == 200) {
      } else {
        print("signIn error ${response.body}");
        throw Failure(message: "message");
      }
    } catch (e) {
      print("signIn error ${e.toString()}");

      throw Failure(message: e.toString());
    }
  }

  @override
  Future<AddressEntity> getAddress(
      {
      //required int userId,

      required String token}) async {
    final url = Uri.parse(ApiConstant.getUserAddressUrl);
    try {
      final response = await httpClient.get(
        url,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
        // body: json.encode({"user_id": userId})
      );

      print("getAddress body ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        print("getAddress : $data");

        AddressEntity addressEntity = AddressModel.fromJson(data[0]);
        return addressEntity;
      } else {
        print("getAddress error1 ${response.body}");
        throw Failure(message: "message");
      }
    } catch (e) {
      print("getAddress error2 ${e.toString()}");

      throw Failure(message: e.toString());
    }
  }

  @override
  Future<void> updateAddress(
      {required AddressEntity addressEntity, required String token}) async {
    final url =
        Uri.parse("${ApiConstant.updateUserAddressUrl}${addressEntity.id}");
    try {
      final response = await httpClient.post(url,
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: json.encode(
              AddressModel.fromEntity(addressEntity: addressEntity).toJson()));

      if (response.statusCode == 200) {
      } else {
        print("updateAddress error ${response.body}");
        throw Failure(message: "message");
      }
    } catch (e) {
      print("updateAddress error ${e.toString()}");

      throw Failure(message: e.toString());
    }
  }
}
