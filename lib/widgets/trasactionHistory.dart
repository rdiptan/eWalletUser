import 'package:e_wallet/model/tranactionDetails.dart';
import 'package:flutter/material.dart';

class TransactionHistory extends StatefulWidget {
  final Map<String, dynamic> transaction;

  const TransactionHistory({Key? key, required this.transaction})
      : super(key: key);

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  late Future<TransactionDetails> futurehistory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Detail'),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: DataTable(columns: const [
        DataColumn(label: Text("")),
        DataColumn(label: Text("")),
      ], rows: [
        DataRow(cells: [
          const DataCell(Text("Amount (NPR)")),
          DataCell(Text(widget.transaction['amount'].toString())),
        ]),
        DataRow(cells: [
          const DataCell(Text("Date")),
          DataCell(Text(widget.transaction['transferred_at']
              .toString()
              .substring(0, 10))),
        ]),
        DataRow(cells: [
          const DataCell(Text("Category")),
          DataCell(Text(widget.transaction['category'].toString()))
        ]),
        DataRow(cells: [
          const DataCell(Text("Reason")),
          DataCell(Text(widget.transaction['reason'].toString()))
        ]),
        DataRow(cells: [
          const DataCell(Text("From")),
          DataCell(Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.transaction['from']['fname'].toString() +
                  " " +
                  widget.transaction['from']['lname'].toString()),
              Text(widget.transaction['from']['email'].toString())
            ],
          ))
        ]),
        DataRow(cells: [
          const DataCell(Text("To")),
          DataCell(Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.transaction['to']['fname'].toString() +
                  " " +
                  widget.transaction['to']['lname'].toString()),
              Text(widget.transaction['to']['email'].toString())
            ],
          ))
        ]),
        const DataRow(cells: [DataCell(Text("")), DataCell(Text(""))]),
      ]),
    );
  }
}
