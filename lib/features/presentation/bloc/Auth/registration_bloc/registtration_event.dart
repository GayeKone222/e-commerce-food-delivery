part of 'registration_bloc.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();

  @override
  List<Object> get props => [];
}

 

class SignUp extends RegistrationEvent {
  final UserEntity user;

  const SignUp({required this.user});

  @override
  List<Object> get props => [user];
}
