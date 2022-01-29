import 'package:flutter/material.dart';
import 'package:e_wallet/utils/load_token.dart';

class ValidationPage extends StatefulWidget {
  const ValidationPage({Key? key}) : super(key: key);

  @override
  _ValidationScreenState createState() => _ValidationScreenState();
}

class _ValidationScreenState extends State<ValidationPage> {
  String? _token;

  getToken() async {
    String? futureToken = await loadToken();
    setState(() {
      _token = futureToken!;
    });
  }

  @override
  void initState() {
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    print(_token);
    if (_token == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            color: Colors.white,
            backgroundColor: Theme.of(context).backgroundColor,
          ),
        ),
      );
    } else if (_token == "") {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, 'login');
      });
    } else {
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, 'home');
      });
    }
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.white,
          backgroundColor: Theme.of(context).backgroundColor,
        ),
      ),
    );
  }
}
