import 'package:e_wallet/http/httpTransaction.dart';
import 'package:e_wallet/http/httpUser.dart';
import 'package:e_wallet/model/tranactionDetails.dart';
import 'package:e_wallet/model/transactionSummary.dart';
import 'package:e_wallet/widgets/drawer.dart';
import 'package:e_wallet/widgets/trasactionHistory.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late Future<TransactionSummary> futureSummary;
  late Future<List<TransactionDetails>> futureDebitTransactions;
  late Future<List<TransactionDetails>> futureCreditTransactions;

  String name = "";
  String balance = "";
  String income = "";
  String expense = "";

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    futureSummary = HttpConnectUser().getTransactionSummary();
    futureDebitTransactions = HttpConnectTransaction().getDebitTransaction();
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
                            return Text("${snapshot.error}");
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
                    const Text("Total Balance"),
                    FutureBuilder<TransactionSummary>(
                      future: futureSummary,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          balance = snapshot.data!.balance != null
                              ? "${snapshot.data!.balance}"
                              : "NA";
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
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
                                  return Text("${snapshot.error}");
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
                                  return Text("${snapshot.error}");
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
              indicatorColor: Theme.of(context).primaryColor,
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
                    child: FutureBuilder<List<TransactionDetails>>(
                      future: futureDebitTransactions,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            reverse: true,
                            itemCount: snapshot.data!.length,
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
                                        '${snapshot.data![index].to!.fname} ${snapshot.data![index].to!.lname}',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        'Rs.'
                                        '${snapshot.data![index].amount}',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                  subtitle: Text(
                                    (snapshot.data![index].transferredAt)
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
                                          transactionId:
                                              snapshot.data![index].sId,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
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
                        }
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
                      },
                    ),
                  ),
                  Center(
                    child: FutureBuilder<List<TransactionDetails>>(
                      future: futureCreditTransactions,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            reverse: true,
                            itemCount: snapshot.data!.length,
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
                                        '${snapshot.data![index].from!.fname} ${snapshot.data![index].from!.lname}',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        'Rs.'
                                        '${snapshot.data![index].amount}',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                  subtitle: Text(
                                    (snapshot.data![index].transferredAt)
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
                                          transactionId:
                                              snapshot.data![index].sId,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
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
                        }
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
                      },
                    ),
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
