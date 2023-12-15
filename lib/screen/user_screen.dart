import 'package:easy_localization/easy_localization.dart';
import 'package:ecommerce_cuoikhoa/screen/auth/signin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/auth/auth_bloc.dart';
import '../bloc/theme/theme_bloc.dart';
import 'forgot_password_screen.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final auth = FirebaseAuth.instance.currentUser;
  final guest = FirebaseAuth.instance.currentUser?.isAnonymous;

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
              Divider(
                thickness: 0,
                color: Theme.of(context).colorScheme.background,
              ),
              Center(
                child: Text(guest == true ? 'Guest' : auth!.email!,
                    style: Theme.of(context).textTheme.displayMedium),
              ),
              Divider(
                thickness: 0,
                color: Theme.of(context).colorScheme.background,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('darkMode',
                          style: Theme.of(context).textTheme.headlineMedium)
                      .tr(),
                  Switch(
                    activeTrackColor: Theme.of(context).colorScheme.onBackground,
                    value: state == ThemeMode.dark,
                    onChanged: (value) {
                      BlocProvider.of<ThemeBloc>(context)
                          .add(ThemeSwitchEvent());
                    },
                  )
                ],
              ),
              Divider(
                thickness: 0,
                color: Theme.of(context).colorScheme.background,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('language',
                        style: Theme.of(context).textTheme.headlineMedium)
                    .tr(),
                DropdownMenu(
                  textStyle: Theme.of(context).textTheme.headlineMedium,
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
              Divider(
                thickness: 0,
                color: Theme.of(context).colorScheme.background,
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'changePass',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ).tr(),
                      const CupertinoListTileChevron()
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ForgotPassword()));
                },
              ),
              const Spacer(),
              guest == true
                  ? InkWell(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInScreen()),
                            (route) => false);
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
                              'signIn',
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.error,
                                  fontSize: 20),
                            ).tr(),
                          ],
                        ),
                      ),
                    )
                  : BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInScreen()),
                            (route) => false);
                      },
                      listenWhen: (previous, current) =>
                          current is LogOutSuccessState,
                      builder: (context, state) {
                        return InkWell(
                          onTap: () {
                            context
                                .read<AuthBloc>()
                                .add(LogOutRequestedEvent());
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
                                      color:
                                          Theme.of(context).colorScheme.error,
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
