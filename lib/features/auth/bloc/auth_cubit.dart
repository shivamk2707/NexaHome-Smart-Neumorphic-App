import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/services/preferences_service.dart';

class AuthState {
  final bool isAuthenticated;
  final String? userName;
  final String? userEmail;

  const AuthState({
    this.isAuthenticated = false,
    this.userName,
    this.userEmail,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    String? userName,
    String? userEmail,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      userName: userName ?? this.userName,
      userEmail: userEmail ?? this.userEmail,
    );
  }
}

class AuthCubit extends Cubit<AuthState> {
  final PreferencesService _prefs;

  AuthCubit(this._prefs) : super(const AuthState()) {
    _init();
  }

  void _init() async {
    final isAuth = await _prefs.isAuthenticated();
    if (isAuth) {
      emit(state.copyWith(
        isAuthenticated: true,
        userName: 'Alex Johnson', // Mock data
        userEmail: 'alex.johnson@example.com',
      ));
    }
  }

  Future<void> login(String email, String password) async {
    // Mock login delay
    await Future.delayed(const Duration(seconds: 1));
    await _prefs.setAuthenticated(true);
    emit(state.copyWith(
      isAuthenticated: true,
      userName: 'Alex Johnson',
      userEmail: email,
    ));
  }

  Future<void> logout() async {
    await _prefs.setAuthenticated(false);
    emit(const AuthState());
  }
}
