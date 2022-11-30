// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final int? id;
  final String addressType;
  final String? contactPersonName;
  final String? contactPersonNumber;
  final String address;
  final String latitude;
  final String longitude;

  const AddressEntity(
      {this.id,
      required this.addressType,
      this.contactPersonName,
      this.contactPersonNumber,
      required this.address,
      required this.latitude,
      required this.longitude});


    AddressEntity copyWith({
    int? id,
    String? addressType,
    String? contactPersonName,
    String? contactPersonNumber,
    String? address,
    String? latitude,
    String? longitude,
  }) {
    return AddressEntity(
      id: id ?? this.id,
      addressType: addressType ?? this.addressType,
      contactPersonName: contactPersonName ?? this.contactPersonName,
      contactPersonNumber: contactPersonNumber ?? this.contactPersonNumber,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  @override
  List<Object?> get props => [
        id,
        addressType,
        contactPersonName,
        contactPersonNumber,
        address,
        latitude,
        longitude
      ];


}
