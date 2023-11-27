import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/auth_bloc.dart';
import 'signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

import '../../model/user.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();
  User user = User(name: '', password: '');

  // void submitForm(BuildContext context) {
  //   final validate = Form.of(context).validate();
  //   if (!validate) {
  //     return;
  //   }
  //   Form.of(context).save();
  //   Navigator.pushReplacement(
  //       context, MaterialPageRoute(builder: (ctx) => const SignInScreen()));
  // }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameTEC.dispose();
    passwordTEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Stack(
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
            SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 20.0),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 94.0),
                        transform: Matrix4.rotationZ(-8 * pi / 180)
                          ..translate(-10.0),
                        // ..translate(-10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.deepOrange.shade900,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 8,
                              color: Colors.black26,
                              offset: Offset(0, 2),
                            )
                          ],
                        ),
                        child: const Text(
                          'E-commerce',
                          style: TextStyle(
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      flex: MediaQuery.of(context).size.width > 600 ? 2 : 1,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Form(
                                    key: _formKey,
                                    child: Builder(
                                        builder: (context) => Column(
                                              children: [
                                                TextFormField(
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                  decoration:
                                                      const InputDecoration(
                                                          labelText: 'Email'),
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  controller: nameTEC,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Field must be filled!';
                                                    }
                                                    if(!EmailValidator.validate(value)){
                                                      return 'Not a valid email';
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: (value) {
                                                    user.name = value!;
                                                  },
                                                ),
                                                TextFormField(
                                                  style: const TextStyle(
                                                      color: Colors.black),
                                                  obscureText: true,
                                                  decoration:
                                                      const InputDecoration(
                                                          labelText:
                                                              'Password'),
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  controller: passwordTEC,
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Field must be filled!';
                                                    } else if (value.length <
                                                        8) {
                                                      return 'Password must have at least 8 characters';
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: (value) {
                                                    user.password = value!;
                                                  },
                                                ),
                                                TextFormField(
                                                  style: const TextStyle(color: Colors.black),
                                                  obscureText: true,
                                                  decoration:
                                                      const InputDecoration(labelText: 'Confirm password'),
                                                  validator: (value) {
                                                    if (value!.isEmpty) {
                                                      return 'Field must be filled!';
                                                    } else if (value !=
                                                        passwordTEC.text) {
                                                      return 'Password do not match!';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
                                                BlocConsumer<AuthBloc,
                                                    AuthState>(
                                                  listener: (context, state) {
                                                    Navigator.pushReplacement(
                                                        context, MaterialPageRoute(builder: (ctx) => const SignInScreen()));
                                                  },
                                                  listenWhen: (previous, current) => current is AuthSuccess,
                                                  builder: (context, state) {
                                                    if(state is AuthLoadingState){
                                                      return const Center(child: CircularProgressIndicator(),);
                                                    }
                                                    return ElevatedButton(
                                                      onPressed: () {
                                                        final validate = Form.of(context).validate();
                                                        if (!validate) {
                                                          return;
                                                        }
                                                        Form.of(context).save();
                                                        context.read<AuthBloc>().add(SignUpRequestedEvent(email: nameTEC.text, password: passwordTEC.text));
                                                      },
                                                      style: ButtonStyle(
                                                        shape: MaterialStatePropertyAll(
                                                            RoundedRectangleBorder(
                                                                borderRadius: BorderRadius.circular(30))),
                                                        padding:
                                                            const MaterialStatePropertyAll(
                                                                EdgeInsets.symmetric(horizontal: 30, vertical: 8)),
                                                        backgroundColor:
                                                            MaterialStatePropertyAll(
                                                                Theme.of(
                                                                        context)
                                                                    .colorScheme
                                                                    .primary),
                                                      ),
                                                      child: const Text(
                                                        'Sign up',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    );
                                                  },
                                                )
                                              ],
                                            ))),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Already have an account ? Try',
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall
                                        ?.copyWith(color: Colors.black),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (ctx) =>
                                                  const SignInScreen()));
                                    },
                                    child: Text(
                                      'sign in',
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall
                                          ?.copyWith(color: Colors.red),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
        // SafeArea(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Text(
        //         'Flutter E-commerce',
        //         style: Theme.of(context)
        //             .textTheme
        //             .displayLarge
        //             ?.copyWith(color: Colors.white),
        //       ),
        //       Expanded(
        //         child: ClipRRect(
        //           borderRadius: const BorderRadius.only(
        //               topLeft: Radius.circular(15),
        //               topRight: Radius.circular(15)),
        //           child: Container(
        //             decoration: const BoxDecoration(color: Colors.white),
        //             child: SingleChildScrollView(
        //               child: Column(
        //                 children: [
        //                   Padding(
        //                     padding: const EdgeInsets.all(8.0),
        //                     child: Row(
        //                       crossAxisAlignment: CrossAxisAlignment.center,
        //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                       children: [
        //                         Text(
        //                           'Let\'s get started!',
        //                           style: Theme.of(context)
        //                               .textTheme
        //                               .displayMedium
        //                               ?.copyWith(color: Colors.red),
        //                         ),
        //                         Image.asset(
        //                           'assets/Plink.png',
        //                           width: MediaQuery.of(context).size.width * 0.45,
        //                           height: 150,
        //                         )
        //                       ],
        //                     ),
        //                   ),
        //                   Padding(
        //                     padding: const EdgeInsets.all(10.0),
        //                     child: Form(
        //                         key: _formKey,
        //                         child: Builder(
        //                             builder: (context) => Column(
        //                                   children: [
        //                                     TextFormField(
        //                                       style: const TextStyle(
        //                                           color: Colors.black),
        //                                       decoration: const InputDecoration(
        //                                           labelText: 'Account name'),
        //                                       textInputAction:
        //                                           TextInputAction.next,
        //                                       controller: nameTEC,
        //                                       validator: (value) {
        //                                         if (value!.isEmpty) {
        //                                           return 'Field must be filled!';
        //                                         }
        //                                         return null;
        //                                       },
        //                                       onSaved: (value) {
        //                                         user.name = value!;
        //                                       },
        //                                     ),
        //                                     TextFormField(
        //                                       style: const TextStyle(
        //                                           color: Colors.black),
        //                                       obscureText: true,
        //                                       decoration: const InputDecoration(
        //                                           labelText: 'Password'),
        //                                       textInputAction:
        //                                           TextInputAction.next,
        //                                       controller: passwordTEC,
        //                                       validator: (value) {
        //                                         if (value!.isEmpty) {
        //                                           return 'Field must be filled!';
        //                                         } else if (value.length < 8) {
        //                                           return 'Password must have at least 8 characters';
        //                                         }
        //                                         return null;
        //                                       },
        //                                       onSaved: (value) {
        //                                         user.password = value!;
        //                                       },
        //                                     ),
        //                                     TextFormField(
        //                                       style: const TextStyle(
        //                                           color: Colors.black),
        //                                       obscureText: true,
        //                                       decoration: const InputDecoration(
        //                                           labelText: 'Confirm password'),
        //                                       validator: (value) {
        //                                         if (value!.isEmpty) {
        //                                           return 'Field must be filled!';
        //                                         } else if (value !=
        //                                             passwordTEC.text) {
        //                                           return 'Password do not match!';
        //                                         }
        //                                         return null;
        //                                       },
        //                                     ),
        //                                     SizedBox(
        //                                       height: MediaQuery.of(context)
        //                                               .size
        //                                               .height *
        //                                           0.02,
        //                                     ),
        //                                     ElevatedButton(
        //                                       onPressed: () =>
        //                                           submitForm(context),
        //                                       style: ButtonStyle(
        //                                         shape: MaterialStatePropertyAll(
        //                                             RoundedRectangleBorder(
        //                                                 borderRadius:
        //                                                     BorderRadius.circular(
        //                                                         30))),
        //                                         padding:
        //                                             const MaterialStatePropertyAll(
        //                                                 EdgeInsets.symmetric(
        //                                                     horizontal: 30,
        //                                                     vertical: 8)),
        //                                         backgroundColor:
        //                                             MaterialStatePropertyAll(
        //                                                 Theme.of(context)
        //                                                     .colorScheme
        //                                                     .primary),
        //                                       ),
        //                                       child: const Text(
        //                                         'Sign up',
        //                                         style: TextStyle(
        //                                             color: Colors.white),
        //                                       ),
        //                                     )
        //                                   ],
        //                                 ))),
        //                   ),
        //                   Row(
        //                     mainAxisAlignment: MainAxisAlignment.center,
        //                     children: [
        //                       Text(
        //                         'Already have an account ? Try',
        //                         style: Theme.of(context)
        //                             .textTheme
        //                             .displaySmall
        //                             ?.copyWith(color: Colors.black),
        //                       ),
        //                       TextButton(
        //                         onPressed: () {
        //                           Navigator.pushReplacement(
        //                               context,
        //                               MaterialPageRoute(
        //                                   builder: (ctx) =>
        //                                       const SignInScreen()));
        //                         },
        //                         child: Text(
        //                           'sign in',
        //                           style: Theme.of(context)
        //                               .textTheme
        //                               .displaySmall
        //                               ?.copyWith(color: Colors.red),
        //                         ),
        //                       )
        //                     ],
        //                   ),
        //                   // Text.rich(
        //                   //   textAlign : TextAlign.center,
        //                   //     TextSpan(
        //                   //     children: [
        //                   //   TextSpan(
        //                   //     text: 'Already have an account ? Try ',
        //                   //     style: Theme.of(context)
        //                   //         .textTheme
        //                   //         .displaySmall
        //                   //         ?.copyWith(color: Colors.black),
        //                   //   ),
        //                   //   WidgetSpan(
        //                   //       child: TextButton(
        //                   //          onPressed: () { Navigator.pushReplacement(
        //                   //              context,
        //                   //              MaterialPageRoute(
        //                   //                  builder: (ctx) =>
        //                   //                  const SignInScreen())); }, child: Text('sign in',
        //                   //         style: Theme.of(context)
        //                   //             .textTheme
        //                   //             .displaySmall
        //                   //             ?.copyWith(color: Colors.black),),
        //                   //       ))
        //                   // ]))
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        );
  }
}
