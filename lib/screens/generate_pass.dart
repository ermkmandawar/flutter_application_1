import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Generator extends StatefulWidget {
  const Generator({Key? key}) : super(key: key);

  @override
  _PasswordGeneratoeState createState() => _PasswordGeneratoeState();
}

class _PasswordGeneratoeState extends State<Generator> {
  String _password = 'P@sSwoRd@123';
  double length = 6;
  bool numbersRequired = true;
  bool symbolsRequired = true;

  String _randomString(double length) {
    int _length = length.toInt();
    var rand = Random();
    var codeUnits = List.generate(_length, (index) {
      return rand.nextInt(33) + 89;
    });

    return String.fromCharCodes(codeUnits);
  }

  String generateRandomString(double len) {
    int _length = length.toInt();
    var r = Random.secure();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz';
    const _charsWithSymbols =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz!@#%^&*()[]{};:",./<>?`~';
    const _charsWithNumbers =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    const _charsWithEvery =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz!@#%^&*()[]{};:",./<>?`~1234567890';

    return List.generate(
        _length,
        (index) => symbolsRequired == true && numbersRequired == false
            ? _charsWithSymbols[r.nextInt(_charsWithSymbols.length)]
            : numbersRequired == true && symbolsRequired == false
                ? _charsWithNumbers[r.nextInt(_charsWithNumbers.length)]
                : numbersRequired == true && symbolsRequired == true
                    ? _charsWithEvery[r.nextInt(_charsWithEvery.length)]
                    : _chars[r.nextInt(_chars.length)]).join();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xff151922),
      appBar: AppBar(
        elevation: 0.0,
        // backgroundColor: const Color(0xff151922),
        title: const Text(
          'Password Generator',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
          color: Colors.blue,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 10.0,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(24.0, 0.0, 10.0, 0.0),
            child: Text(
              'Generated Password',
              style: TextStyle(
                  // color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width - 50.0,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(7.0),
                  ),
                  // boxShadow: [
                  //   BoxShadow(
                  //     offset: Offset(2, 2),
                  //     blurRadius: 12,
                  //     color: Color.fromRGBO(0, 0, 0, 0.16),
                  //   )
                  // ],
                  color: CupertinoColors.black,
                ),
                child: Center(
                  child: Text(
                    _password,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24.0, 0.0, 10.0, 0.0),
            child: Text(
              'Length: $length',
              style: const TextStyle(
                  // color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.0),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 0.0, 10.0, 0.0),
            child: Slider(
              value: length,
              onChanged: (newLength) {
                setState(() {
                  length = newLength;
                });
              },
              divisions: 15,
              label: '$length',
              activeColor: Colors.red,
              // inactiveColor: Colors.red,
              min: 0.0,
              max: 30.0,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(23.0, 0.0, 23.0, 0.0),
            child: Text(
              'Settings',
              style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(23.0, 0.0, 23.0, 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 10.0,
                ),
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Stack(
                    children: [
                      // Positioned(
                      //   top: 65,
                      //   left: 150,
                      //   child: Container(
                      //     padding: const EdgeInsets.all(2.0),
                      //     decoration: BoxDecoration(
                      //       color: Colors.red,
                      //       borderRadius: BorderRadius.circular(3),
                      //     ),
                      //     child: const Text(
                      //       'Coming Soon',
                      //       style: TextStyle(color: Colors.white, fontSize: 8),
                      //       textAlign: TextAlign.center,
                      //     ),
                      //   ),
                      // ),
                      Column(
                        children: [
                          ListTile(
                            leading: const Icon(
                              CupertinoIcons.keyboard,
                              color: CupertinoColors.activeOrange,
                              size: 30.0,
                            ),
                            title: const Text(
                              'Include Symbols',
                            ),
                            trailing: CupertinoSwitch(
                              value: symbolsRequired,
                              onChanged: (value) {
                                setState(() {
                                  symbolsRequired = value;
                                });
                              },
                            ),
                            onTap: () {},
                          ),
                          const Divider(
                            height: 0,
                            indent: 60,
                          ),
                          ListTile(
                            leading: const Icon(
                              CupertinoIcons.textformat_123,
                              color: CupertinoColors.systemPurple,
                              size: 30,
                            ),
                            title: const Text(
                              "Include Numbers",
                            ),
                            trailing: CupertinoSwitch(
                              value: numbersRequired,
                              onChanged: (value) {
                                setState(() {
                                  numbersRequired = value;
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
                  height: 20,
                ),
                Center(
                  child: CupertinoButton.filled(
                      child: const Text('Generate Password'),
                      onPressed: () {
                        setState(() {
                          _password = generateRandomString(length);
                        });
                      }),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: CupertinoButton(
                    child: const Text('Copy to clipboard'),
                    color: CupertinoColors.systemGrey,
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: _password)).then((_) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Password Copied"),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          // GestureDetector(
          //   onTap: () {
          //     setState(() {
          //       _password = generateRandomString(length);
          //     });
          //   },
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Container(
          //         height: 60.0,
          //         width: MediaQuery.of(context).size.width - 50.0,
          //         decoration: BoxDecoration(
          //             gradient: const LinearGradient(
          //                 begin: Alignment.topLeft,
          //                 end: Alignment.bottomRight,
          //                 colors: [Color(0xff024DE2), Color(0xff001F5C)]),
          //             borderRadius: BorderRadius.circular(8.0)),
          //         child: const Center(
          //           child: Text(
          //             'Generate Password',
          //             textAlign: TextAlign.center,
          //             style: TextStyle(
          //                 color: Colors.white,
          //                 fontWeight: FontWeight.bold,
          //                 fontSize: 24.0),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          // const SizedBox(
          //   height: 8.0,
          // ),
          // GestureDetector(
          //   onTap: () {
          //     Clipboard.setData(ClipboardData(text: _password)).then((_) {
          //       ScaffoldMessenger.of(context).showSnackBar(
          //         const SnackBar(
          //           content: Text("Password Copied"),
          //           duration: Duration(seconds: 1),
          //         ),
          //       );
          //     });
          //   },
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Container(
          //         height: 60.0,
          //         width: MediaQuery.of(context).size.width - 50.0,
          //         decoration: BoxDecoration(
          //             color: const Color(0xff344055),
          //             borderRadius: BorderRadius.circular(8.0)),
          //         child: const Center(
          //           child: Text(
          //             'Copy To Clipboard',
          //             textAlign: TextAlign.center,
          //             style: TextStyle(
          //                 color: Colors.white,
          //                 fontWeight: FontWeight.bold,
          //                 fontSize: 24.0),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
