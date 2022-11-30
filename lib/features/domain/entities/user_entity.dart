import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? name;
  final String? email;

  final String? phone;
  final String? password;
  final String? adress;
  final int? orderCount;

  const UserEntity({
    this.name,
    this.email,
      this.phone,
      this.password,
    this.adress,
    this.orderCount
  });

  UserEntity copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    String? password,
    String? adress,
    int? orderCount
  }) {
    return UserEntity(
        name: name ?? this.name,
        email: email ?? this.email,
        adress: adress ?? this.adress,
        password: password ?? this.password,
        phone: phone ?? this.phone, orderCount : orderCount??this.orderCount);
  }

  @override
  List<Object?> get props => [
        name,
        email,
        adress,
        password,
        phone,
        orderCount
      ];
}
