// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:e_wallet/page/bill_split.dart';
import 'package:e_wallet/page/home.dart';
import 'package:e_wallet/page/profile.dart';
import 'package:e_wallet/page/qr.dart';
import 'package:e_wallet/page/transaction.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentTab = 0;
  final List<Widget> screens = [
    Home(),
    Transaction(),
    QRPage(),
    BillSplit(),
    Profile()
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Home();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Colors.white, width: 2)),
        elevation: 0,
        mini: false,
        hoverElevation: 1.5,
        backgroundColor: const Color(0xFF105F49),
        splashColor: Colors.green[900],
        onPressed: () {
          setState(() {
            currentScreen = QRPage();
            currentTab = 2;
          });
        },
        child: const Icon(Icons.qr_code),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        // shape: CircularNotchedRectangle(),
        // notchMargin: 10,
        child: SizedBox(
          height: 60,
          width: double.infinity,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              MaterialButton(
                splashColor: Colors.greenAccent,
                height: 60,
                // minWidth: 50,
                onPressed: () {
                  setState(() {
                    currentScreen = Home();
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
                    currentScreen = Transaction();
                    currentTab = 1;
                  });
                },
                child: Icon(Icons.transform,
                    color: currentTab == 1 ? Colors.green : Colors.grey),
              ),
              const SizedBox(
                width: 40,
              ),
              MaterialButton(
                splashColor: Colors.greenAccent,
                height: 60,
                // minWidth: 50,
                onPressed: () {
                  setState(() {
                    currentScreen = BillSplit();
                    currentTab = 3;
                  });
                },
                child: Icon(Icons.call_split,
                    color: currentTab == 3 ? Colors.green : Colors.grey),
              ),
              MaterialButton(
                splashColor: Colors.greenAccent,
                height: 60,
                // minWidth: 50,
                onPressed: () {
                  setState(() {
                    currentScreen = Profile();
                    currentTab = 4;
                  });
                },
                child: Icon(Icons.person,
                    color: currentTab == 4 ? Colors.green : Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
