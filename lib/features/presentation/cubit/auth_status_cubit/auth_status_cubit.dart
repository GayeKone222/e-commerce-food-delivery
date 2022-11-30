import 'package:e_commerce/core/utils/api_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthStatusCubit extends Cubit<bool> {
  final SharedPreferences sharedPreferences;
  AuthStatusCubit({required this.sharedPreferences})
      : super(sharedPreferences.containsKey(SharedPreferencesKeys.APP_TOKEN));

  void isLoggedIn() {
    emit(sharedPreferences.containsKey(SharedPreferencesKeys.APP_TOKEN));
  }


 
}
