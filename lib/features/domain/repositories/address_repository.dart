import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/error/failure.dart';
import 'package:e_commerce/features/domain/entities/address_entity.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class AddressRepository {
  Future<Either<Failure, String>> getAddressFromGeocode(
      {required LatLng latLng});

  Future<Either<Failure, AddressEntity>> getAddress(
   // {required int userId}
    );

  Future<Either<Failure, void>> addAddress(
      {required AddressEntity addressEntity});

  Future<Either<Failure, void>> updateAddress(
      {required AddressEntity addressEntity});
}
