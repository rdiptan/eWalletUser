import 'package:flutter/material.dart';
import 'package:e_wallet/utils/load_token.dart';
import 'package:motion_toast/motion_toast.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IconButton(
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
          icon: const Icon(Icons.logout)),
    );
  }
}
