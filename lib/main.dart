import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:flutter_application_1/screens/login.dart';
import 'package:flutter_application_1/utils/theme_notifier.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'db/usr_db.dart';
import 'firebase_options.dart';
import 'getStarted/first_Screen.dart';
import 'model/usr_info_model.dart';

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool themeBool = prefs.getBool("isDark") ?? false;
  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => ThemeProvider(isDark: themeBool),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late List<User> users = [];
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
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      return MaterialApp(
        theme: themeProvider.getTheme,
        debugShowCheckedModeBanner: false,
        title: 'Password Manager',
        // home:FirstScreen(),
        home: users.length == 0
            ? const FirstScreen()
            : users[0].loginRequired
                ? const LoginScreen()
                : const HomePage(),
      );
    });
  }
}
