import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:e_commerce/core/utils/api_constants.dart';
import 'package:e_commerce/core/utils/enums.dart';
import 'package:e_commerce/features/data/models/auth_token_model.dart';
import 'package:e_commerce/features/domain/entities/user_entity.dart';
import 'package:e_commerce/features/domain/usecases/auth_usecases/auth_usecases.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'registtration_event.dart';
part 'registration_state.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AuthUsecases authUsecases;
  final SharedPreferences sharedPreferences;
  RegistrationBloc(
      {required this.authUsecases, required this.sharedPreferences})
      : super(const RegistrationState()) {
    on<SignUp>(_onSignUp);
  }

  void _onSignUp(SignUp event, Emitter<RegistrationState> emit) async {
    emit(state.copyWith(status: AppStateStatus.loading));

    final result = await authUsecases.signUp(user: event.user);

    result.fold((l) => emit(state.copyWith(status: AppStateStatus.failure)),
        (r) {
      emit(state.copyWith(status: AppStateStatus.success));
    });
  }
}
