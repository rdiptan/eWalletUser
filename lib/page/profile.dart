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
            Size.fromHeight(MediaQuery.of(context).size.height * 0.325),
        child: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: (MediaQuery.of(context).size.height),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
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
                  IconButton(
                    icon: const Icon(Icons.brightness_6),
                    color: Colors.white,
                    onPressed: () {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .swapTheme();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                height: MediaQuery.of(context).size.height * 0.225,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.5),
                    width: 2,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: const NetworkImage(
                          'https://www.woolha.com/media/2020/03/eevee.png'),
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: 40,
                    ),
                    Divider(
                      color: Colors.white.withOpacity(0.5),
                    ),
                    const Text("drt347826@gmail.com"),
                    TextButton(
                        style: Theme.of(context).textButtonTheme.style,
                        onPressed: () {},
                        child: const Text("Verify KYC")),
                  ],
                ),
              ),
            ],
          ),
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
            TextButton(
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
                style: Theme.of(context).textButtonTheme.style,
                child: const Text("Logout")),
          ],
        ),
      ),
    );
  }
}
