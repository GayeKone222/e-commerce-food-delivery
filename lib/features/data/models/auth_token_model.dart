import 'package:e_commerce/features/domain/entities/auth_token_entity.dart';

class AuthTokenModel extends AuthTokenEntity {
  const AuthTokenModel(
      {required super.token, super.isPhoneVerified, super.phoneVerifyEndUrl});

  factory AuthTokenModel.fromJson(Map<String, dynamic> map) {
    return AuthTokenModel(
      token: map['token'] as String,
      isPhoneVerified: map['is_phone_verified'] as int?,
      phoneVerifyEndUrl: map['phone_verify_end_url'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "token": token,
      "is_phone_verified": isPhoneVerified,
      "phone_verify_end_url": phoneVerifyEndUrl,
    };
  }

  factory AuthTokenModel.fromEntity({AuthTokenEntity? authTokenEntity}) {
    return AuthTokenModel(
      token: authTokenEntity!.token,
      isPhoneVerified: authTokenEntity.isPhoneVerified,
      phoneVerifyEndUrl: authTokenEntity.phoneVerifyEndUrl,
    );
  }
}
