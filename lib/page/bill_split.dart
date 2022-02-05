import 'package:flutter/material.dart';
import 'package:e_wallet/model/userDetails.dart';
import 'package:e_wallet/http/httpUser.dart';

class BillSplit extends StatefulWidget {
  const BillSplit({Key? key}) : super(key: key);

  @override
  _BillSplitState createState() => _BillSplitState();
}

class _BillSplitState extends State<BillSplit> {
  late Future<UserDetails> futureProfile;
  String displayName = "";

  @override
  void initState() {
    super.initState();
    futureProfile = HttpConnectUser().getUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Text("Bill Split"),
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
    );
  }
}
