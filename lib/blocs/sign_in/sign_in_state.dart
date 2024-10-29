import 'package:equatable/equatable.dart';

abstract class SignInState extends Equatable {
  @override
  List<Object> get props => [];
}

class SignInInitial extends SignInState {}

class SignInLoading extends SignInState {}

class SignInSuccess extends SignInState {
  final String message;

  SignInSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class SignInFailure extends SignInState {
  final String error;

  SignInFailure(this.error);

  @override
  List<Object> get props => [error];
}
