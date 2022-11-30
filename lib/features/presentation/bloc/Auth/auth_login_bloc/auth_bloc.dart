import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:e_commerce/core/utils/api_constants.dart';
import 'package:e_commerce/core/utils/enums.dart';
import 'package:e_commerce/features/data/models/auth_token_model.dart';
import 'package:e_commerce/features/domain/entities/user_entity.dart';
import 'package:e_commerce/features/domain/usecases/auth_usecases/auth_usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthUsecases authUsecases;
  final SharedPreferences sharedPreferences;
  AuthBloc({required this.authUsecases, required this.sharedPreferences})
      : super(const AuthState()) {
    on<SignIn>(_onSignIn);
    on<SignOut>(_onSignOut);
  }

  void _onSignIn(SignIn event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AppAuthStateStatus.authenticating));

    final result = await authUsecases.signIn(user: event.user);

    result.fold((l) => emit(state.copyWith(status: AppAuthStateStatus.error)),
        (r) {
      //store token locally

      String data =
          jsonEncode(AuthTokenModel.fromEntity(authTokenEntity: r).toJson());
      print("token : $data");

      sharedPreferences.setString(SharedPreferencesKeys.APP_TOKEN, data);

      print(
          "token exists : ${sharedPreferences.containsKey(SharedPreferencesKeys.APP_TOKEN)}");

      //emit state
      emit(state.copyWith(status: AppAuthStateStatus.authenticated));
    });
  }

  void _onSignOut(SignOut event, Emitter<AuthState> emit) async {
    // emit(state.copyWith(status: AppAuthStateStatus.authenticating));

    final result = await authUsecases.signOut();

    result.fold((l) => emit(state.copyWith(status: AppAuthStateStatus.error)),
        (r) {
      emit(state.copyWith(status: AppAuthStateStatus.unAuthenticated));
    });
  }
}
