import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginRepository {
  Future<User?> signIn({required String email, required String password});
  Future<void> signOut();
  User? getCurrentUser();
}
