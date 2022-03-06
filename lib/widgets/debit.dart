import 'package:e_wallet/utils/base_url.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:e_wallet/utils/load_token.dart';
import 'package:e_wallet/widgets/trasactionHistory.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:http/http.dart' as http;

String baseurl = baseURL();

late Box debitBox;
List debitData = [];

Future openDebitBox() async {
  var dir = await path.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  debitBox = await Hive.openBox('debitData');
  return;
}

Future<bool> fetchDebitData() async {
  await openDebitBox();

  String? futureToken = await loadToken();
  String authToken = 'Bearer $futureToken';

  try {
    final response =
        await http.get(Uri.parse(baseurl + 'transaction/view/debit'), headers: {
      'Content-Type': 'application/json',
      'Authorization': authToken,
    });
    if (response.statusCode != 200) {
      throw "Error While Retrieving Data from Server";
    }
    var output = json.decode(response.body);
    await putDebitData(output['data']);
  } catch (SocketException) {
    print("No Internet Connection");
  }

  var mymap = debitBox.toMap().values.toList();
  if (mymap.isEmpty) {
    debitData.add('empty');
  } else {
    debitData = mymap;
  }

  return Future.value(true);
}

Future putDebitData(data) async {
  await debitBox.clear();
  for (var d in data) {
    debitBox.add(d);
  }
}

class Debit extends StatefulWidget {
  const Debit({Key? key}) : super(key: key);

  @override
  State<Debit> createState() => _DebitState();
}

class _DebitState extends State<Debit> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
          future: fetchDebitData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (debitData.contains('empty')) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Image(image: AssetImage('images/CurrencyInvestment.png')),
                    Text("No Transactions Found!!!"),
                    Text("Please add a new transaction..."),
                  ],
                );
              } else {
                return ListView.builder(
                  // reverse: true,
                  itemCount: debitData.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white70,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 5,
                      ),
                      elevation: 2,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${debitData[debitData.length - 1 - index]['to']['fname']} ${debitData[debitData.length - 1 - index]['to']['lname']}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Rs.'
                              '${debitData[debitData.length - 1 - index]['amount']}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          (debitData[debitData.length - 1 - index]
                                  ['transferred_at'])
                              .toString()
                              .substring(0, 10),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_downward,
                          color: Colors.red,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TransactionHistory(
                                transaction:
                                    debitData[debitData.length - 1 - index],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              }
            }
            return const CircularProgressIndicator();
          }),
    );
  }
}
