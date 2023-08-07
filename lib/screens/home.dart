import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/helpers/circle_icons_grdt.dart';
import 'package:flutter_application_1/helpers/grid_view.dart';
import 'package:flutter_application_1/model/pass_model.dart';
import 'package:flutter_application_1/screens/add_pass.dart';
import 'package:flutter_application_1/screens/all_pass.dart';
import 'package:flutter_application_1/screens/feedback_sug_err_form.dart';
import 'package:flutter_application_1/screens/generate_pass.dart';
import 'package:flutter_application_1/screens/setting.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';

import '../db/pass_db.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Password> passwords = [];
  bool isLoading = false;

  Future refreshNotes() async {
    setState(() => isLoading = true);
    passwords = await PasswordDatabase.instance.readAllNotes();

    setState(() => isLoading = false);
  }

  // Future<void> _uploadPassToFire(List<Password> passwords) async {
  //   for (Password password in passwords) {
  //     await FirebaseFirestore.instance
  //         .collection('Passwords List')
  //         .doc()
  //         .set(password.toJson());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          SliverAppBar(
            expandedHeight: 150,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                "My Passwords",
                style: GoogleFonts.montserrat(
                  textStyle: const TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              stretchModes: const [
                StretchMode.blurBackground,
              ],
            ),
            elevation: 0.0,
            // floating: true,
            // pinned: true,
            // backgroundColor: const Color(0xff151922),
            // actions: [
            //   Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 20),
            //     child: CircleGradientIcon(
            //       onTap: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) => const iosSetting(),
            //           ),
            //         );
            //       },
            //       icon: CupertinoIcons.profile_circled,
            //       color: Colors.blue,
            //       iconSize: 24,
            //       size: 35,
            //     ),
            //   ),
            // ],
          ),
          SliverToBoxAdapter(
            child: buildGrid(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add new password',
        child: SizedBox(
          width: 60,
          height: 60,
          child: CircleGradientIcon(
            icon: Icons.add,
            color: Colors.blueGrey,
            iconSize: 40,
            size: 40,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AddTask(refershPasswords: refreshNotes)));
            },
          ),
        ),
        onPressed: () {},
      ),
    );
  }

  // Stack _buildBody() {
  //   return Stack(
  //     children: [
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           buildGrid(),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  Container buildGrid() {
    return Container(
      // color: const Color(0xff151922),
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: StaggeredGrid.count(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        children: [
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1.5,
            child: GridViewContainer(
              color: Colors.pink,
              icon: Icons.key_rounded,
              subtitle: 'View your all password',
              title: "Passwords",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AllPassScreen(),
                  ),
                );
              },
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1.3,
            child: GridViewContainer(
              color: Colors.cyan,
              isSmall: true,
              icon: CupertinoIcons.shield_lefthalf_fill,
              subtitle: 'Create strong password',
              title: "Password Generator",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Generator(),
                  ),
                );
              },
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1.5,
            child: GridViewContainer(
              color: Colors.purple,
              icon: CupertinoIcons.settings,
              subtitle: 'Manage your app setting',
              title: "Settings",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Settings(),
                  ),
                );
              },
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 1,
            mainAxisCellCount: 1.3,
            child: GridViewContainer(
              color: Colors.blue,
              isSmall: true,
              icon: CupertinoIcons.envelope_badge_fill,
              subtitle: 'Send feedback/suggestions/errors',
              title: "Contact us",
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) =>  const FeedSugErrForm(),),);
              },
            ),
          ),
          StaggeredGridTile.count(
            crossAxisCellCount: 2,
            mainAxisCellCount: 1.2,
            child: GridViewContainer(
              color: Colors.orange,
              isSmall: true,
              icon: Icons.new_releases,
              subtitle: 'Click here to view new features and and fixes here.',
              title: "What's New",
              onPressed: () {z
                showCupertinoDialog(
                    context: context,
                    builder: (context) => _featureDialog(context));
              },
            ),
          ),
          const SizedBox(
            height: 5.0,
          ),
        ],
      ),
    );
  }

  Widget _featureDialog(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text("What's New"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text("There is nothing to show. Keep up-to-date app always."),
        ],
      ),
      actions: <Widget>[
        CupertinoButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }


}
