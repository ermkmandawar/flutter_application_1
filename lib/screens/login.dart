import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../db/usr_db.dart';
import '../encrypter/encrypter.dart';
import '../model/usr_info_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController masterPassword = TextEditingController();

  late List<User> users;
  bool isLoading = false;
  String status = '';

  bool passwordVisible = false;

  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  @override
  void dispose() {
    UserDatabase.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    users = await UserDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24.0, 100.0, 24.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login to ',
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                          fontSize: 24, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Personal Manager',
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.w700),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    'assets/images/accent.png',
                    width: 99,
                    height: 4,
                  ),
                  Lottie.asset('assets/anim/password.json'),
                ],
              ),
              const SizedBox(
                height: 48.0,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(
                  'Enter Master Password',
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Form(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        // color: const Color(0xff94959b),
                        borderRadius: BorderRadius.circular(14.0),
                        border: Border.all(width: 1),
                      ),
                      child: TextFormField(
                        controller: masterPassword,
                        onFieldSubmitted: (value) {
                          masterPassword.text = value;
                        },
                        obscureText: !passwordVisible,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.password),
                          hintText: 'Type password',
                          hintStyle: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                          suffixIcon: IconButton(
                            splashRadius: 1,
                            icon: Icon(passwordVisible
                                ? CupertinoIcons.eye
                                : CupertinoIcons.eye_slash),
                            onPressed: togglePassword,
                          ),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      if (masterPassword.text ==
                          Encrypt.instance.encryptOrDecryptText(
                              users[0].masterpswd, false)) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const HomePage()));
                      } else {
                        setState(() {
                          status = 'Incorrect Password';
                        });
                      }
                    },
                    icon: const Icon(
                      CupertinoIcons.arrow_right_circle_fill,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    status,
                    style: GoogleFonts.lato(
                      textStyle: const TextStyle(fontSize: 16.0, color: Colors.red),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
