import 'package:flutter/material.dart';

import 'package:e_wallet/http/httpTransaction.dart';
import 'package:e_wallet/model/transaction.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({Key? key}) : super(key: key);

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? amount;
  String? category;
  String? reason;

  List<String> listOfValue = [
    'Food',
    'Travel',
    'Shopping',
    'Entertainment',
    'Others',
  ];

  Future<String?> newTransaction(Transaction transaction) {
    var res = HttpConnectTransaction().newTransaction(transaction);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.175),
        child: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: (MediaQuery.of(context).size.height),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Container(
            height: MediaQuery.of(context).size.height * 0.1,
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
              children: const [
                Text("Total Balance"),
                SizedBox(height: 10),
                Text("Rs. 45,000"),
              ],
            ),
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
        child: SingleChildScrollView(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height / 32),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  'New Transaction',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // const Padding(
                //   padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                //   child: Align(
                //     alignment: Alignment.centerLeft,
                //     child: Text("Email"),
                //   ),
                // ),
                TextFormField(
                  onSaved: (value) {
                    email = value;
                  },
                  validator: MultiValidator([
                    EmailValidator(errorText: "Invalid Email"),
                    RequiredValidator(errorText: "* Required Field")
                  ]),
                  keyboardType: TextInputType.emailAddress,
                  style: Theme.of(context).textTheme.bodyText2,
                  decoration: InputDecoration(
                    hintText: "Email",
                    fillColor: Colors.white,
                    filled: true,
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Colors.red)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFF105F49)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  onSaved: (value) {
                    amount = value;
                  },
                  validator: MultiValidator([
                    RequiredValidator(errorText: "* Required Field"),
                  ]),
                  keyboardType: TextInputType.number,
                  style: Theme.of(context).textTheme.bodyText2,
                  decoration: InputDecoration(
                    hintText: "Amount",
                    fillColor: Colors.white,
                    filled: true,
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Colors.red)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFF105F49)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                DropdownButtonFormField(
                  onSaved: (value) {
                    category = value as String?;
                  },
                  validator: MultiValidator([
                    RequiredValidator(errorText: "* Required Field"),
                  ]),
                  style: Theme.of(context).textTheme.bodyText2,
                  dropdownColor: const Color(0xFF105F49),
                  decoration: InputDecoration(
                    hintText: "Category",
                    fillColor: Colors.white,
                    filled: true,
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Colors.red)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFF105F49)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  items: listOfValue.map((String val) {
                    return DropdownMenuItem(
                      value: val,
                      child: Text(
                        val,
                      ),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      category = value;
                    });
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  onSaved: (value) {
                    reason = value;
                  },
                  validator: MultiValidator([
                    RequiredValidator(errorText: "* Required Field"),
                  ]),
                  style: Theme.of(context).textTheme.bodyText2,
                  decoration: InputDecoration(
                    hintText: "Reason",
                    fillColor: Colors.white,
                    filled: true,
                    errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Colors.red)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: const BorderSide(color: Colors.white)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFF105F49)),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                ConfirmationSlider(
                  onConfirmation: () async {
                    if (_formKey.currentState!.validate()) {
                      print('Slider confirmed!');
                      _formKey.currentState!.save();

                      Transaction transaction = Transaction(
                        email: email,
                        amount: amount,
                        category: category,
                        reason: reason,
                      );

                      String? sendmoney = await newTransaction(transaction);
                      if (sendmoney == "true") {
                        Navigator.pushReplacementNamed(context, 'home');
                        MotionToast.success(
                          description: Text(sendmoney!),
                          title: const Text(
                            "success",
                            style: TextStyle(fontSize: 16, color: Colors.green),
                          ),
                          toastDuration: const Duration(seconds: 3),
                        ).show(context);
                      } else {
                        MotionToast.error(
                          description: Text(sendmoney!),
                          title: const Text(
                            "error",
                            style: TextStyle(fontSize: 16, color: Colors.red),
                          ),
                          toastDuration: const Duration(seconds: 3),
                        ).show(context);
                      }
                    }
                  },
                  // width: double.infinity,
                  text: 'Slide to Pay',
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFF105F49),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
