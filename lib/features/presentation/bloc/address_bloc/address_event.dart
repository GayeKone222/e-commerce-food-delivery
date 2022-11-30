part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

class GetUserAddress extends AddressEvent {
  // final int userId;

  // const GetUserAddress({required this.userId});

  // @override
  // List<Object> get props => [userId];
}

class AddUserAddress extends AddressEvent {
  final AddressEntity addressEntity;

  const AddUserAddress({required this.addressEntity});

  @override
  List<Object> get props => [addressEntity];
}

class UpdateUserAddress extends AddressEvent {
  final AddressEntity addressEntity;

  const UpdateUserAddress({required this.addressEntity});

  @override
  List<Object> get props => [addressEntity];
}
