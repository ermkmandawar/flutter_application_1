import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/db/pass_db.dart';
import 'package:flutter_application_1/encrypter/encrypter.dart';
import 'package:flutter_application_1/model/pass_model.dart';
import 'package:flutter_application_1/screens/add_pass.dart';
import 'package:flutter_application_1/screens/pass_view.dart';

class AllPassScreen extends StatefulWidget {
  const AllPassScreen({Key? key}) : super(key: key);

  @override
  _AllPassScreenState createState() => _AllPassScreenState();
}

class _AllPassScreenState extends State<AllPassScreen> {
  late List<Password> passwords = [];

  late int selectedIndex = -1;
  bool showMenu = false;
  bool isLoading = false;
  int weakPasswordCount = 0;
  int strongPasswordCount = 0;

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

  String weakPasswordCounter() {
    for (var password in passwords) {
      if (password.password.length < 8) {
        weakPasswordCount++;
      } else {}
    }
    return '$weakPasswordCount';
  }

  String strongPasswordCounter() {
    for (var password in passwords) {
      if (password.password.length >= 8) {
        strongPasswordCount++;
      } else {}
    }
    return '$strongPasswordCount';
  }

  Widget noPasswordsFound() {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 200.0,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              CupertinoIcons.keyboard_chevron_compact_down,
              size: 50.0,
              // color: Colors.white,
            ),
            Text(
              'No Passwords Added',
              style: TextStyle(
                  // color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SF'),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              "Click on the '+' icon to add",
              style: TextStyle(
                  // color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  //Swipe List Icons and Background

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          tooltip: 'Add new password',
          child: Container(
            width: 60,
            height: 60,
            child: const Icon(
              Icons.add,
              size: 35,
            ),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff0F4DF3),
            ),
          ),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AddTask(
                refershPasswords: refreshNotes,
              ),
            ),
          ),
        ),
        // backgroundColor: const Color(0xff151922),
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            const SliverAppBar(
              iconTheme: IconThemeData(
                color: CupertinoColors.systemBlue,
              ),
              centerTitle: true,
              // floating: true,
              pinned: true,
              // backgroundColor: Color(0xff151922),
              title: Text('My Passwords', style: TextStyle(fontSize: 30.0)),
              // systemOverlayStyle: SystemUiOverlayStyle.dark,
            ),
            SliverPadding(
              padding: const EdgeInsets.only(left: 14.0),
              sliver: SliverToBoxAdapter(
                child: Text(
                  'You Saved ${passwords.length} Passwords',
                  style: const TextStyle(
                    // color: Colors.white,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 10.0)),
            passwords.isEmpty
                ? SliverToBoxAdapter(
                    child: noPasswordsFound(),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate((buildContext, index) {
                      return Card(
                        // color: const Color.fromARGB(45, 255, 255, 255),
                        // shadowColor: const Color.fromARGB(84, 0, 0, 255),
                        child: ListTile(
                          leading: Text(
                            "${index + 1}.",
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                                // color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            // color: Colors.grey,
                          ),
                          title: Text(
                              Encrypt.instance.encryptOrDecryptText(
                                  passwords[index].title, false),
                              style: const TextStyle(
                                  // color: Colors.white,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.w500)),
                          subtitle: Text(
                            passwords[index].username == ''
                                ? 'No Username'
                                : Encrypt.instance.encryptOrDecryptText(
                                    passwords[index].username, false),
                            style: const TextStyle(
                                // color: Colors.grey,
                                fontWeight: FontWeight.normal),
                          ),
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => PasswordViewer(
                                      title: Encrypt.instance
                                          .encryptOrDecryptText(
                                              passwords[index].title, false),
                                      username: Encrypt.instance
                                          .encryptOrDecryptText(
                                              passwords[index].username, false),
                                      password: Encrypt.instance
                                          .encryptOrDecryptText(
                                              passwords[index].password, false),
                                      index: index,
                                      id: passwords[index].id!,
                                      refresh: refreshNotes))),
                        ),
                      );
                    }, childCount: passwords.length),
                  ),
          ],
        ));
  }
}
