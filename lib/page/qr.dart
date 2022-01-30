import 'package:flutter/material.dart';

class QRPage extends StatefulWidget {
  const QRPage({Key? key}) : super(key: key);

  @override
  _QRState createState() => _QRState();
}

class _QRState extends State<QRPage> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Text("QRPage"),
    );
  }
}
