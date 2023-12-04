part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthActionState extends AuthState {}

class AuthError extends AuthState {}

class SignUpSuccessState extends AuthActionState {}

class SignUpFailState extends AuthActionState {
  final String message;
  SignUpFailState({required this.message});
}

class UnauthenticatedState extends AuthState {}

class SignInFailState extends AuthActionState {
  final String message;
  SignInFailState({required this.message});
}

class SignInSuccessState extends AuthActionState {}

class ForgotPasswordSuccessState extends AuthActionState{
  final String message;
  ForgotPasswordSuccessState(this.message);
}

class ForgotPasswordFailState extends AuthActionState{
  final String message;
  ForgotPasswordFailState(this.message);
}

class LogOutSuccessState extends AuthActionState {}