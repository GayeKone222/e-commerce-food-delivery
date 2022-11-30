import 'package:equatable/equatable.dart';

class AuthTokenEntity extends Equatable {
  final String token;
  final int? isPhoneVerified;
  final String? phoneVerifyEndUrl;

  const AuthTokenEntity({
    required this.token,
    this.isPhoneVerified,
    this.phoneVerifyEndUrl,
  });

  AuthTokenEntity copyWith({
    int? isPhoneVerified,
    String? token,
    String? phoneVerifyEndUrl,
  }) {
    return AuthTokenEntity(
      token: token ?? this.token,
      isPhoneVerified: isPhoneVerified ?? this.isPhoneVerified,
      phoneVerifyEndUrl: phoneVerifyEndUrl ?? this.phoneVerifyEndUrl,
    );
  }

  @override
  List<Object?> get props => [
        token,
        isPhoneVerified,
        phoneVerifyEndUrl,
      ];
}
