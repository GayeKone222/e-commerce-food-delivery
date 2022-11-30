import 'package:e_commerce/features/domain/usecases/address_usecases/address_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressCubit extends Cubit<Placemark> {
  final AddressUsecases addressUsecases;
  AddressCubit({required this.addressUsecases}) : super(Placemark());

  void getAddressFromGeocode({required LatLng latLng}) async {
    final result = await addressUsecases.getAddressFromGeocode(latLng: latLng);

    result.fold(
        (failure) => emit(state), (address) => emit(Placemark(name: address)));
  }
}
