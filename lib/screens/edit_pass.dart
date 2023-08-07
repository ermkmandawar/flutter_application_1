import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/db/pass_db.dart';
import 'package:flutter_application_1/encrypter/encrypter.dart';
import 'package:flutter_application_1/model/pass_model.dart';

class EditTask extends StatefulWidget {
  late final String title;
  late final String username;
  late final String password;
  late final int id;
  late final Function refresh;

  EditTask(
      {required this.title,
      required this.username,
      required this.password,
      required this.id,
      required this.refresh});

  @override
  _EditTaskState createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  TextEditingController title = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  late List<Password> passwords = [];
  bool isLoading = false;
  String tag = 'updated';

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
    FirebaseFirestore.instance.collection('Data').doc().set({
      "title": title.text,
      "username": username.text,
      "password": password.text,
      "tag": tag,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: false,
          title: const Text(
            'Edit Password',
          ),
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.blueAccent,
            ),
          ),
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 8.0,
              ),
              const Text(
                'Website Name',
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 5.0,
              ),
              SizedBox(
                height: 75.0,
                width: MediaQuery.of(context).size.width - 40.0,
                child: TextFormField(
                  maxLength: 60,
                  initialValue: widget.title,
                  onChanged: (value) {
                    title.text = value;
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.title,
                      size: 24,
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
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 5.0,
              ),
              SizedBox(
                height: 75.0,
                width: MediaQuery.of(context).size.width - 40.0,
                child: TextFormField(
                  maxLength: 60,
                  initialValue: widget.username,
                  onChanged: (value) {
                    username.text = value;
                  },
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.email,
                      size: 24,
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
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 5.0,
              ),
              SizedBox(
                height: 75.0,
                width: MediaQuery.of(context).size.width - 40.0,
                child: TextFormField(
                  obscureText: true,
                  maxLength: 60,
                  controller: password,
                  // initialValue: widget.password,
                  onChanged: (value) {
                    password.text = value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Type Password',
                    hintStyle: const TextStyle(color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.vpn_key,
                      size: 24,
                    ),
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
                    onPressed: () {

                      if (title.text == '' &&
                          username.text == '' &&
                          password.text == '') {
                        Navigator.pop(context);
                      } else if (title.text == '' && username.text == '') {
                        var p = Password(
                            title: Encrypt.instance
                                .encryptOrDecryptText(widget.title, true),
                            username: Encrypt.instance
                                .encryptOrDecryptText(widget.username, true),
                            password: Encrypt.instance
                                .encryptOrDecryptText(password.text, true),
                            id: widget.id);
                        PasswordDatabase.instance.update(p);
                        widget.refresh();
                        Navigator.pop(context);
                      } else if (title.text == '' && password.text == '') {
                        var p = Password(
                            title: Encrypt.instance
                                .encryptOrDecryptText(widget.title, true),
                            username: Encrypt.instance
                                .encryptOrDecryptText(username.text, true),
                            password: Encrypt.instance
                                .encryptOrDecryptText(widget.password, true),
                            id: widget.id);
                        PasswordDatabase.instance.update(p);
                        widget.refresh();
                        Navigator.pop(context);
                      } else if (username.text == '' && password.text == '') {
                        var p = Password(
                            title: Encrypt.instance
                                .encryptOrDecryptText(title.text, true),
                            username: Encrypt.instance
                                .encryptOrDecryptText(widget.username, true),
                            password: Encrypt.instance
                                .encryptOrDecryptText(widget.password, true),
                            id: widget.id);
                        PasswordDatabase.instance.update(p);
                        widget.refresh();
                        Navigator.pop(context);
                      } else if (username.text == '') {
                        var p = Password(
                            title: Encrypt.instance
                                .encryptOrDecryptText(title.text, true),
                            username: Encrypt.instance
                                .encryptOrDecryptText(widget.username, true),
                            password: Encrypt.instance
                                .encryptOrDecryptText(password.text, true),
                            id: widget.id);
                        PasswordDatabase.instance.update(p);
                        widget.refresh();
                        Navigator.pop(context);
                      } else if (title.text == '') {
                        var p = Password(
                            title: Encrypt.instance
                                .encryptOrDecryptText(widget.title, true),
                            username: Encrypt.instance
                                .encryptOrDecryptText(username.text, true),
                            password: Encrypt.instance
                                .encryptOrDecryptText(password.text, true),
                            id: widget.id);
                        PasswordDatabase.instance.update(p);
                        widget.refresh();
                        Navigator.pop(context);
                      } else if (password.text == '') {
                        var p = Password(
                            title: Encrypt.instance
                                .encryptOrDecryptText(title.text, true),
                            username: Encrypt.instance
                                .encryptOrDecryptText(username.text, true),
                            password: Encrypt.instance
                                .encryptOrDecryptText(widget.password, true),
                            id: widget.id);
                        PasswordDatabase.instance.update(p);
                        widget.refresh();
                        Navigator.pop(context);
                      } else {
                        var p = Password(
                            title: Encrypt.instance
                                .encryptOrDecryptText(title.text, true),
                            username: Encrypt.instance
                                .encryptOrDecryptText(username.text, true),
                            password: Encrypt.instance
                                .encryptOrDecryptText(password.text, true),
                            id: widget.id);
                        PasswordDatabase.instance.update(p);
                        widget.refresh();
                        Navigator.pop(context);
                      }
                      uploadData();
                    },
                    child: const Text(
                      'Save Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        // color: Colors.white,
                        fontSize: 24.0,
                        // fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              // GestureDetector(
              //   onTap: () {
              //     if (title.text == '' &&
              //         username.text == '' &&
              //         password.text == '') {
              //       Navigator.pop(context);
              //     } else if (title.text == '' && username.text == '') {
              //       var p = Password(
              //           title: Encrypt.instance
              //               .encryptOrDecryptText(widget.title, true),
              //           username: Encrypt.instance
              //               .encryptOrDecryptText(widget.username, true),
              //           password: Encrypt.instance
              //               .encryptOrDecryptText(password.text, true),
              //           id: widget.id);
              //       PasswordDatabase.instance.update(p);
              //       widget.refresh();
              //       Navigator.pop(context);
              //     } else if (title.text == '' && password.text == '') {
              //       var p = Password(
              //           title: Encrypt.instance
              //               .encryptOrDecryptText(widget.title, true),
              //           username: Encrypt.instance
              //               .encryptOrDecryptText(username.text, true),
              //           password: Encrypt.instance
              //               .encryptOrDecryptText(widget.password, true),
              //           id: widget.id);
              //       PasswordDatabase.instance.update(p);
              //       widget.refresh();
              //       Navigator.pop(context);
              //     } else if (username.text == '' && password.text == '') {
              //       var p = Password(
              //           title: Encrypt.instance
              //               .encryptOrDecryptText(title.text, true),
              //           username: Encrypt.instance
              //               .encryptOrDecryptText(widget.username, true),
              //           password: Encrypt.instance
              //               .encryptOrDecryptText(widget.password, true),
              //           id: widget.id);
              //       PasswordDatabase.instance.update(p);
              //       widget.refresh();
              //       Navigator.pop(context);
              //     } else if (username.text == '') {
              //       var p = Password(
              //           title: Encrypt.instance
              //               .encryptOrDecryptText(title.text, true),
              //           username: Encrypt.instance
              //               .encryptOrDecryptText(widget.username, true),
              //           password: Encrypt.instance
              //               .encryptOrDecryptText(password.text, true),
              //           id: widget.id);
              //       PasswordDatabase.instance.update(p);
              //       widget.refresh();
              //       Navigator.pop(context);
              //     } else if (title.text == '') {
              //       var p = Password(
              //           title: Encrypt.instance
              //               .encryptOrDecryptText(widget.title, true),
              //           username: Encrypt.instance
              //               .encryptOrDecryptText(username.text, true),
              //           password: Encrypt.instance
              //               .encryptOrDecryptText(password.text, true),
              //           id: widget.id);
              //       PasswordDatabase.instance.update(p);
              //       widget.refresh();
              //       Navigator.pop(context);
              //     } else if (password.text == '') {
              //       var p = Password(
              //           title: Encrypt.instance
              //               .encryptOrDecryptText(title.text, true),
              //           username: Encrypt.instance
              //               .encryptOrDecryptText(username.text, true),
              //           password: Encrypt.instance
              //               .encryptOrDecryptText(widget.password, true),
              //           id: widget.id);
              //       PasswordDatabase.instance.update(p);
              //       widget.refresh();
              //       Navigator.pop(context);
              //     } else {
              //       var p = Password(
              //           title: Encrypt.instance
              //               .encryptOrDecryptText(title.text, true),
              //           username: Encrypt.instance
              //               .encryptOrDecryptText(username.text, true),
              //           password: Encrypt.instance
              //               .encryptOrDecryptText(password.text, true),
              //           id: widget.id);
              //       PasswordDatabase.instance.update(p);
              //       widget.refresh();
              //       Navigator.pop(context);
              //     }
              //     uploadData();
              //   },
              //   child: Container(
              //     height: 60.0,
              //     width: MediaQuery.of(context).size.width - 40.0,
              //     decoration: BoxDecoration(
              //         color: const Color(0xff14279B),
              //         borderRadius: BorderRadius.circular(8.0)),
              //     child: const Center(
              //       child: Text(
              //         'Save Password',
              //         textAlign: TextAlign.center,
              //         style: TextStyle(
              //             color: Colors.white,
              //             fontSize: 24.0,
              //             fontWeight: FontWeight.bold),
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ));
  }
}
