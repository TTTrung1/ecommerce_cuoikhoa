import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';
import 'search_screen.dart';
import 'user_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int indexScreen = 0;
  List<Widget> listScreen = const [HomeScreen(), SearchScreen(), UserScreen()];

  changeScreen(int index) {
    setState(() {
      indexScreen = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: SingleChildScrollView(child: listScreen[indexScreen])),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    changeScreen(0);
                  },
                  icon: Icon(
                    CupertinoIcons.home,
                    color: indexScreen == 0
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.secondary,
                  )),
              IconButton(
                  onPressed: () {
                    changeScreen(1);
                  },
                  icon: Icon(CupertinoIcons.search,
                      color: indexScreen == 1
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.secondary)),
              IconButton(
                  onPressed: () {
                    changeScreen(2);
                  },
                  icon: Icon(CupertinoIcons.person_alt_circle,
                      color: indexScreen == 2
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.secondary)),
            ],
          )
        ],
      ),
    );
  }

// Widget navBar(BuildContext context) {
//   return BottomNavigationBar(
//       elevation: 0,
//       currentIndex: indexScreen,
//       onTap: changeScreen,
//       backgroundColor: Colors.white,
//       showSelectedLabels: false,
//       showUnselectedLabels: false,
//       type: BottomNavigationBarType.fixed,
//       items: const [
//         BottomNavigationBarItem(
//             icon: Icon(CupertinoIcons.house_fill), label: 'Home'),
//         BottomNavigationBarItem(
//             icon: Icon(CupertinoIcons.search), label: 'Search'),
//         BottomNavigationBarItem(
//             icon: Icon(CupertinoIcons.person_alt_circle), label: 'User'),
//       ],
//       selectedItemColor: Colors.black,
//       unselectedItemColor: Colors.grey);
// }
}
