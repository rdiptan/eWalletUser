// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:e_wallet/page/home.dart';
import 'package:e_wallet/page/profile.dart';
import 'package:e_wallet/page/transactionPage.dart';

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
                splashColor: Colors.greenAccent,
                height: 60,
                // minWidth: 50,
                onPressed: () {
                  setState(() {
                    currentScreen = const Home();
                    currentTab = 0;
                  });
                },
                child: Icon(Icons.home,
                    color: currentTab == 0 ? Colors.green : Colors.grey),
              ),
              MaterialButton(
                splashColor: Colors.greenAccent,
                height: 60,
                // minWidth: 50,
                onPressed: () {
                  setState(() {
                    currentScreen = const TransactionPage();
                    currentTab = 1;
                  });
                },
                child: Icon(Icons.add,
                    color: currentTab == 1 ? Colors.green : Colors.grey),
              ),
              MaterialButton(
                splashColor: Colors.greenAccent,
                height: 60,
                // minWidth: 50,
                onPressed: () {
                  setState(() {
                    currentScreen = const Profile();
                    currentTab = 2;
                  });
                },
                child: Icon(Icons.person,
                    color: currentTab == 2 ? Colors.green : Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
