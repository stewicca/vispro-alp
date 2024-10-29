import 'package:equatable/equatable.dart';

abstract class SignInEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInSubmitted extends SignInEvent {
  final String username;
  final String password;

  SignInSubmitted(this.username, this.password);

  @override
  List<Object> get props => [username, password];
}
