import 'package:flutter/material.dart';
import 'package:flutter_application_1/getStarted/second_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
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
                height: 8.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Personal Manager',
                  style: GoogleFonts.lato(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              const Spacer(),
              Lottie.asset('assets/anim/getstart.json'),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                'Free, Fast, Simple & Secure Password Manager',
                style: GoogleFonts.lato(
                  textStyle: const TextStyle(
                      fontSize: 20.0, fontWeight: FontWeight.w500),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Welcome to the best free password manager you can use this app. It is 100% free you can add unlimited number of passwords with ZERO ADS. Store all of your passwords securely. \nEnjoy !',
                  style: TextStyle(fontSize: 14.0, height: 1.5),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const SecondScreen())),
                    child: Container(
                      height: 60.0,
                      width: MediaQuery.of(context).size.width - 70.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: const Color(0xff2d6cdf)),
                      child: Center(
                        child: Text(
                          'GET STARTED',
                          style: GoogleFonts.lato(
                              textStyle: const TextStyle(fontSize: 24.0,color: Colors.white, letterSpacing: 1.1,)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
