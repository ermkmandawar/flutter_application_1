import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../db/usr_db.dart';
import '../encrypter/encrypter.dart';
import '../model/usr_info_model.dart';


class NewMasterPassScreen extends StatefulWidget {
  const NewMasterPassScreen({Key? key}) : super(key: key);

  @override
  _NewMasterPassScreenState createState() => _NewMasterPassScreenState();
}

class _NewMasterPassScreenState extends State<NewMasterPassScreen> {
  TextEditingController newMasterPassword = TextEditingController();
  String status = '';

  late List<User> users;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.users = await UserDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        elevation: 0.0,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.blueAccent,
            )), systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Create New Password',
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Text(
                'Your new password must be different from previous used passwords.',
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.0)),
            const SizedBox(
              height: 20.0,
            ),
            const Text(
              'Enter New Password',
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
                controller: newMasterPassword,
                onSubmitted: (value) {
                  newMasterPassword.text = value;
                },
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.black, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(
                        color: Colors.white10,
                        width: 2.0,
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.password_rounded,
                      color: Colors.blueAccent,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    hintText: 'Enter New Password',
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              onTap: () {
                if (newMasterPassword.text != '') {
                  var user = User(
                      loginRequired: users[0].loginRequired,
                      masterpswd: Encrypt.instance.encryptOrDecryptText(newMasterPassword.text, true),
                      id: users[0].id);
                  UserDatabase.instance.update(user);
                  Navigator.pop(context);
                } else if (newMasterPassword.text == '') {
                  setState(() {
                    status = "Password Can't Be Empty";
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
                      'Reset Password',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  status,
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}