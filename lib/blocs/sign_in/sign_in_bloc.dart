import 'package:alp/models/auth_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'sign_in_event.dart';
import 'sign_in_state.dart';
import '../../data/repositories/auth_repository.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthRepository authRepository;

  SignInBloc(this.authRepository) : super(SignInInitial()) {
    on<SignInSubmitted>(_onSignInSubmitted);
  }

  Future<void> _onSignInSubmitted(
      SignInSubmitted event, Emitter<SignInState> emit) async {
    emit(SignInLoading());
    try {
      final data = await authRepository.signIn(event.username, event.password);
      if (data['status'] == 200) {
        emit(SignInSuccess(data['message']));
        AuthModel authModel = data['data'];
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("role", authModel.role);
        await prefs.setString("token", authModel.token);
        await prefs.setString("refreshToken", authModel.refreshToken);
      } else {
        emit(SignInFailure(data['message']));
      }
    } catch (error) {
      emit(SignInFailure('Failed to login. Please try again.'));
    }
  }
}
