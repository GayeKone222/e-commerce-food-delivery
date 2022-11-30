import 'package:flutter_bloc/flutter_bloc.dart';

class LocationTypeCubit extends Cubit<int> {
  LocationTypeCubit() : super(0);

  void changeLocationType({required int index}) {
    emit(index);
  }
}
