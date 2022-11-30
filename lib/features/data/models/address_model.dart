import 'package:e_commerce/features/domain/entities/address_entity.dart';

class AddressModel extends AddressEntity {
  const AddressModel(
      {required super.addressType,
      required super.address,
      required super.latitude,
      required super.longitude,
      super.contactPersonName,
      super.contactPersonNumber,
      super.id});

  factory AddressModel.fromJson(Map<String, dynamic> map) {
    return AddressModel(
      id: map['id'] as int?,
      addressType: map['address_type'] as String,
      address: map['address'] as String,
      latitude: map['latitude'] as String,
      longitude: map['longitude'] as String,
      contactPersonName: map['contact_person_name'] as String?,
      contactPersonNumber: map['contact_person_number'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "address_type": addressType,
      "address": address,
      "latitude": latitude,
      "longitude": longitude,
      "contact_person_name": contactPersonName,
      "contact_person_number": contactPersonNumber,
    };
  }

  factory AddressModel.fromEntity({AddressEntity? addressEntity}) {
    return AddressModel(
      id: addressEntity!.id,
      addressType: addressEntity.addressType,
      address: addressEntity.address,
      latitude: addressEntity.latitude,
      longitude: addressEntity.longitude,
      contactPersonName: addressEntity.contactPersonName,
      contactPersonNumber: addressEntity.contactPersonNumber,
    );
  }
}
