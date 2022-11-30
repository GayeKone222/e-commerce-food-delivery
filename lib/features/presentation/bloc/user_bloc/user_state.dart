part of 'user_bloc.dart';

class UserState extends Equatable {
  final AppStateStatus status;
  final UserEntity? user;

  const UserState({this.status = AppStateStatus.initial, this.user});

  UserState copyWith({AppStateStatus? status, UserEntity? user}) {
    return UserState(status: status ?? this.status, user: user ?? this.user);
  }

  @override
  List<Object?> get props => [status, user];
}
