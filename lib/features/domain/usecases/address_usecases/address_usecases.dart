import 'package:dartz/dartz.dart';
import 'package:e_commerce/core/error/failure.dart';
import 'package:e_commerce/features/domain/entities/address_entity.dart';
import 'package:e_commerce/features/domain/repositories/address_repository.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressUsecases {
  final AddressRepository addressRepository;

  AddressUsecases({required this.addressRepository});

  Future<Either<Failure, String>> getAddressFromGeocode(
          {required LatLng latLng}) =>
      addressRepository.getAddressFromGeocode(latLng: latLng);

  Future<Either<Failure, AddressEntity>> getAddress(
    //{required int userId}
    ) =>
      addressRepository.getAddress(
        //userId: userId
        );

  Future<Either<Failure, void>> addAddress(
          {required AddressEntity addressEntity}) =>
      addressRepository.addAddress(addressEntity: addressEntity);

  Future<Either<Failure, void>> updateAddress(
          {required AddressEntity addressEntity}) =>
      addressRepository.updateAddress(addressEntity: addressEntity);
}
