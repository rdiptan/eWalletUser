import 'package:e_wallet/utils/load_token.dart';
import 'package:e_wallet/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(),
            child: Image(image: AssetImage('images/MobileMoney.png')),
          ),
          ListTile(
            leading: const Icon(
              Icons.question_answer,
              color: Colors.white,
            ),
            title: const Text('FAQs'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(
              Icons.info,
              color: Colors.white,
            ),
            title: const Text('About'),
            onTap: () {},
          ),
          const Divider(
            color: Colors.white,
          ),
          ListTile(
            leading: const Icon(
              Icons.brightness_6,
              color: Colors.white,
            ),
            title: const Text('Theme'),
            onTap: () {
              Provider.of<ThemeProvider>(context, listen: false).swapTheme();
            },
          ),
          ListTile(
              leading: const Icon(
                Icons.logout_outlined,
                color: Colors.white,
              ),
              title: const Text('Logout'),
              onTap: () {
                Widget cancelButton = TextButton(
                  child: const Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                );
                Widget continueButton = TextButton(
                  child: const Text("Continue"),
                  onPressed: () async {
                    await removeToken();
                    Navigator.pushReplacementNamed(context, 'login');
                  },
                );

                // set up the AlertDialog
                AlertDialog alert = AlertDialog(
                  title: const Text(
                    "Logout",
                    style: TextStyle(color: Colors.black),
                  ),
                  content: const Text(
                    "Are you Sure You want to logout the app",
                    style: TextStyle(color: Colors.black),
                  ),
                  actions: [
                    cancelButton,
                    continueButton,
                  ],
                );

                // show the dialog
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return alert;
                  },
                );
              }),
        ],
      ),
    );
  }
}
