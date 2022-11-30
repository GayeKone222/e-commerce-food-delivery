import 'dart:convert';

import 'package:e_commerce/core/error/failure.dart';
import 'package:e_commerce/core/utils/api_constants.dart';
import 'package:e_commerce/features/data/models/address_model.dart';
import 'package:e_commerce/features/domain/entities/address_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserAddressLocalDataSource {
  AddressEntity? getUserAddress();

  void storeUserAddress({required AddressEntity addressEntity});

  void clearUserAddressData();
}

class UserAddressLocalDataSourceImpl implements UserAddressLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserAddressLocalDataSourceImpl({required this.sharedPreferences});

  @override
  void clearUserAddressData() {
    try {
      if (sharedPreferences.containsKey(SharedPreferencesKeys.USER_ADDRESS)) {
        sharedPreferences.remove(SharedPreferencesKeys.USER_ADDRESS);
      }
    } catch (e) {
      print("clearUserAddressData error $e");
      throw Failure(message: "$e");
    }
  }

  @override
  AddressEntity? getUserAddress() {
    try {
      AddressEntity? address;
      if (sharedPreferences.containsKey(SharedPreferencesKeys.USER_ADDRESS)) {
        final data =
            sharedPreferences.getString(SharedPreferencesKeys.USER_ADDRESS);

        address = AddressModel.fromJson(jsonDecode(data!));

        print("address 1 : $address");
      }

      return address;
    } catch (e) {
      print("getUserAddress error $e");
      throw Failure(message: "$e");
    }
  }

  @override
  void storeUserAddress({required AddressEntity addressEntity}) {
    try {
      sharedPreferences.setString(
          SharedPreferencesKeys.USER_ADDRESS,
          jsonEncode(
              AddressModel.fromEntity(addressEntity: addressEntity).toJson()));
    } catch (e) {
      print("storeUserAddress error : $e");
      throw Failure(message: "$e");
    }
  }
}
