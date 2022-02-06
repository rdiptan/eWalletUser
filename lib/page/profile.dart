import 'package:e_wallet/http/httpUser.dart';
import 'package:e_wallet/model/userDetails.dart';
import 'package:flutter/material.dart';
import 'package:e_wallet/utils/load_token.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:e_wallet/utils/theme.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Future<UserDetails> futureProfile;
  String displayName = "";
  @override
  void initState() {
    super.initState();
    futureProfile = HttpConnectUser().getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.21),
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: (MediaQuery.of(context).size.height),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Theme.of(context).accentColor,
        ),
        child: Column(
          children: [
            const Text("Profile"),
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
                icon: const Icon(Icons.logout)),
            IconButton(
              icon: const Icon(Icons.brightness_6),
              color: Colors.white,
              onPressed: () {
                Provider.of<ThemeProvider>(context, listen: false).swapTheme();
              },
            ),
            FutureBuilder<UserDetails>(
              future: futureProfile,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  displayName = snapshot.data!.user!.lname != null ||
                          snapshot.data!.user!.lname != null
                      ? "${snapshot.data!.user!.fname} ${snapshot.data!.user!.lname}"
                      : "";
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return Text(displayName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
