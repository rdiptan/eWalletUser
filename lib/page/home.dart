import 'package:e_wallet/http/httpTransaction.dart';
import 'package:e_wallet/http/httpUser.dart';
import 'package:e_wallet/model/tranactionDetails.dart';
import 'package:e_wallet/model/transactionSummary.dart';
import 'package:e_wallet/widgets/credit.dart';
import 'package:e_wallet/widgets/debit.dart';
import 'package:e_wallet/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyTabs extends GetxController with GetSingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    const Tab(text: 'Debit'),
    const Tab(text: 'Credit'),
  ];

  late TabController controller;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}

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
    final MyTabs _tabs = Get.put(MyTabs());
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
              tabs: _tabs.myTabs,
              controller: _tabs.controller,
              indicatorSize: TabBarIndicatorSize.tab,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabs.controller,
                children: const [Debit(), Credit()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
