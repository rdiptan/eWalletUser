import 'dart:convert';
import 'package:e_wallet/http/httpTransaction.dart';
import 'package:e_wallet/http/httpUser.dart';
import 'package:e_wallet/model/tranactionDetails.dart';
import 'package:e_wallet/model/transactionSummary.dart';
import 'package:e_wallet/utils/load_token.dart';
import 'package:e_wallet/widgets/drawer.dart';
import 'package:e_wallet/widgets/trasactionHistory.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late Future<TransactionSummary> futureSummary;
  late Future<List<TransactionDetails>> futureCreditTransactions;

  String name = "";
  String balance = "";
  String income = "";
  String expense = "";

  String baseurl = "http://10.0.2.2:90/";
  // String baseurl = "http://192.168.0.105:90/";

  late Box creditBox;
  List creditData = [];
  late Box debitBox;
  List debitData = [];

  Future openDebitBox() async {
    var dir = await path.getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    debitBox = await Hive.openBox('debitData');
    return;
  }

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

  Future<bool> fetchDebitData() async {
    await openDebitBox();

    String? futureToken = await loadToken();
    String authToken = 'Bearer $futureToken';

    try {
      final response = await http
          .get(Uri.parse(baseurl + 'transaction/view/debit'), headers: {
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

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    futureSummary = HttpConnectUser().getTransactionSummary();
    futureCreditTransactions = HttpConnectTransaction().getCreditTransaction();
  }

  late TabController _tabController;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.3),
        child: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: (MediaQuery.of(context).size.height),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome',
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.02,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey,
                        ),
                      ),
                      FutureBuilder<TransactionSummary>(
                        future: futureSummary,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            name = snapshot.data!.name != null
                                ? "${snapshot.data!.name}"
                                : "User";
                          } else if (snapshot.hasError) {
                            return const Text("Diptan Regmi");
                          }
                          return Text(name);
                        },
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () {
                      _scaffoldKey.currentState!.openDrawer();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.5),
                    width: 2,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Current Balance"),
                    FutureBuilder<TransactionSummary>(
                      future: futureSummary,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          balance = snapshot.data!.balance != null
                              ? "${snapshot.data!.balance}"
                              : "NA";
                        } else if (snapshot.hasError) {
                          return const Text("No Internet Connection");
                        }
                        return Text("Rs.$balance");
                      },
                    ),
                    Divider(
                      color: Colors.white.withOpacity(0.5),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            const Text("Income"),
                            FutureBuilder<TransactionSummary>(
                              future: futureSummary,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  income = snapshot.data!.credit != null
                                      ? "${snapshot.data!.credit}"
                                      : "NA";
                                } else if (snapshot.hasError) {
                                  return const Text("NA");
                                }
                                return Text("Rs.$income");
                              },
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            const Text("Expense"),
                            FutureBuilder<TransactionSummary>(
                              future: futureSummary,
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  expense = snapshot.data!.debit != null
                                      ? "${snapshot.data!.debit}"
                                      : "NA";
                                } else if (snapshot.hasError) {
                                  return const Text("NA");
                                }
                                return Text("Rs.$expense");
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: (MediaQuery.of(context).size.height),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Theme.of(context).accentColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TabBar(
              unselectedLabelColor: Colors.grey,
              labelColor: Theme.of(context).primaryColor,
              labelStyle:
                  const TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
              unselectedLabelStyle: const TextStyle(fontSize: 16.0),
              indicatorColor: Colors.blueGrey,
              indicatorWeight: 4,
              tabs: const [
                Tab(
                  text: 'Debit',
                ),
                Tab(
                  text: 'Credit',
                )
              ],
              controller: _tabController,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Center(
                    child: FutureBuilder(
                        future: fetchDebitData(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (debitData.contains('empty')) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Image(
                                      image: AssetImage(
                                          'images/CurrencyInvestment.png')),
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(16)),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: ListTile(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                            builder: (context) =>
                                                TransactionHistory(
                                              transaction: debitData[
                                                  debitData.length - 1 - index],
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
                  ),
                  Center(
                    child: FutureBuilder(
                        future: fetchCreditData(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (debitData.contains('empty')) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Image(
                                      image: AssetImage(
                                          'images/CurrencyInvestment.png')),
                                  Text("No Transactions Found!!!"),
                                  Text(
                                      "You have not received any transaction yet..."),
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
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(16)),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: ListTile(
                                      title: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                        (creditData[creditData.length -
                                                1 -
                                                index]['transferred_at'])
                                            .toString()
                                            .substring(0, 10),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black54,
                                        ),
                                      ),
                                      trailing: const Icon(Icons.arrow_upward,
                                          color: Colors.green),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TransactionHistory(
                                              transaction: creditData[
                                                  creditData.length -
                                                      1 -
                                                      index],
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
                                Image(
                                    image: AssetImage(
                                        'images/CurrencyInvestment.png')),
                                Text("No Transactions Found!!!"),
                                Text(
                                    "You have not received any transaction yet..."),
                              ],
                            );
                          }
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Image(
                                  image: AssetImage(
                                      'images/CurrencyInvestment.png')),
                              Text("No Transactions Found!!!"),
                              Text(
                                  "You have not received any transaction yet..."),
                            ],
                          );
                        }),
                  ),
                ],
                controller: _tabController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
