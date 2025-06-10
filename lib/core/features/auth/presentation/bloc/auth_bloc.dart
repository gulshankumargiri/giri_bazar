import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared_storage_services/storage_services.dart';
import '../../domain/auth_logic_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(this._authRepository) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<CheckLoginStatus>(_onCheckingLogginStatus);
    on<LogOutRequested>(_onLogOutRequested);
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
     final userData= await _authRepository.login(event.username, event.password);
      emit(AuthSuccess(userData));
    } catch (e) {
      emit(AuthFailure(failure: e.toString()));
    }
  }

  Future<void> _onCheckingLogginStatus(CheckLoginStatus event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final token = await StorageService().getToken();
    if (token != null && token.isNotEmpty) {
      emit(AuthSuccess({}));
    } else {
      emit(AuthInitial());
    }
  }

  Future<void> _onLogOutRequested(LogOutRequested event, Emitter<AuthState> emit) async {
    await _authRepository.logOut();
    emit(AuthInitial());
  }
}
