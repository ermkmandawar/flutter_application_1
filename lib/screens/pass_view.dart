import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/db/pass_db.dart';
import 'package:flutter_application_1/model/pass_model.dart';
import 'package:flutter_application_1/screens/edit_pass.dart';

class PasswordViewer extends StatefulWidget {
  final String title;
  final String username;
  final String password;
  final int index;
  final Function refresh;
  final int id;

  const PasswordViewer(
      {Key? key,
      required this.title,
      required this.username,
      required this.password,
      required this.index,
      required this.id,
      required this.refresh})
      : super(key: key);

  @override
  _PasswordViewerState createState() => _PasswordViewerState();
}

class _PasswordViewerState extends State<PasswordViewer> {
  late List<Password> passwords = [];
  bool isLoading = false;
  bool isVisible = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 2,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.blueAccent,
          ),
        ),
        actions: [
          IconButton(
              tooltip: 'Edit',
              onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditTask(
                          title: widget.title,
                          username: widget.username,
                          password: widget.password,
                          id: widget.id,
                          refresh: widget.refresh),
                    ),
                  ),
              icon: const Icon(Icons.edit, color: Colors.blueAccent)),
          IconButton(
              onPressed: () {
                // print(passwords[0].password);
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return CupertinoAlertDialog(
                      title: const Text(
                        "Are you sure ?",
                      ),
                      content: const Text(
                        "Do you want to delete this password?",
                      ),
                      actions: <CupertinoDialogAction>[
                        CupertinoDialogAction(
                          isDestructiveAction: true,

                          child: const Text(
                            "Yes",
                          ),
                          onPressed: () {
                            PasswordDatabase.instance
                                .delete(passwords[widget.index].id!);
                            widget.refresh();
                            Navigator.of(context).pop();
                            Navigator.pop(context);
                          },
                        ),
                        CupertinoDialogAction(
                          isDefaultAction: true,
                          child: const Text(
                            "No",
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              tooltip: 'Delete',
              icon: const Icon(
                Icons.delete_rounded,
                color: Colors.red,
              )),
        ],
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 0.0, 10.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10.0,),
            Row(
              children: const [

                Text(
                  'Website Name :',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              widget.title,
              style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                const Text(
                  'Username :',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600),
                ),
                IconButton(
                  onPressed: () =>
                      Clipboard.setData(ClipboardData(text: widget.username))
                          .then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Username/Email Copied"),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }),
                  icon: const Icon(
                    Icons.copy_rounded,
                  ),
                  tooltip: 'Copy',
                ),
              ],
            ),
            const SizedBox(
              height: 5.0,
            ),
            Text(
              widget.username == '' ? 'No Username' : widget.username,
              style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                const Text(
                  'Password :',
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600),
                ),
                IconButton(
                  onPressed: () =>
                      Clipboard.setData(ClipboardData(text: widget.password))
                          .then((_) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Password Copied"),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }),
                  icon: const Icon(
                    Icons.copy_rounded,
                  ),
                  tooltip: 'Copy',
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  icon: Icon(
                    isVisible
                        ? Icons.visibility_off_rounded
                        : Icons.visibility_rounded,
                  ),
                  tooltip: isVisible ? 'Hide' : 'Show',
                )
              ],
            ),
            const SizedBox(
              height: 5.0,
            ),
            Visibility(
              visible: isVisible,
              child: Text(
                widget.password,
                style: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Text(
              isVisible ? '' : '*' * widget.password.length,
              style: const TextStyle(
                fontSize: 26.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
