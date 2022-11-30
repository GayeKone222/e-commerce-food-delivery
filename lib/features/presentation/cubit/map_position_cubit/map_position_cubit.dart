import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPositionCubit extends Cubit<LatLng?> {
  MapPositionCubit() : super(null);

  void newPosition({required LatLng latLng}) {
    emit(latLng);
  }
}
