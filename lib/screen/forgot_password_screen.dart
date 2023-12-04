import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_bloc.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailTEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if(state is ForgotPasswordSuccessState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message),duration: const Duration(seconds: 1),));
          }
          if(state is ForgotPasswordFailState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message),duration: const Duration(seconds: 1),));
          }
        },
        listenWhen: (previous, current) => current is AuthActionState,
        builder: (context, state) {
          return Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color.fromRGBO(215, 117, 255, 1).withOpacity(0.5),
                      const Color.fromRGBO(255, 188, 117, 1).withOpacity(0.9),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: const [0, 1],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Enter your email to reset password',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0,vertical: 5),
                      child: TextField(
                        controller: emailTEC,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          hintStyle: TextStyle(fontSize: 17),
                          suffixIcon: Icon(CupertinoIcons.mail_solid),
                          contentPadding: EdgeInsets.all(20),
                        ),
                        onEditingComplete: () {
                          BlocProvider.of<AuthBloc>(context).add(ForgotPasswordEvent(emailTEC.text));
                        },
                      ),
                    ),
                    CupertinoButton(
                        child: const Text('Submit'), onPressed: () {
                          BlocProvider.of<AuthBloc>(context).add(ForgotPasswordEvent(emailTEC.text));
                    })
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
