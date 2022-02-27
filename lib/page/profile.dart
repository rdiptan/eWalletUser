import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:async/async.dart';
import 'package:e_wallet/model/review.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:e_wallet/http/httpUser.dart';
import 'package:e_wallet/model/userDetails.dart';
import 'package:e_wallet/widgets/kyc.dart';
import 'package:flutter/material.dart';
import 'package:e_wallet/utils/load_token.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:provider/provider.dart';
import 'package:e_wallet/utils/theme.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  String newComment = "";
  double newRating = 0;

  late Future<UserDetails> futureProfile;
  late Future<Review> futureReview;

  String displayName = "";
  String email = "";
  String balance = "";

  String comment = "";
  double ratingNo = 0;
  String updatedAt = "";

  @override
  void initState() {
    super.initState();
    futureProfile = HttpConnectUser().getUser();
    futureReview = HttpConnectUser().getReview();
    _image = null;
  }

  //method to open image from gallery
  _imageFromGallery() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('no image selected');
      }
    });
  }

  //method to open image from camera
  _imageFromCamera() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('no image selected');
      }
    });
  }

  upload(File imageFile) async {
    String baseurl = "http://10.0.2.2:90/";

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
    var uri = Uri.parse(baseurl + "user/profile/update");

    // create multipart request
    var request = http.MultipartRequest("PUT", uri);

    request.headers.addAll(headers);

    // multipart that takes file
    var multipartFile = http.MultipartFile('image', stream, length,
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
        description: const Text("Your Profile has been uploaded successfully"),
        title: const Text(
          "Profile Uploaded",
          style: TextStyle(fontSize: 16, color: Colors.green),
        ),
        toastDuration: const Duration(seconds: 3),
      ).show(context);
      setState(() {
        _image = null;
        futureProfile = HttpConnectUser().getUser();
      });
    } else {
      MotionToast.error(
        description: const Text("Error occured uploading Profile"),
        title: const Text(
          "error",
          style: TextStyle(fontSize: 16, color: Colors.red),
        ),
        toastDuration: const Duration(seconds: 3),
      ).show(context);
    }
  }

  Future<String?> newReview(String newComment, double newRating) async {
    var res = HttpConnectUser().newReview(newComment, newRating);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.325),
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
                      FutureBuilder<UserDetails>(
                        future: futureProfile,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            displayName = snapshot.data!.user!.lname != null ||
                                    snapshot.data!.user!.lname != null
                                ? "${snapshot.data!.user!.fname} ${snapshot.data!.user!.lname}"
                                : "User";
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }
                          return Text(displayName);
                        },
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.brightness_6),
                    color: Colors.white,
                    onPressed: () {
                      Provider.of<ThemeProvider>(context, listen: false)
                          .swapTheme();
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Container(
                height: MediaQuery.of(context).size.height * 0.225,
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
                    InkWell(
                      child: FutureBuilder<UserDetails>(
                        future: futureProfile,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!.user!.image != null) {
                              return CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'http://10.0.2.2:90/${snapshot.data!.user!.image}'),
                                backgroundColor: Theme.of(context).primaryColor,
                                radius: 40,
                              );
                            } else {
                              return CircleAvatar(
                                backgroundImage: const NetworkImage(
                                    'https://www.woolha.com/media/2020/03/eevee.png'),
                                backgroundColor: Theme.of(context).primaryColor,
                                radius: 40,
                              );
                            }
                          }
                          return CircleAvatar(
                            backgroundColor: Theme.of(context).primaryColor,
                            radius: 40,
                          );
                        },
                      ),
                      onTap: () {
                        showModalBottomSheet<void>(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              color: Theme.of(context).primaryColor,
                              height: 300,
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    "Choose profile image",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                          iconSize: 60,
                                          onPressed: () async {
                                            await _imageFromCamera();
                                          },
                                          icon: const Icon(Icons.camera_alt)),
                                      IconButton(
                                          iconSize: 60,
                                          onPressed: () async {
                                            await _imageFromGallery();
                                          },
                                          icon:
                                              const Icon(Icons.photo_library)),
                                    ],
                                  ),
                                  _image == null
                                      ? const CircularProgressIndicator()
                                      : Image.file(
                                          _image!,
                                          height: 100,
                                        ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            upload(_image!);
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Submit")),
                                      OutlinedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Cancel",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                    Divider(
                      color: Colors.white.withOpacity(0.5),
                    ),
                    FutureBuilder<UserDetails>(
                      future: futureProfile,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          email = snapshot.data!.user!.email != null
                              ? "${snapshot.data!.user!.email}"
                              : "NA";
                          balance = snapshot.data!.balance != null
                              ? "${snapshot.data!.balance}"
                              : "NA";
                        } else if (snapshot.hasError) {
                          return Text("${snapshot.error}");
                        }
                        return Column(
                          children: [
                            Text(email),
                            const SizedBox(height: 10),
                            Text("Rs." + balance),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          constraints: BoxConstraints(
              minHeight: (MediaQuery.of(context).size.height * 0.625)),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            color: Theme.of(context).accentColor,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Text(
                "My Information",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Divider(
                color: Colors.black.withOpacity(0.5),
              ),
              FutureBuilder<UserDetails>(
                future: futureProfile,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isVerified == false) {
                      return TextButton(
                          style: Theme.of(context).textButtonTheme.style,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const KYC()),
                            );
                          },
                          child: const Text(
                            "Verify KYC",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ));
                    } else {
                      var phone = snapshot.data!.phone != null
                          ? "${snapshot.data!.phone}"
                          : "NA";
                      var address = snapshot.data!.address != null
                          ? "${snapshot.data!.address}"
                          : "NA";
                      var dob = snapshot.data!.dob != null
                          ? (snapshot.data!.dob).toString().substring(0, 10)
                          : "NA";
                      var citizenship = snapshot.data!.citizenship != null
                          ? "${snapshot.data!.citizenship}"
                          : "NA";
                      var citizenshipProof = snapshot.data!.citizenshipProof !=
                              null
                          ? "http://10.0.2.2:90/${snapshot.data!.citizenshipProof}"
                          : 'https://picsum.photos/250?image=9';
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text("Phone Number: "),
                                  Text(
                                    phone,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  const Text("Address: "),
                                  Text(
                                    address,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  const Text("Date of Birth: "),
                                  Text(
                                    dob,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Row(
                                children: [
                                  const Text("Citizenship: "),
                                  Text(
                                    citizenship,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Center(
                                child: Image.network(citizenshipProof),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  }
                  return const CircularProgressIndicator();
                },
              ),
              const SizedBox(
                height: 16,
              ),
              FutureBuilder<Review>(
                future: futureReview,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    ratingNo = double.parse(snapshot.data!.rating!);
                    comment = snapshot.data!.comment!;
                    var updatedDate = snapshot.data!.updated_at!;
                    var reviewDate = (DateTime.parse(updatedDate));
                    DateFormat formatter = DateFormat("yyyy-MM-dd");
                    updatedAt = formatter.format(reviewDate);
                  } else if (snapshot.hasError) {
                    return Column(
                      children: [
                        // Text('$snapshot.error'),
                        TextButton(
                            onPressed: () {
                              showModalBottomSheet<void>(
                                context: context,
                                isScrollControlled: true,
                                builder: (BuildContext context) {
                                  return Padding(
                                    padding: MediaQuery.of(context).viewInsets,
                                    child: Container(
                                      color: Theme.of(context).primaryColor,
                                      height: 300,
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 20),
                                      child: Form(
                                        key: _formKey,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text(
                                              "Add a Review",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: Colors.white),
                                            ),
                                            const SizedBox(height: 10),
                                            TextFormField(
                                              decoration: InputDecoration(
                                                hintText: "Add a Comment",
                                                errorBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.red)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .white)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  borderSide: const BorderSide(
                                                      color: Color(0xFF105F49)),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                ),
                                              ),
                                              validator: MultiValidator([
                                                RequiredValidator(
                                                    errorText:
                                                        "* Required Field")
                                              ]),
                                              minLines: 2,
                                              maxLines: 3,
                                              onSaved: (value) {
                                                newComment = value!;
                                              },
                                            ),
                                            RatingBar.builder(
                                              initialRating: 1,
                                              minRating: 1,
                                              direction: Axis.horizontal,
                                              allowHalfRating: true,
                                              itemCount: 5,
                                              itemPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4.0),
                                              itemBuilder: (context, _) =>
                                                  const Icon(
                                                Icons.star,
                                                color: Colors.amber,
                                              ),
                                              onRatingUpdate: (Rating) {
                                                newRating = Rating;
                                              },
                                            ),
                                            TextButton(
                                                onPressed: () async {
                                                  if (_formKey.currentState!
                                                      .validate()) {
                                                    _formKey.currentState!
                                                        .save();
                                                    String? newreview =
                                                        await newReview(
                                                            newComment,
                                                            newRating);
                                                    if (newreview == 'true') {
                                                      _formKey.currentState!
                                                          .reset();
                                                      Navigator.pop(context);
                                                      setState(() {
                                                        futureReview =
                                                            HttpConnectUser()
                                                                .getReview();
                                                      });
                                                    } else {
                                                      Navigator.pop(context);
                                                    }
                                                  }
                                                },
                                                child: const Text("Submit")),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                            child: const Text("Add Review")),
                      ],
                    );
                  }
                  return Card(
                    margin: const EdgeInsets.all(10),
                    color: Colors.white,
                    elevation: 2,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text('My Review',
                              style: Theme.of(context).textTheme.bodyText2,
                              textAlign: TextAlign.center),
                          subtitle: Text(
                            updatedAt,
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.6)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RatingBarIndicator(
                                    itemBuilder: (context, index) {
                                      return const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      );
                                    },
                                    itemCount: 5,
                                    rating: ratingNo,
                                    itemSize: 20),
                                const SizedBox(height: 16),
                                Text(
                                  comment,
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.8)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextButton(
                  onPressed: () async {
                    await removeToken();
                    Navigator.pushReplacementNamed(context, 'login');
                    MotionToast.success(
                      description: const Text("Logout Successfully"),
                      title: const Text(
                        "success",
                        style: TextStyle(fontSize: 16, color: Colors.green),
                      ),
                      toastDuration: const Duration(seconds: 3),
                    ).show(context);
                  },
                  style: Theme.of(context).textButtonTheme.style,
                  child: const Text("Logout")),
            ],
          ),
        ),
      ),
    );
  }
}
