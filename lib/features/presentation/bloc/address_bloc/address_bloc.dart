import 'package:bloc/bloc.dart';
import 'package:e_commerce/core/utils/enums.dart';
import 'package:e_commerce/features/domain/entities/address_entity.dart';
import 'package:e_commerce/features/domain/usecases/address_usecases/address_usecases.dart';
import 'package:equatable/equatable.dart';

part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final AddressUsecases addressUsecases;
  AddressBloc({required this.addressUsecases}) : super(const AddressState()) {
    on<GetUserAddress>(_onGetUserAddress);
    on<AddUserAddress>(_onAddUserAddress);
    on<UpdateUserAddress>(_onUpdateUserAddress);
  }

  void _onGetUserAddress(
      GetUserAddress event, Emitter<AddressState> emit) async {
    emit(state.copyWith(status: AppStateStatus.loading));

    final result = await addressUsecases.getAddress(
     // userId: event.userId
      );

    result.fold(
        (l) => emit(state.copyWith(status: AppStateStatus.failure)),
        (r) => emit(
            state.copyWith(status: AppStateStatus.success, addressEntity: r)));
  }

  void _onAddUserAddress(
      AddUserAddress event, Emitter<AddressState> emit) async {
    emit(state.copyWith(status: AppStateStatus.loading));

    final result =
        await addressUsecases.addAddress(addressEntity: event.addressEntity);

    result.fold(
        (l) => emit(state.copyWith(status: AppStateStatus.failure)),
        (r) => emit(state.copyWith(
            status: AppStateStatus.success,
            addressEntity: state.addressEntity)));
  }

  void _onUpdateUserAddress(
      UpdateUserAddress event, Emitter<AddressState> emit) async {
    emit(state.copyWith(status: AppStateStatus.loading));

    final result =
        await addressUsecases.updateAddress(addressEntity: event.addressEntity);

    result.fold(
        (l) => emit(state.copyWith(status: AppStateStatus.failure)),
        (r) => emit(state.copyWith(
            status: AppStateStatus.success,
            addressEntity: state.addressEntity)));
  }
}
