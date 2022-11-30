import 'package:e_commerce/core/utils/enums.dart';
import 'package:e_commerce/features/domain/entities/user_entity.dart';
import 'package:e_commerce/features/domain/usecases/user_usecases/user_useecases.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserUsecases userUsecases;
  UserBloc({required this.userUsecases}) : super(const UserState()) {
    on<GetUserInfo>(_onGetUserInfo);
  }

  void _onGetUserInfo(GetUserInfo event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: AppStateStatus.loading));

    final result = await userUsecases.getUser();

    result.fold((l) => emit(state.copyWith(status: AppStateStatus.failure)),
        (r) => emit(state.copyWith(status: AppStateStatus.success, user: r)));
  }
}
