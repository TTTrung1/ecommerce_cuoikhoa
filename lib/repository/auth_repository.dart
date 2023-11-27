import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  Future<User?> signUp({required String email, required String password}) async {
    try {
      UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      return user.user;
    }
    on FirebaseAuthException catch(e){
      if(e.code == 'weak-password'){
        throw Exception('Weak password');
      }
      else if(e.code == 'email-already-in-use'){
        throw Exception('Email has already been used');
      }
    }
    catch (e) {
      throw Exception(e.toString());
    }
  }
  Future<User?> signIn({required String email, required String password}) async {
    try {
      UserCredential user = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return user.user;
    }
    on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }
    catch (e) {
      throw Exception(e.toString());
    }
  }
  void logOut() {
    _firebaseAuth.signOut();
  }
}
