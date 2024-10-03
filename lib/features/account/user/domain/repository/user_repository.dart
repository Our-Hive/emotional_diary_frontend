import 'package:emotional_app/features/account/user/domain/entities/user.dart';

abstract class UserRepository {
  Future<User> getUser();
  Future<bool> updateUser({
    String? userName,
    String? phone,
    DateTime? birthDate,
  });
  Future<bool> disableUser(String password);
}
