import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:path/path.dart' as path;
import 'package:date_time_picker/date_time_picker.dart';
import 'package:e_wallet/utils/load_token.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:e_wallet/http/httpUser.dart';
import 'package:e_wallet/model/userDetails.dart';

class KYC extends StatefulWidget {
  const KYC({Key? key}) : super(key: key);

  @override
  _KYCState createState() => _KYCState();
}

class _KYCState extends State<KYC> {
  final _formKey = GlobalKey<FormState>();
  String? phone;
  String? address;
  String? dob;
  String? citizenship;
  File? _image;

  String baseurl = "http://10.0.2.2:90/";
  // String baseurl = "http://192.168.0.105:90/";

  late Future<UserDetails> futureProfile;

  @override
  void initState() {
    super.initState();
    futureProfile = HttpConnectUser().getUser();
  }

  Future<void> getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  upload(File imageFile) async {
    String? futureToken = await loadToken();
    String authToken = 'Bearer $futureToken';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': authToken,
    };

    // open a bytestream
    var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse(baseurl + "user/kyc/update");

    // create multipart request
    var request = http.MultipartRequest("PUT", uri);

    request.headers.addAll(headers);

    // multipart that takes file
    var multipartFile = http.MultipartFile('document', stream, length,
        filename: path.basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();
    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
    if (response.statusCode == 200) {
      MotionToast.success(
        description: const Text("Your KYC has been updated successfully"),
        title: const Text(
          "Documents Updated",
          style: TextStyle(fontSize: 16, color: Colors.green),
        ),
        toastDuration: const Duration(seconds: 3),
      ).show(context);
      Navigator.pushReplacementNamed(context, 'home');
    } else {
      MotionToast.error(
        description: const Text("Error occured while updating KYC"),
        title: const Text(
          "error",
          style: TextStyle(fontSize: 16, color: Colors.red),
        ),
        toastDuration: const Duration(seconds: 3),
      ).show(context);
    }
  }

  int _currentStep = 0;

  Future<String?> updateKYC(UserDetails userdetails) {
    var res = HttpConnectUser().updateKYC(userdetails);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('KYC'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Center(
              child: FutureBuilder<UserDetails>(
                  future: futureProfile,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Stepper(
                        type: StepperType.vertical,
                        physics: const ScrollPhysics(),
                        currentStep: _currentStep,
                        onStepTapped: (step) => tapped(step),
                        onStepContinue: continued,
                        onStepCancel: cancel,
                        steps: <Step>[
                          Step(
                            title: const Text('Personal Information'),
                            isActive: _currentStep >= 0,
                            state: _currentStep >= 0
                                ? StepState.complete
                                : StepState.disabled,
                            content: Column(
                              children: [
                                TextFormField(
                                  initialValue: snapshot.data!.phone != null
                                      ? "${snapshot.data!.phone}"
                                      : "",
                                  onSaved: (value) {
                                    phone = value;
                                  },
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: "* Required Field"),
                                    MinLengthValidator(8,
                                        errorText: 'Invalid phone number'),
                                  ]),
                                  decoration: const InputDecoration(
                                      labelText: 'Phone Number'),
                                ),
                                TextFormField(
                                  initialValue: snapshot.data!.address != null
                                      ? "${snapshot.data!.address}"
                                      : "",
                                  onSaved: (value) {
                                    address = value;
                                  },
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: "* Required Field"),
                                  ]),
                                  decoration: const InputDecoration(
                                      labelText: 'Address'),
                                ),
                                DateTimePicker(
                                  initialValue: snapshot.data!.dob != null
                                      ? (snapshot.data!.dob)
                                          .toString()
                                          .substring(0, 10)
                                      : "",
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100),
                                  dateLabelText: 'Date',
                                  onChanged: (val) => print(val),
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: "* Required Field"),
                                  ]),
                                  onSaved: (val) {
                                    dob = val;
                                  },
                                ),
                                TextFormField(
                                  initialValue:
                                      snapshot.data!.citizenship != null
                                          ? "${snapshot.data!.citizenship}"
                                          : "",
                                  onSaved: (value) {
                                    citizenship = value;
                                  },
                                  validator: MultiValidator([
                                    RequiredValidator(
                                        errorText: "* Required Field"),
                                  ]),
                                  decoration: const InputDecoration(
                                      labelText: 'Citizenship Number'),
                                ),
                              ],
                            ),
                          ),
                          Step(
                            title: const Text('Document Upload'),
                            isActive: _currentStep >= 1,
                            state: _currentStep >= 1
                                ? StepState.complete
                                : StepState.disabled,
                            content: Column(
                              children: [
                                const Text("Select an image"),
                                FlatButton.icon(
                                    onPressed: () async => await getImage(),
                                    icon: const Icon(Icons.upload_file),
                                    label: const Text("Browse")),
                                const SizedBox(
                                  height: 20,
                                ),
                                snapshot.data!.citizenshipProof != null
                                    ? Image.network(baseurl +
                                        "${snapshot.data!.citizenshipProof}")
                                    : _image == null
                                        ? const CircularProgressIndicator()
                                        : Image.file(
                                            _image!,
                                          ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                    return const CircularProgressIndicator();
                  }),
            ),
          ],
        ),
      ),
    );
  }

  tapped(int step) {
    setState(() => _currentStep = step);
  }

  continued() async {
    if (_currentStep < 1) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        UserDetails userdetails = UserDetails(
          phone: phone,
          address: address,
          dob: dob,
          citizenship: citizenship,
        );
        String? updatekyc = await updateKYC(userdetails);
        if (updatekyc == "true") {
          setState(() => _currentStep += 1);
        }
      }
    } else {
      upload(_image!);
    }
  }

  cancel() {
    _currentStep > 0
        ? setState(() {
            _currentStep -= 1;
          })
        : Navigator.of(context).pop();
  }
}
