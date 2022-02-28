// ignore_for_file: non_constant_identifier_names

import 'package:e_wallet/http/httpUser.dart';
import 'package:e_wallet/utils/load_token.dart';
import 'package:e_wallet/utils/theme.dart';
import 'package:e_wallet/widgets/about.dart';
import 'package:e_wallet/widgets/faq.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final _formKey = GlobalKey<FormState>();
  String? old_password;
  String? new_password;

  Future<String?> changepassword(String old_password, String new_password) {
    var res = HttpConnectUser().changePassword(old_password, new_password);
    return res;
  }

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
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const FAQ()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.info,
              color: Colors.white,
            ),
            title: const Text('About'),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const About()));
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.change_circle_outlined,
              color: Colors.white,
            ),
            title: const Text('Change Password'),
            onTap: () {
              AlertDialog alert = AlertDialog(
                content: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Positioned(
                      right: -40.0,
                      top: -40.0,
                      child: InkResponse(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: const CircleAvatar(
                          child: Icon(Icons.close),
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextFormField(
                            onSaved: (value) {
                              old_password = value;
                            },
                            validator: MultiValidator([
                              RequiredValidator(errorText: "* Required Field")
                            ]),
                            style: Theme.of(context).textTheme.bodyText2,
                            decoration: InputDecoration(
                              hintText: "Old Password",
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.red)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Color(0xFF105F49)),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          const SizedBox(height: 2),
                          TextFormField(
                            onSaved: (value) {
                              new_password = value;
                            },
                            validator: MultiValidator([
                              RequiredValidator(errorText: "* Required Field")
                            ]),
                            style: Theme.of(context).textTheme.bodyText2,
                            decoration: InputDecoration(
                              hintText: "New Password",
                              errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.red)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide:
                                      const BorderSide(color: Colors.white)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide:
                                    const BorderSide(color: Color(0xFF105F49)),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          RaisedButton(
                            child: const Text("Change"),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                _formKey.currentState!.save();
                                String? result = await changepassword(
                                    old_password!, new_password!);
                                if (result == 'true') {
                                  Navigator.pop(context);
                                  MotionToast.success(
                                    description: const Text(
                                        "Password Changed Successfully"),
                                    title: const Text(
                                      "Password Changed",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.green),
                                    ),
                                    toastDuration: const Duration(seconds: 3),
                                  ).show(context);
                                } else {
                                  Navigator.pop(context);
                                  MotionToast.error(
                                    description: Text(result!),
                                    title: const Text(
                                      "Failed!!!",
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.red),
                                    ),
                                    toastDuration: const Duration(seconds: 3),
                                  ).show(context);
                                }
                              }
                            },
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return alert;
                },
              );
            },
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
                    // Navigator.pushReplacementNamed(context, 'login');
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        'login', (Route<dynamic> route) => false);
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
