import 'package:e_commerce/features/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel(
      {super.name,
      super.email,
      required super.phone,
       super.password,
      super.adress,
      super.orderCount});

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      name: map['f_name'] as String,
      adress: map['adress'] as String?,
      email: map['email'] as String,
      password: map['password'] as String?,
      phone: map['phone'] as String,
      orderCount: map['order_count'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (name != null) "f_name": name,
      if (email != null) "email": email,
      "password": password,
      "phone": phone,
      if (adress != null) "adress": adress,
      if (orderCount != null) "order_count": orderCount,
    };
  }

  factory UserModel.fromEntity({UserEntity? userEntity}) {
    return UserModel(
        name: userEntity!.name,
        email: userEntity.email,
        adress: userEntity.adress,
        password: userEntity.password,
        phone: userEntity.phone,
        orderCount: userEntity.orderCount);
  }
}
