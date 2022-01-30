import 'package:flutter/material.dart';

class BillSplit extends StatefulWidget {
  const BillSplit({Key? key}) : super(key: key);

  @override
  _BillSplitState createState() => _BillSplitState();
}

class _BillSplitState extends State<BillSplit> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Text("Bill Split"),
    );
  }
}
