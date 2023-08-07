import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/editMasterPass/change_master_pass.dart';
import '../db/usr_db.dart';
import '../model/usr_info_model.dart';

class SecurityScreen extends StatefulWidget {
  const SecurityScreen({Key? key}) : super(key: key);

  @override
  _SecurityScreenState createState() => _SecurityScreenState();
}

class _SecurityScreenState extends State<SecurityScreen> {
  late List<User> users = [];

  bool isLoading = false;
  // bool loginRequired = true;
  String status = '';
  final String _message = 'When enabled, it will ask you to enter the master password every time you open the app.';

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
  void dispose() {
    UserDatabase.instance.close();

    super.dispose();
  }

  String getText() {
    if (users[0].loginRequired == true) {
      return 'Yes';
    } else {
      return 'No';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: const Text(
          'Security',
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.blueAccent,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
          Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Stack(
            children: <Widget>[
              Column(
                children: [
                  ListTile(
                    // isThreeLine:true,
                    //   subtitle: Text(_message),
                    leading: const Icon(
                      CupertinoIcons.cloud_upload_fill,
                      color: CupertinoColors.systemTeal,
                      size: 30.0,
                    ),
                    title: const Text(
                      'Require Login At Startup',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: CupertinoSwitch(
                      value: users[0].loginRequired,
                      onChanged: (value) {
                        setState(() {
                          // loginRequired = value;
                          UserDatabase.instance.update(User(
                              loginRequired: value,
                              masterpswd: users[0].masterpswd,
                              id: users[0].id));
                          refreshNotes();
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
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
                child: Text(
                  _message,
                  maxLines: 3,
                )),
          ],
        ),
        const SizedBox(
          height: 10.0,
        ),
        const Divider(
          height: 10.0,
          // color: Colors.grey,
        ),
        const SizedBox(
          height: 10.0,
        ),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Stack(
            children: <Widget>[
              Column(
                children:  [
                ListTile(
                  onTap: () =>
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) => const ChangeMasterPassScreen(),),),
                  leading: const Icon(
                  CupertinoIcons.padlock_solid,
                  color: CupertinoColors.destructiveRed,
                  size: 30.0,
                ),
                title: const Text(
                  'Change Master Password',
                  style:  TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: const Icon(CupertinoIcons.forward),
              ),
            ],
          ),
          ],
        ),
      ),
      ],
    ),)
    ,
    );
  }
}
