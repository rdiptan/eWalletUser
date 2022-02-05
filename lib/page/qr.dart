import 'package:e_wallet/http/httpTransaction.dart';
import 'package:e_wallet/model/transaction.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

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
    );
  }
}
