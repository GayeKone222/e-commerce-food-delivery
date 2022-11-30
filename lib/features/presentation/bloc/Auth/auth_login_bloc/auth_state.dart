part of 'auth_bloc.dart';

 

class AuthState extends Equatable {
  final AppAuthStateStatus status;
  

  const AuthState(
      {this.status = AppAuthStateStatus.initial });

  AuthState copyWith(
      {AppAuthStateStatus? status}) {
    return AuthState(
        status: status ?? this.status );
  }

  @override
  List<Object?> get props => [status ];
}
