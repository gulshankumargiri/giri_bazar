import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/auth_logic_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  Map<String, dynamic>? _userData; // 🧠 Store user data

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<CheckLoginStatus>(_onCheckLoginStatus);
    on<LogOutRequested>(_onLogoutRequested);
  }

  void _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _authRepository.login(event.username, event.password);
      _userData = user;
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure( failure: e.toString(),));
    }
  }

  void _onCheckLoginStatus(CheckLoginStatus event, Emitter<AuthState> emit) async {
    final isLoggedIn = await _authRepository.isLoggedIn();
    if (isLoggedIn && _userData != null) {
      emit(AuthSuccess(_userData!));
    } else {
      emit(AuthInitial());
    }
  }

  void _onLogoutRequested(LogOutRequested event, Emitter<AuthState> emit) async {
    await _authRepository.logOut();
    _userData = null;
    emit(AuthInitial());
  }

  Map<String, dynamic>? get userData => _userData;
}
