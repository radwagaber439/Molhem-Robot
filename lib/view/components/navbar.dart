import 'package:flutter/material.dart';
import 'package:molham/utiltes/colors/colors_app.dart';

import '../screens/deelE.dart';
import '../screens/sleepmode.dart';
import 'CustomDivider.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: ColorApp.darks,
      child: Container(
        padding: const EdgeInsets.all(3),
        child: ListView(
          children: [
            ListTile(
              trailing: const Icon(
                Icons.menu,
                color: Colors.white,
                size: 40,
              ),
              title: const Text(
                "Chat Gpt",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              ),
              textColor: Colors.white,
              onTap: () {},
            ),
            CustomDivider(),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  child: ListTile(
                    trailing: const Icon(
                      Icons.home,
                      color: Colors.white,
                      size: 30,
                    ),
                    title: const Text(
                      "Home",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    textColor: Colors.white,
                    onTap: () {

                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Sleepmode()),
                      );

                    },
                  ),
                ),
                CustomDivider(),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: ListTile(
                    trailing: const Icon(
                      Icons.computer_sharp,
                      color: Colors.white,
                      size: 30,
                    ),
                    title: const Text(
                      "Dall-E",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    textColor: Colors.white,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) =>  DellMain()),
                      );


                    },
                  ),
                ),
                CustomDivider(),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: ListTile(
                    trailing: const Icon(
                      Icons.voice_chat_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                    title: const Text(
                      "Voice Assistant",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    textColor: Colors.white,
                    onTap: () {},
                  ),
                ),
                CustomDivider(),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: ListTile(
                    trailing: const Icon(
                      Icons.chat_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                    title: const Text(
                      "Chat Gpt",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    textColor: Colors.white,
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed("chatgpt");
                    },
                  ),
                ),
                CustomDivider(),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: ListTile(
                    trailing: const Icon(
                      Icons.note_sharp,
                      color: Colors.white,
                      size: 30,
                    ),
                    title: const Text(
                      "Writing Mode",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    textColor: Colors.white,
                    onTap: () {},
                  ),
                ),
                CustomDivider(),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: ListTile(
                    trailing: const Icon(
                      Icons.bedtime_off_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                    title: const Text(
                      "Sleep Mode",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    textColor: Colors.white,
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed("Sleepmode");
                    },
                  ),
                ),
                CustomDivider(),
                Container(
                  padding: const EdgeInsets.all(5),
                  child: ListTile(
                    trailing: const Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 30,
                    ),
                    title: const Text(
                      "Settings",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    textColor: Colors.white,
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed("Settings");
                    },
                  ),
                ),
                CustomDivider(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
