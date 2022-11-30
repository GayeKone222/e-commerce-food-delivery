import 'package:e_commerce/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce/features/data/datasources/local/User_Address/user_address_local_data_source.dart';
import 'package:e_commerce/features/data/datasources/local/auth/auth_api_local_data_source.dart';
import 'package:e_commerce/features/data/datasources/remote/address/address_api_remote_data_source.dart';
import 'package:e_commerce/features/data/datasources/remote/user/user_api_remote_data_source.dart';
import 'package:e_commerce/features/domain/entities/address_entity.dart';
import 'package:e_commerce/features/domain/entities/user_entity.dart';
import 'package:e_commerce/features/domain/repositories/address_repository.dart';
import 'package:e_commerce/features/domain/repositories/user_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';

class AddressRepositoryImpl implements AddressRepository {
  final ApiAddressRemoteDataSource addressRemoteDataSource;
  final UserAddressLocalDataSource addressLocalDataSource;
  final AuthLocalDataSource authLocalDataSource;

  AddressRepositoryImpl(
      {required this.addressRemoteDataSource,
      required this.authLocalDataSource,
      required this.addressLocalDataSource});

  @override
  Future<Either<Failure, String>> getAddressFromGeocode(
      {required LatLng latLng}) async {
    try {
      //get token
      String? token = authLocalDataSource.getToken();
      if (token != null) {
        String address = await addressRemoteDataSource.getAddressFromGeocode(
            token: token, latLng: latLng);
        return Right(address);
      } else {
        return Left(Failure(message: "You should log in"));
      }
    }

    //  on Failure {
    //   rethrow;
    // }
    catch (e) {
      if (kDebugMode) {
        print("getAddressFromGeocode error : $e");
      }
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addAddress(
      {required AddressEntity addressEntity}) async {
    try {
      //get token
      String? token = authLocalDataSource.getToken();
      if (token != null) {
        await addressRemoteDataSource.updateAddress(
            token: token, addressEntity: addressEntity);
        //store locally
        addressLocalDataSource.storeUserAddress(addressEntity: addressEntity);
        return const Right(null);
      } else {
        return Left(Failure(message: "addAddress failed"));
      }
    } catch (e) {
      if (kDebugMode) {
        print("addAddress error : $e");
      }
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, AddressEntity>> getAddress(
    //  {required int userId}
      ) async {
    try {
      AddressEntity? address = addressLocalDataSource.getUserAddress();

      if (address != null) {
        return Right(address);
      } else {
        //get token
        String? token = authLocalDataSource.getToken();
        if (token != null) {
          AddressEntity address = await addressRemoteDataSource.getAddress(
              token: token,
              // userId: userId
              );
          return Right(address);
        } else {
          return Left(Failure(message: "getAddress failed"));
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("getAddress error3 : $e");
      }
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateAddress(
      {required AddressEntity addressEntity}) async {
    try {
      //get token
      String? token = authLocalDataSource.getToken();
      if (token != null) {
        await addressRemoteDataSource.updateAddress(
            token: token, addressEntity: addressEntity);
        //store locally
        addressLocalDataSource.storeUserAddress(addressEntity: addressEntity);
        return const Right(null);
      } else {
        return Left(Failure(message: "updateAddress failed"));
      }
    } catch (e) {
      if (kDebugMode) {
        print("updateAddress error : $e");
      }
      return Left(Failure(message: e.toString()));
    }
  }
}
