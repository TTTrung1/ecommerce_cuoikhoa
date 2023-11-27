part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoadingState extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthError extends AuthState {}

class UnauthenticatedState extends AuthState {}

class AuthenticatedState extends AuthState {}
