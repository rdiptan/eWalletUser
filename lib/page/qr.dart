import 'package:e_wallet/http/httpTransaction.dart';
import 'package:e_wallet/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:motion_toast/motion_toast.dart';

class QRPage extends StatefulWidget {
  const QRPage({Key? key}) : super(key: key);

  @override
  _QRState createState() => _QRState();
}

class _QRState extends State<QRPage> {
  final _formKey = GlobalKey<FormState>();
  String? email;
  String? amount;
  String? category;
  String? reason;

  Future<String?> newTransaction(Transaction transaction) {
    var res = HttpConnectTransaction().newTransaction(transaction);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height / 32),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
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
              TextFormField(
                onSaved: (value) {
                  category = value;
                },
                validator: MultiValidator([
                  RequiredValidator(errorText: "* Required Field"),
                ]),
                style: Theme.of(context).textTheme.bodyText2,
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
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
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
                style: Theme.of(context).elevatedButtonTheme.style,
                child: Text(
                  "Send Money",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
