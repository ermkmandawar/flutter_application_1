import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class iosSetting extends StatefulWidget {
  const iosSetting({Key? key}) : super(key: key);

  @override
  State<iosSetting> createState() => _iosSettingState();
}

class _iosSettingState extends State<iosSetting> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // backgroundColor: const Color(0xFFE9EEF4),
      navigationBar: const CupertinoNavigationBar(


        middle: Text("Settings"),
      ),
      child: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin:  const EdgeInsets.all(8.0),

                child: ListTile(
                  title: Text('MKan'),

                ),
              ),

              const SizedBox(
                height: 20.0,
              ),
              const Text('Privacy'),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(
                        CupertinoIcons.shield_lefthalf_fill,
                        color: CupertinoColors.systemRed,
                      ),
                      title: const Text('Security'),
                      trailing: const Icon(CupertinoIcons.forward),
                      onTap: () {},
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(
                        CupertinoIcons.shield_lefthalf_fill,
                        color: CupertinoColors.systemRed,
                      ),
                      title: const Text('Security'),
                      trailing: const Icon(CupertinoIcons.forward),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: const Icon(
                        CupertinoIcons.shield_lefthalf_fill,
                        color: CupertinoColors.systemRed,
                      ),
                      title: const Text('Security'),
                      trailing: const Icon(CupertinoIcons.forward),
                      onTap: () {},
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
