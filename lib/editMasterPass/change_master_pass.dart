import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../db/usr_db.dart';
import '../encrypter/encrypter.dart';
import '../model/usr_info_model.dart';
import 'create_new_master_pass.dart';


class ChangeMasterPassScreen extends StatefulWidget {
  const ChangeMasterPassScreen({Key? key}) : super(key: key);

  @override
  _ChangeMasterPassScreenState createState() => _ChangeMasterPassScreenState();
}

class _ChangeMasterPassScreenState extends State<ChangeMasterPassScreen> {
  TextEditingController masterPassword = TextEditingController();

  late List<User> users;
  bool isLoading = false;
  String status = '';

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    users = await UserDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text('Change Password'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.blueAccent,
          ),
        ), systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(
              height: 10.0,
            ),
            const Text(
                'Enter your current master password to change your master password.',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0)),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              'Enter Master Password',
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 5.0,
            ),
            SizedBox(
              height: 80.0,
              width: MediaQuery.of(context).size.width - 50.0,
              child: TextField(
                maxLength: 60,
                controller: masterPassword,
                onSubmitted: (value) {
                  masterPassword.text = value;
                },
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                          color: Colors.black,
                          width: 2.0
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.black,
                        width: 2.0,
                      ),
                    ),
                    prefixIcon: const Icon(CupertinoIcons.lock_fill,),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    hintText: 'Enter Master Password'),
              ),
            ),
            const SizedBox(height: 10.0),
            GestureDetector(
              onTap: () {
                if (masterPassword.text == Encrypt.instance.encryptOrDecryptText(users[0].masterpswd, false)) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (_) => const NewMasterPassScreen()));
                } else {
                  setState(() {
                    status = 'Incorrect Password';
                  });
                }
              },
              child: Container(
                height: 55.0,
                width: MediaQuery.of(context).size.width - 50.0,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Color(0xffD80320), Color(0xffFF0022)]),
                    borderRadius: BorderRadius.circular(8.0)),
                child: const Center(
                    child: Text(
                      'Done',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ),
            const SizedBox(height: 5.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  status,
                  style: TextStyle(color: Colors.red[900]),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}