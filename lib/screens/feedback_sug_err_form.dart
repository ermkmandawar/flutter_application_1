import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/theme.dart';
import '../utils/theme_notifier.dart';

class FeedSugErrForm extends StatefulWidget {
  const FeedSugErrForm({Key? key}) : super(key: key);

  @override
  State<FeedSugErrForm> createState() => _FeedSugErrFormState();
}

class _FeedSugErrFormState extends State<FeedSugErrForm> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();

  String status = '';

  sendDetails() {
    FirebaseFirestore.instance.collection('Feedback').doc().set({
      "Name": name.text,
      "Email": email.text,
      "title": title.text,
      "description": desc.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
          color: CupertinoColors.systemBlue,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Feedback Form',
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 230),
            child: Column(
              children: [
                CupertinoTextField(
                  decoration: BoxDecoration(
                    color: themeProvider.getTheme == darkTheme
                        ? const Color(0xff424242)
                        : Colors.white,
                    border: Border.all(width: 0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  controller: name,
                  placeholder: 'Name',
                  prefix: const Icon(CupertinoIcons.person),
                  padding: const EdgeInsets.fromLTRB(15.0, 15, 15.0, 10),
                  showCursor: true,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                CupertinoTextField(
                  decoration: BoxDecoration(
                    color: themeProvider.getTheme == darkTheme
                        ? const Color(0xff424242)
                        : Colors.white,
                    border: Border.all(width: 0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  controller: email,
                  placeholder: 'Email',
                  prefix: const Icon(CupertinoIcons.envelope),
                  padding: const EdgeInsets.fromLTRB(15.0, 15, 15.0, 10),
                  showCursor: true,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                CupertinoTextField(
                  decoration: BoxDecoration(
                    color: themeProvider.getTheme == darkTheme
                        ? const Color(0xff424242)
                        : Colors.white,
                    border: Border.all(width: 0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  controller: title,
                  placeholder: 'Title',
                  prefix: const Icon(CupertinoIcons.text_cursor),
                  padding: const EdgeInsets.fromLTRB(15.0, 15, 15.0, 10),
                  showCursor: true,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                CupertinoTextField(
                  decoration: BoxDecoration(
                    color: themeProvider.getTheme == darkTheme
                        ? const Color(0xff424242)
                        : Colors.white,
                    border: Border.all(width: 0.1),
                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                  controller: desc,
                  minLines: null,
                  maxLines: null,
                  expands: true,
                  placeholder: 'Description',
                  prefix: const Icon(CupertinoIcons.textformat),
                  padding: const EdgeInsets.fromLTRB(15.0, 15, 15.0, 10),
                  showCursor: true,
                ),
                const SizedBox(
                  height: 15.0,
                ),
                CupertinoButton.filled(
                  child: const Text('Send'),
                  onPressed: () {
                    if (name.text == '' &&
                        email.text == '' &&
                        title.text == '' &&
                        desc.text == '') {
                      setState(() {
                        status = "All Fields Are Required";
                      });
                    } else if (email.text == '' || desc.text == '') {
                      setState(() {
                        status = "Email and description are required";
                      });
                    } else {
                      sendDetails();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Feedback sent successfully..."),
                          duration: Duration(seconds: 1),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      status,
                      style: const TextStyle(
                          color: CupertinoColors.systemRed, fontSize: 14.0),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
