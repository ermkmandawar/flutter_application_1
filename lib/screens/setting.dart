import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/device_details.dart';
import 'package:flutter_application_1/screens/about.dart';
import 'package:flutter_application_1/screens/privacy_policy.dart';
import 'package:flutter_application_1/screens/security.dart';
import 'package:flutter_application_1/screens/t_and_c.dart';
import 'package:flutter_application_1/utils/theme.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/theme_notifier.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: true);

    return Scaffold(
      // backgroundColor:
      //     themeProvider.getTheme == darkTheme ? null : const Color(0xFFF2F1F7),
      appBar: AppBar(
        elevation: 0.0,

        // backgroundColor:
        //     themeProvider.getTheme == darkTheme ? null : Colors.white,
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
          'Settings',
        ),
        centerTitle: true,
        // systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 230.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 10.0,
                ),
                Card(
                  elevation: 0,
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
                              CupertinoIcons.padlock_solid,
                              color: CupertinoColors.activeOrange,
                              size: 30.0,
                            ),
                            title: const Text(
                              'Security',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: const Icon(CupertinoIcons.forward),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SecurityScreen(),
                                ),
                              );
                            },
                          ),
                          const Divider(
                            height: 0,
                            indent: 60,
                          ),
                          ListTile(
                            // leading: const Icon(
                            //   CupertinoIcons.moon_circle_fill,
                            //   color: themeProvider.getTheme == darkTheme
                            //       ? Colors.white
                            //       : Colors.black,
                            //   size: 30.0,
                            // ),
                            isThreeLine: true,
                            subtitle: const Text(
                                'By default its disable, switch to dark theme by changing switch'),
                            leading: themeProvider.getTheme == darkTheme
                                ? const Icon(
                                    CupertinoIcons.sun_max_fill,
                                    color: CupertinoColors.systemYellow,
                                  )
                                : const Icon(
                                    CupertinoIcons.moon_circle_fill,
                                    color: CupertinoColors.black,
                                  ),
                            title: const Text(
                              'Dark Mode',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: CupertinoSwitch(
                              // trackColor: Colors.black,
                              value: themeProvider.getTheme == darkTheme,
                              onChanged: (d) {
                                themeProvider.changeTheme();
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
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
                            leading: const Icon(
                              CupertinoIcons.doc_text_fill,
                              color: CupertinoColors.systemIndigo,
                              size: 30.0,
                            ),
                            title: const Text(
                              'Privacy Policy',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: const Icon(CupertinoIcons.forward),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PrivacyPolicy(),
                                ),
                              );
                            },
                          ),
                          const Divider(
                            height: 0,
                            indent: 60,
                          ),
                          ListTile(
                            leading: const Icon(
                              CupertinoIcons.text_bubble_fill,
                              color: CupertinoColors.systemTeal,
                              size: 30,
                            ),
                            title: const Text(
                              "Terms & Conditions",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: const Icon(CupertinoIcons.forward),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const Terms(),
                                ),
                              );
                            },
                          ),
                          const Divider(
                            height: 0,
                            indent: 60,
                          ),
                          ListTile(
                            leading: const Icon(
                              CupertinoIcons.exclamationmark_square_fill,
                              color: CupertinoColors.activeGreen,
                              size: 30.0,
                            ),
                            title: const Text(
                              'About',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: const Icon(CupertinoIcons.forward),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const AboutScreen(),
                                ),
                              );
                            },
                          ),
                          const Divider(
                            height: 0,
                            indent: 60,
                          ),
                          ListTile(
                            leading: const Icon(
                              CupertinoIcons.device_phone_portrait,
                              color: CupertinoColors.systemPurple,
                              size: 30.0,
                            ),
                            title: const Text(
                              'Device info',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: const Icon(CupertinoIcons.forward),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DeviceDetail(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 10,
                        right: 140,
                        child: Container(
                          padding: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Shimmer.fromColors(
                              child: const Text(
                                'New Feature',
                                style: TextStyle(fontSize: 8),
                                textAlign: TextAlign.center,
                              ),
                              baseColor: Colors.black,
                              highlightColor: Colors.white),
                        ),
                      ),
                      Column(
                        children: [
                          ListTile(
                            leading: const Icon(
                              CupertinoIcons.square_arrow_down_fill,
                              color: CupertinoColors.link,
                              size: 30.0,
                            ),
                            title: const Text(
                              'Check for update',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: const Icon(CupertinoIcons.forward),
                            onTap: () {
                              showCupertinoDialog(
                                  context: context,
                                  builder: (context) => _updateDialog(context));
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(2.0),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            // borderRadius: BorderRadius.circular(3),
                          ),
                          child: const Text(
                            "You can't change this!",
                            style: TextStyle(color: Colors.white, fontSize: 8),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          ListTile(
                            leading: const Icon(
                              CupertinoIcons.app_badge_fill,
                              color: CupertinoColors.systemRed,
                              size: 30.0,
                            ),
                            title: const Text(
                              'Notification',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: CupertinoSwitch(
                              value: true,
                              onChanged: (bool value) {},
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Stack(
                    children: <Widget>[
                      Column(
                        children: const [
                          ListTile(
                            leading: Icon(
                              CupertinoIcons.cloud_upload_fill,
                              color: CupertinoColors.systemTeal,
                              size: 30.0,
                            ),
                            title: Text(
                              'Backup to drive',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: Text(
                              'Coming Soon!',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                ),
                const Center(
                  child: Text('version: 1.0.0+release'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _updateDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text("You've latest version of the app"),
      actions: <Widget>[
        CupertinoDialogAction(
            child: const Text('Close'),
            onPressed: () => Navigator.pop(context)),
      ],
    );
  }
}
