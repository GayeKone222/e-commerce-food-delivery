part of 'registration_bloc.dart';

 

class RegistrationState extends Equatable {
  final AppStateStatus status;
  

  const RegistrationState(
      {this.status = AppStateStatus.initial });

  RegistrationState copyWith(
      {AppStateStatus? status}) {
    return RegistrationState(
        status: status ?? this.status );
  }

  @override
  List<Object?> get props => [status ];
}
