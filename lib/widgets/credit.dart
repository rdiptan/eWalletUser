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

late Box creditBox;
List creditData = [];

Future openCreditBox() async {
  var dir = await path.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  creditBox = await Hive.openBox('creditData');
  return;
}

Future<bool> fetchCreditData() async {
  await openCreditBox();

  String? futureToken = await loadToken();
  String authToken = 'Bearer $futureToken';

  try {
    final response = await http
        .get(Uri.parse(baseurl + 'transaction/view/credit'), headers: {
      'Content-Type': 'application/json',
      'Authorization': authToken,
    });
    if (response.statusCode != 200) {
      throw "Error While Retrieving Data from Server";
    }
    var output = json.decode(response.body);
    await putCreditData(output['data']);
  } catch (SocketException) {
    print("No Internet Connection");
  }

  var mycreditmap = creditBox.toMap().values.toList();
  if (mycreditmap.isEmpty) {
    creditData.add('empty');
  } else {
    creditData = mycreditmap;
  }

  return Future.value(true);
}

Future putCreditData(data) async {
  await creditBox.clear();
  for (var d in data) {
    creditBox.add(d);
  }
}

class Credit extends StatefulWidget {
  const Credit({Key? key}) : super(key: key);

  @override
  State<Credit> createState() => _CreditState();
}

class _CreditState extends State<Credit> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
          future: fetchCreditData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (creditData.contains('empty')) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Image(image: AssetImage('images/CurrencyInvestment.png')),
                    Text("No Transactions Found!!!"),
                    Text("You have not received any transaction yet..."),
                  ],
                );
              } else {
                return ListView.builder(
                  // reverse: true,
                  itemCount: creditData.length,
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
                              '${creditData[creditData.length - 1 - index]['from']['fname']} ${creditData[creditData.length - 1 - index]['from']['lname']}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Rs.'
                              '${creditData[creditData.length - 1 - index]['amount']}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        subtitle: Text(
                          (creditData[creditData.length - 1 - index]
                                  ['transferred_at'])
                              .toString()
                              .substring(0, 10),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.black54,
                          ),
                        ),
                        trailing:
                            const Icon(Icons.arrow_upward, color: Colors.green),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TransactionHistory(
                                transaction:
                                    creditData[creditData.length - 1 - index],
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              }
            } else if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Image(image: AssetImage('images/CurrencyInvestment.png')),
                  Text("No Transactions Found!!!"),
                  Text("You have not received any transaction yet..."),
                ],
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Image(image: AssetImage('images/CurrencyInvestment.png')),
                Text("No Transactions Found!!!"),
                Text("You have not received any transaction yet..."),
              ],
            );
          }),
    );
  }
}
