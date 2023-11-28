import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_cuoikhoa/screen/auth/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_bloc.dart';
import '../bloc/theme/theme_bloc.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final auth = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      height: MediaQuery.of(context).size.height * 0.9,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: BlocBuilder<ThemeBloc, ThemeMode>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset('assets/Plink.png', width: 200),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is SignInSuccessState) {
                    return Center(
                      child: Text(auth!.email!,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 16)),
                    );
                  }
                  return Center(
                    child: Text('Trung',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16)),
                  );
                },
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('darkMode',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 16))
                      .tr(),
                  Switch(
                    value: state == ThemeMode.dark,
                    onChanged: (value) {
                      BlocProvider.of<ThemeBloc>(context)
                          .add(ThemeSwitchEvent());
                    },
                  )
                ],
              ),
              const SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('language',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 16))
                    .tr(),
                DropdownMenu(
                  textStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 16),
                  initialSelection:
                      Localizations.localeOf(context).languageCode,
                  width: 150,
                  dropdownMenuEntries: const [
                    DropdownMenuEntry(value: 'en', label: 'English'),
                    DropdownMenuEntry(value: 'vi', label: 'Tiếng Việt')
                  ],
                  onSelected: (value) {
                    if (value!.isNotEmpty) {
                      setState(() {
                        context.setLocale(Locale(value));
                      });
                    }
                  },
                )
              ]),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    'changePass',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16),
                  ).tr(),
                ),
                onTap: () {},
              ),
              const Spacer(),
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => SignInScreen()),
                      (route) => false);
                },
                listenWhen: (previous, current) => current is LogOutSuccessState,
                builder: (context, state) {
                  return InkWell(
                    onTap: () {
                      context.read<AuthBloc>().add(LogOutRequestedEvent());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.logout,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          Text(
                            'logOut',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.error,
                                fontSize: 20),
                          ).tr(),
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          );
        },
      ),
    ));
  }
}
