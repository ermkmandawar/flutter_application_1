import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:google_fonts/google_fonts.dart';

import '../db/usr_db.dart';
import '../encrypter/encrypter.dart';
import '../model/usr_info_model.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final String message =
      "Please remember this password. It will be ask to access the app";
  bool requiredLogin = true;
  TextEditingController masterPassword = TextEditingController();
  final String _message =
      'When enabled, it will ask you to enter the master password every time you open the app.';

  bool passwordVisible = true;

  String warning = '';

  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  String getText() {
    if (requiredLogin == true) {
      return 'Yes';
    } else {
      return 'No';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Set master password',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Text(
                message,
                style: const TextStyle(
                    color: Colors.red,
                    // fontWeight: FontWeight.bold,
                    fontSize: 16.0),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                maxLength: 60,
                controller: masterPassword,
                onFieldSubmitted: (value) {
                  masterPassword.text = value;
                },
                obscureText: !passwordVisible,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon: const Icon(Icons.password),
                  hintText: 'Type password',
                  hintStyle: GoogleFonts.lato(
                    textStyle: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  suffixIcon: IconButton(
                    splashRadius: 1,
                    icon: Icon(passwordVisible
                        ? CupertinoIcons.eye
                        : CupertinoIcons.eye_slash),
                    onPressed: togglePassword,
                  ),
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    warning,
                    style: const TextStyle(
                        color: CupertinoColors.systemRed, fontSize: 14.0),
                  ),
                ],
              ),
              const SizedBox(
                height: 30.0,
              ),
              Card(
                // elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Stack(
                  children: <Widget>[
                    Column(
                      children: [
                        ListTile(
                          isThreeLine: true,
                          subtitle: Text(
                            _message,
                            style: GoogleFonts.lato(),
                          ),
                          leading: const Icon(
                            CupertinoIcons.lock_circle_fill,
                            color: CupertinoColors.systemOrange,
                            size: 30.0,
                          ),
                          title: Text(
                            'Login everytime',
                            style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          trailing: CupertinoSwitch(
                            value: requiredLogin,
                            onChanged: (value) {
                              setState(() {
                                requiredLogin = value;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      if (masterPassword.text == '') {
                        setState(() {
                          warning = "Master Password is required";
                        });
                      } else {
                        var user = User(
                            loginRequired: requiredLogin,
                            masterpswd: Encrypt.instance.encryptOrDecryptText(
                                masterPassword.text, true));
                        UserDatabase.instance.create(user);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const HomePage()));
                      }
                    },
                    icon: const Icon(
                      CupertinoIcons.arrow_right_circle_fill,
                      size: 60.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
