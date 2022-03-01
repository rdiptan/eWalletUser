// ignore_for_file: file_names

import 'dart:io';
import 'package:e_wallet/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:e_wallet/page/home.dart';
import 'package:e_wallet/page/profile.dart';
import 'package:e_wallet/page/transactionPage.dart';
import 'package:provider/provider.dart';
import 'package:shake/shake.dart';
import 'package:all_sensors2/all_sensors2.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTab = 0;
  final List<Widget> screens = [
    const Home(),
    const TransactionPage(),
    const Profile(),
  ];

  bool _proximityValues = false;
  final List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];

  @override
  void dispose() {
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    ShakeDetector detector = ShakeDetector.autoStart(onPhoneShake: () {
      Provider.of<ThemeProvider>(context, listen: false).swapTheme();
    });
    _streamSubscriptions.add(proximityEvents!.listen((ProximityEvent event) {
      _proximityValues = event.getValue();
      if (_proximityValues == true) {
        exit(0);
        // print('near');
      }
    }));
  }

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const Home();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      bottomNavigationBar: BottomAppBar(
        child: SizedBox(
          height: 64,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MaterialButton(
                splashColor: Theme.of(context).primaryColor,
                height: 60,
                // minWidth: 50,
                onPressed: () {
                  setState(() {
                    currentScreen = const Home();
                    currentTab = 0;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.home,
                        color: currentTab == 0
                            ? Theme.of(context).primaryColor
                            : Colors.grey),
                    Text(
                      currentTab == 0 ? 'Home' : '',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    )
                  ],
                ),
              ),
              MaterialButton(
                splashColor: Theme.of(context).primaryColor,
                height: 60,
                // minWidth: 50,
                onPressed: () {
                  setState(() {
                    currentScreen = const TransactionPage();
                    currentTab = 1;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add,
                        color: currentTab == 1
                            ? Theme.of(context).primaryColor
                            : Colors.grey),
                    Text(
                      currentTab == 1 ? 'Transaction' : '',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    )
                  ],
                ),
              ),
              MaterialButton(
                splashColor: Theme.of(context).primaryColor,
                height: 60,
                // minWidth: 50,
                onPressed: () {
                  setState(() {
                    currentScreen = const Profile();
                    currentTab = 2;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person,
                        color: currentTab == 2
                            ? Theme.of(context).primaryColor
                            : Colors.grey),
                    Text(
                      currentTab == 2 ? 'Profile' : '',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
