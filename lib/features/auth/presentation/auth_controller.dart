import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopora/shared/models/user_model.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, UserModel?>((ref) {
  return AuthController();
});

class AuthController extends StateNotifier<UserModel?> {
  AuthController() : super(_initialUser);

  // Demo user for immediate showcase
  static final UserModel _initialUser = UserModel(
    uid: 'user_001',
    name: 'Rakib Akram',
    email: 'rakib@shopora.com',
    profileImage: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500',
    phone: '+8801700000000',
    role: 'admin', // Demo admin access
    createdAt: DateTime.now(),
  );

  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 800));
    state = UserModel(
      uid: 'user_001',
      name: email == 'admin@shopora.com' ? 'Admin User' : 'Rakib Akram',
      email: email,
      profileImage: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500',
      phone: '+8801700000000',
      role: email == 'admin@shopora.com' ? 'admin' : 'user',
      createdAt: DateTime.now(),
    );
    return true;
  }

  Future<bool> register(String name, String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 800));
    state = UserModel(
      uid: 'user_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      email: email,
      profileImage: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=500',
      phone: '+8801700000000',
      role: 'user',
      createdAt: DateTime.now(),
    );
    return true;
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 400));
    state = null;
  }

  Future<bool> forgotPassword(String email) async {
    await Future.delayed(const Duration(milliseconds: 600));
    return true;
  }

  void updateUser(UserModel updatedUser) {
    state = updatedUser;
  }
}
