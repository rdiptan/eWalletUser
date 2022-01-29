// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:e_wallet/utils/load_token.dart';
import 'package:motion_toast/motion_toast.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () async {
                await removeToken();
                Navigator.pushReplacementNamed(context, 'login');
                MotionToast.success(
                  description: const Text("Logout Successfully"),
                  title: const Text(
                    "success",
                    style: TextStyle(fontSize: 16, color: Colors.green),
                  ),
                  toastDuration: const Duration(seconds: 3),
                ).show(context);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
    );
  }
}
