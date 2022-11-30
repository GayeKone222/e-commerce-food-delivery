part of 'address_bloc.dart';

class AddressState extends Equatable {
  final AppStateStatus status;
  final AddressEntity? addressEntity;

  const AddressState(
      {this.status = AppStateStatus.initial, this.addressEntity});

  AddressState copyWith(
      {AppStateStatus? status, AddressEntity? addressEntity}) {
    return AddressState(
        status: status ?? this.status,
        addressEntity: addressEntity ?? this.addressEntity);
  }

  @override
  List<Object?> get props => [status, addressEntity];
}
