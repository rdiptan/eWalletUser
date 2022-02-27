import 'package:e_wallet/http/httpTransaction.dart';
import 'package:e_wallet/model/tranactionDetails.dart';
import 'package:flutter/material.dart';

class TransactionHistory extends StatefulWidget {
  final String? transactionId;

  const TransactionHistory({Key? key, @required this.transactionId})
      : super(key: key);

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  late Future<TransactionDetails> futurehistory;

  @override
  void initState() {
    super.initState();
    futurehistory =
        HttpConnectTransaction().getTransactionById(widget.transactionId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Detail'),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: FutureBuilder<TransactionDetails>(
        future: futurehistory,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return DataTable(columns: const [
              DataColumn(label: Text("")),
              DataColumn(label: Text("")),
            ], rows: [
              DataRow(cells: [
                const DataCell(Text("Amount (NPR)")),
                DataCell(Text(snapshot.data!.amount.toString())),
              ]),
              DataRow(cells: [
                const DataCell(Text("Date")),
                DataCell(Text(
                    snapshot.data!.transferredAt.toString().substring(0, 10))),
              ]),
              DataRow(cells: [
                const DataCell(Text("Category")),
                DataCell(Text(snapshot.data!.category.toString()))
              ]),
              DataRow(cells: [
                const DataCell(Text("Reason")),
                DataCell(Text(snapshot.data!.reason.toString()))
              ]),
              DataRow(cells: [
                const DataCell(Text("From")),
                DataCell(Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(snapshot.data!.from!.fname.toString() +
                        " " +
                        snapshot.data!.from!.lname.toString()),
                    Text(snapshot.data!.from!.email.toString())
                  ],
                ))
              ]),
              DataRow(cells: [
                const DataCell(Text("To")),
                DataCell(Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(snapshot.data!.to!.fname.toString() +
                        " " +
                        snapshot.data!.to!.lname.toString()),
                    Text(snapshot.data!.to!.email.toString())
                  ],
                ))
              ]),
              const DataRow(cells: [DataCell(Text("")), DataCell(Text(""))]),
            ]);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
