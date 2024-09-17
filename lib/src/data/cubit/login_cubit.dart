import 'package:chat_service/src/data/repository/login_repository.dart';
import 'package:chat_service/src/data/state/login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Define LoginCubit
class LoginCubit extends Cubit<LoginState> {
  final LoginRepository _loginRepository;

  LoginCubit(this._loginRepository) : super(const LoginState());

  Future<void> signIn({required String email, required String password}) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      User? user = await _loginRepository.signIn(
        email: email,
        password: password,
      );
      emit(state.copyWith(isLoading: false, user: user));
    } on FirebaseAuthException catch (e) {
      emit(state.copyWith(isLoading: false, error: e.message));
    }
  }

  Future<void> signOut() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      await _loginRepository.signOut();
      emit(const LoginState());
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void checkAuthStatus() {
    final currentUser = _loginRepository.getCurrentUser();
    emit(state.copyWith(user: currentUser));
  }
}
