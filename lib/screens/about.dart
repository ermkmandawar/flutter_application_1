import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/theme_notifier.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  final Uri _gitHuburl = Uri.parse('https://github.com/ermkmandawar');
  final Uri _instaUrl = Uri.parse('https://instagram.com/mk_mandawar');
  final Uri _linkUrl = Uri.parse('https://linkedin.com/in/mkmandawar');

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: true);
    return Scaffold(
      // backgroundColor: const Color(0xFFE9EEF4),
      appBar: CupertinoNavigationBar(
        backgroundColor:
            themeProvider.getTheme == darkTheme ? Colors.black : null,
        middle: Text(
          'About',
          style: TextStyle(
              color: themeProvider.getTheme == darkTheme
                  ? Colors.white
                  : Colors.black),
        ),
        previousPageTitle: 'Settings',
        brightness: Brightness.dark,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 300),
              child: Column(
                children: <Widget>[
                  const Text(
                    "Managing your passwords is very important and using secure passwords for your accounts is compulsory. \n\nBut it can be hard to remember passwords and think of secure passwords, but we have solution for that problem, introducing MyPasswords App.\n\nMyPasswords App is a Free, Secure, Simple and Offline Password Manager which can help you to store all of your passwords securely and generate secure passwords for your accounts.",
                    style: TextStyle(
                      fontSize: 15,
                      height: 1.5,
                      letterSpacing: 1,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 100.0,
                  ),
                  // Wrap(
                  //   direction: Axis.horizontal,
                  //   children: <Widget>[
                  //     CupertinoButton(
                  //       child: const Text('Privacy'),
                  //       onPressed: () {
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (context) => const PrivacyPolicy(),
                  //           ),
                  //         );
                  //       },
                  //       color: CupertinoColors.activeBlue,
                  //     ),
                  //     const SizedBox(
                  //       width: 5,
                  //     ),
                  //     CupertinoButton(
                  //       child: const Text('T&C'),
                  //       onPressed: () {
                  //         Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //             builder: (context) => const Terms(),
                  //           ),
                  //         );
                  //       },
                  //       color: CupertinoColors.inactiveGray,
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 50.0,
                  // ),
                  const Text('Follow us'),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Wrap(
                    direction: Axis.horizontal,
                    children: <Widget>[
                      IconButton(
                        onPressed: _lauchGithub,
                        icon: const FaIcon(
                          FontAwesomeIcons.githubSquare,
                          color: CupertinoColors.darkBackgroundGray,
                          semanticLabel: 'Github',
                          size:40.0,
                        ),
                      ),
                      IconButton(
                        onPressed: _lauchInsta,
                        icon: const FaIcon(
                          FontAwesomeIcons.instagramSquare,
                          color: CupertinoColors.systemPink,
                          semanticLabel: 'Instagram',
                          size: 40.0,
                        ),
                      ),
                      IconButton(
                        onPressed: _lauchLinkedIn,
                        icon: const FaIcon(
                          FontAwesomeIcons.linkedin,
                          color: CupertinoColors.activeBlue,
                          semanticLabel: 'LinkedIn',
                          size: 40.0,
                        ),
                      ),
                    ],
                  ),
                ],
              )),
        ),
      ),
    );
  }

  void _lauchGithub() async {
    if (!await launchUrl(_gitHuburl)) throw 'Could not launch $_gitHuburl';
  }

  void _lauchInsta() async {
    if (!await launchUrl(_instaUrl)) throw 'Could not launch $_instaUrl';
  }

  void _lauchLinkedIn() async {
    if (!await launchUrl(_linkUrl)) throw 'Could not launch $_linkUrl';
  }
}
