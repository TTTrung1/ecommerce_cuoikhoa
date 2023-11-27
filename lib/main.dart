import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_cuoikhoa/bloc/auth/auth_bloc.dart';
import 'package:ecommerce_cuoikhoa/bloc/home/home_bloc.dart';
import 'package:ecommerce_cuoikhoa/constant/constant.dart';
import 'package:ecommerce_cuoikhoa/firebase_options.dart';
import 'package:ecommerce_cuoikhoa/repository/auth_repository.dart';
import 'package:ecommerce_cuoikhoa/screen/auth/signin_screen.dart';
import 'package:ecommerce_cuoikhoa/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'bloc/search_bloc/search_bloc.dart';
import 'bloc/theme/theme_bloc.dart';
import 'localization/localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      fallbackLocale: L10n.all[0],
      supportedLocales: L10n.all,
      path: 'assets/l10n',
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => SearchBloc(),
            ),
            BlocProvider(
                create: (context) => ThemeBloc()..add(InitialThemeSetEvent())),
            BlocProvider(create: (context) => HomeBloc()..add(HomeStarted())),
            BlocProvider(
                create: (context) => AuthBloc(
                    authRepository:
                        RepositoryProvider.of<AuthRepository>(context))
                  ..add(AuthStartedEvent()))
          ],
          child: BlocBuilder<ThemeBloc, ThemeMode>(
            builder: (context, theme) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Flutter E-commerce',
                theme: lightTheme,
                darkTheme: darkTheme,
                themeMode: theme,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                home: BlocConsumer<AuthBloc, AuthState>(
                  listenWhen: (previous, current) => current is AuthError,
                  listener: (context, state) => showDialog(
                      context: context,
                      builder: (context) => const AlertDialog(
                        content: SizedBox(
                          height: 100,
                          width: 100,
                          child: Center(
                                child:
                                    Text('There\'s something wrong with the input'),
                              ),
                        ),
                      )),
                  builder: (context, state) {
                    if (state is AuthenticatedState) {
                      return const MyHomePage();
                    } else if (state is UnauthenticatedState) {
                      return const SignInScreen();
                    } else if (state is AuthError) {
                      return const SignInScreen();
                    }
                    return Container();
                  },
                ),
              );
            },
          )),
    );
  }
}
