
import '../../domain/entities/user.dart';

class UserModel {
  final String userId;
  final String email;

  UserModel({
    required this.userId,
    required this.email,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] as String,
      email: map['email'] as String,
    );
  }

}

extension UserXModel on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      userId: userId,
      email: email,
    );
  }
}