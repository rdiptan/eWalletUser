// ignore_for_file: file_names

import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.2),
        child: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Color(0xFFF6F6F6),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Registration",
                textScaleFactor: 2,
                style: TextStyle(
                    color: Color(0xFF105F49), fontWeight: FontWeight.w700),
              ),
              TextFormField(),
              TextFormField(),
              TextFormField(),
              TextFormField(),
              ElevatedButton(onPressed: () {}, child: const Text("data")),
              InkWell(
                onTap: () => Navigator.pushNamed(context, 'login'),
                child: RichText(
                  text: const TextSpan(children: [
                    WidgetSpan(child: Icon(Icons.login)),
                    TextSpan(),
                    TextSpan(),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
