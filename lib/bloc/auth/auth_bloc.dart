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
  }

  void _onInit(AuthStartedEvent event, Emitter<AuthState> emit)async{
    final bool auth = await isAuth();
    if(!auth){
      emit(UnauthenticatedState());
    }
    else{
      emit(AuthenticatedState());
    }
  }

  Future<void> _onSignUp(
      SignUpRequestedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      User? user = await authRepository.signUp(email: event.email, password: event.password);
      if(user != null)
      {
        emit(AuthSuccess());
      }
      else{
        emit(AuthError());
      }
    } catch (e) {
      emit(AuthError());
    }
  }

  Future<void> _onSignIn(
      SignInRequestedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    try {
      User? user = await authRepository.signIn(email: event.email, password: event.password);
      if(user != null)
      {
        emit(AuthenticatedState());
        setAuth(true);
      }
      else{
        emit(AuthError());
      }
    } catch (e) {
      emit(AuthError());
    }
  }
  void _onLogOut(LogOutRequestedEvent event,Emitter<AuthState> emit) async{
    emit(AuthLoadingState());
    authRepository.logOut();
    setAuth(false);
    emit(UnauthenticatedState());
  }
}
