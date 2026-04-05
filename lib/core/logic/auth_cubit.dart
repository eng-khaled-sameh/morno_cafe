import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:caffe_app/core/services/auth_service.dart';
import 'auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService;

  AuthCubit(this._authService) : super(AuthInitial());

  void checkAuthState() {
    emit(AuthLoading());
    final user = _authService.currentUser;
    if (user != null) {
      emit(AuthAuthenticated(user));
    } else {
      emit(AuthUnauthenticated());
    }
    
    // Listen to changes
    _authService.authStateChanges.listen((User? user) {
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    });
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());
    try {
      final userCredential = await _authService.signInWithGoogle();
      if (userCredential != null && userCredential.user != null) {
        emit(AuthAuthenticated(userCredential.user!));
      } else {
        emit(AuthError('Google Sign-In was cancelled or failed.'));
      }
    } catch (e) {
      emit(AuthError('An error occurred during sign-in: ${e.toString()}'));
    }
  }

  Future<void> signOut() async {
    try {
      await _authService.signOut();
    } catch (_) {
      // Firebase/Google sign-out can throw on some devices; still leave the app logged out locally.
    }
    emit(AuthUnauthenticated());
  }
}
