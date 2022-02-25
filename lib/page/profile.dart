import 'package:e_wallet/http/httpUser.dart';
import 'package:e_wallet/model/userDetails.dart';
import 'package:e_wallet/widgets/kyc.dart';
import 'package:flutter/material.dart';
import 'package:e_wallet/utils/load_token.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:e_wallet/utils/theme.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Future<UserDetails> futureProfile;
  String displayName = "";
  String email = "";
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
                                : "User";
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
                    FutureBuilder<UserDetails>(
                      future: futureProfile,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          email = snapshot.data!.user!.email != null
                              ? "${snapshot.data!.user!.email}"
                              : "NA";
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return Text(email);
                      },
                    ),
                    TextButton(
                        style: Theme.of(context).textButtonTheme.style,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const KYC()),
                          );
                        },
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
            const SizedBox(
              height: 16,
            ),
            const Text(
              "My Information",
            ),
            Divider(
              color: Colors.black.withOpacity(0.5),
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  "Name",
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Card(
              margin: const EdgeInsets.all(10),
              color: Colors.white,
              elevation: 2,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: [
                  ListTile(
                    title: Text('My Review',
                        style: Theme.of(context).textTheme.bodyText2,
                        textAlign: TextAlign.center),
                    subtitle: Text(
                      'Review Date',
                      style: TextStyle(color: Colors.black.withOpacity(0.6)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: Text(
                      'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                      style: TextStyle(color: Colors.black.withOpacity(0.8)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
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
