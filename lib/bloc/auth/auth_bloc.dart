import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:ecommerce_cuoikhoa/repository/auth_repository.dart';

import 'auth_helper.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(UnauthenticatedState()) {
    on<AuthStartedEvent>(_onInit);
    on<SignUpRequestedEvent>(_onSignUp);
    on<SignInRequestedEvent>(_onSignIn);
    on<LogOutRequestedEvent>(_onLogOut);
    on<GoogleSignInEvent>(_onGoogleSignIn);
    on<ForgotPasswordEvent>(_onForgotPassword);
  }

  void _onInit(AuthStartedEvent event, Emitter<AuthState> emit) async {
    print('auth');
    final bool auth = await isAuth();
    if (!auth) {
      emit(UnauthenticatedState());
    } else {
      emit(SignInSuccessState());
    }
  }

  Future<void> _onSignUp(SignUpRequestedEvent event,
      Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      User? user = await authRepository.signUp(
          email: event.email, password: event.password);
      if (user != null) {
        emit(SignUpSuccessState());
      }
    } catch (e) {
      emit(SignUpFailState(message: e.toString()));
    }
  }

  Future<void> _onSignIn(SignInRequestedEvent event,
      Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      User? user = await authRepository.signIn(
          email: event.email, password: event.password);
      if (user != null) {
        emit(SignInSuccessState());
        setAuth(true);
      }
    } catch (e) {
      emit(SignInFailState(message: e.toString()));
    }
  }

  Future<void> _onGoogleSignIn(GoogleSignInEvent event,
      Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      UserCredential user = await authRepository.signInWithGoogle();
      if (user.user != null) {
        emit(SignInSuccessState());
        setAuth(true);
      }
    } catch (e) {
      emit(SignInFailState(message: e.toString()));
    }
  }

  void _onLogOut(LogOutRequestedEvent event, Emitter<AuthState> emit) async {
    authRepository.logOut();
    setAuth(false);
    emit(LogOutSuccessState());
  }

  Future<void> _onForgotPassword(ForgotPasswordEvent event,
      Emitter<AuthState> emit) async {
    final bool validEmail = EmailValidator.validate(event.email);
    if(validEmail){
      try {
        await authRepository.resetPassword(email: event.email);
        emit(ForgotPasswordSuccessState('Success!'));
      }
      catch (e){
        emit(ForgotPasswordFailState(e.toString()));
      }
    }
    else{
      emit(ForgotPasswordFailState('Invalid email!'));
    }
  }
}
