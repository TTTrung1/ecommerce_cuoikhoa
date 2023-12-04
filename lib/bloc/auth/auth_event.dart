part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class AuthStartedEvent extends AuthEvent {}

class SignUpRequestedEvent extends AuthEvent {
  final String email;
  final String password;
  SignUpRequestedEvent({required this.email,required this.password});
}

class SignInRequestedEvent extends AuthEvent {
  final String email;
  final String password;
  SignInRequestedEvent({required this.email,required this.password});
}

class GoogleSignInEvent extends AuthEvent{}

class ForgotPasswordEvent extends AuthEvent{
  final String email;
  ForgotPasswordEvent(this.email);
}

class GuestLoginEvent extends AuthEvent{}

class LogOutRequestedEvent extends AuthEvent{}

