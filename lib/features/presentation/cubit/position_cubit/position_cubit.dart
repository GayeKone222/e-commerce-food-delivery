import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PositionCubit extends Cubit<Position?> {
  PositionCubit() : super(null);

  void setNewPosition({required LatLng latLng}) async {
    emit(
      Position(
          latitude: latLng.latitude,
          longitude: latLng.longitude,
          timestamp: DateTime.now(),
          heading: 1,
          altitude: 1,
          speedAccuracy: 1,
          speed: 1,
          accuracy: 1),
    );
  }
}
