// ignore_for_file: file_names

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:e_wallet/http/httpUser.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? password;
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<String?> loginUser(String email, String password) {
    var res = HttpConnectUser().loginUser(email, password);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true,
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
      body: Stack(
        // ignore: deprecated_member_use
        overflow: Overflow.visible,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        fit: StackFit.loose,
        alignment: Alignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: (MediaQuery.of(context).size.height),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              color: Theme.of(context).accentColor,
            ),
            child: SingleChildScrollView(
              padding: EdgeInsets.all(MediaQuery.of(context).size.height / 32),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image(image: AssetImage('images/Currency.png')),
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      "Login",
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    TextFormField(
                      key: const Key('email'),
                      onSaved: (value) {
                        email = value;
                      },
                      validator: MultiValidator([
                        EmailValidator(errorText: "Invalid Email"),
                        RequiredValidator(errorText: "* Required Field")
                      ]),
                      keyboardType: TextInputType.emailAddress,
                      style: Theme.of(context).textTheme.bodyText2,
                      decoration: InputDecoration(
                        hintText: "Email",
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.black,
                        ),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.red)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: Color(0xFF105F49)),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      key: const Key('password'),
                      onSaved: (value) {
                        password = value;
                      },
                      validator: MultiValidator(
                          [RequiredValidator(errorText: "* Required Field")]),
                      style: Theme.of(context).textTheme.bodyText2,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        hintText: "Password",
                        fillColor: Colors.white,
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.lock,
                          color: Colors.black,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            _toggle();
                          },
                        ),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.red)),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: Color(0xFF105F49)),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    ElevatedButton(
                      key: const Key('login'),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          String? loggedin = await loginUser(email!, password!);
                          if (loggedin == "true") {
                            Navigator.pushReplacementNamed(context, 'home');
                            AwesomeNotifications().createNotification(
                                content: NotificationContent(
                              id: 3,
                              channelKey: 'eWallet',
                              title: 'Welcome Back!!!',
                              body: 'User loggedin by $email.',
                            ));
                          } else {
                            MotionToast.error(
                              description: Text(loggedin!),
                              title: const Text(
                                "error",
                                style:
                                    TextStyle(fontSize: 16, color: Colors.red),
                              ),
                              toastDuration: const Duration(seconds: 3),
                            ).show(context);
                          }
                        }
                      },
                      style: Theme.of(context).elevatedButtonTheme.style,
                      child: Text(
                        "Login",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, 'registration'),
                      child: RichText(
                        text: const TextSpan(children: [
                          WidgetSpan(
                              child: Icon(
                            Icons.unarchive,
                            color: Colors.black,
                          )),
                          TextSpan(
                              text: "I am a new user!!! ",
                              style: TextStyle(
                                  color: Color(0xFF7C7A88), fontSize: 16)),
                          TextSpan(
                              text: "Register!",
                              style: TextStyle(
                                  color: Color(0xFF15102E), fontSize: 16)),
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            // top: -160,
            top: -(MediaQuery.of(context).size.height / 4.75),
            // left: (MediaQuery.of(context).size.height / 15),
            child: Image.asset(
              'images/Currency.png',
              fit: BoxFit.contain,
              height: (MediaQuery.of(context).size.height * 0.25),
            ),
          ),
        ],
      ),
    );
  }
}
