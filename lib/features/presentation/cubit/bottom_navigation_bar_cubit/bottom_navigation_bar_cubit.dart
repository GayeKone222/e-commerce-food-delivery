import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationBarCubit extends Cubit<int> {
  BottomNavigationBarCubit() : super(0);

  void changePage({required int index}) {
    emit(index);
  }
}
