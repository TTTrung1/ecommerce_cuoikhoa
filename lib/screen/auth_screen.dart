import 'package:ecommerce_cuoikhoa/screen/auth/signin_screen.dart';
import 'package:ecommerce_cuoikhoa/screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot)
    {
      if(snapshot.hasData && snapshot.data != null){
        return const MyHomePage();
      }
      return const SignInScreen();
    });
  }
}
