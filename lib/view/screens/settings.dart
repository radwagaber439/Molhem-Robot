import 'package:flutter/material.dart';
import 'package:molham/utiltes/colors/colors_app.dart';
import 'package:molham/view/components/CustomDivider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Drawer(
            child: Container(
                padding: const EdgeInsets.all(3),
                child: ListView(children: [
                  ListTile(
                    leading: const Icon(
                      Icons.menu,
                      size: 35,
                    ),
                    title: const Text(
                      "Settings",
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                    onTap: () {
                      Navigator.of(context).pushReplacementNamed("Navbar");
                    },
                  ),
                  const SizedBox(
                    height: 3,
                  ),
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(5),
                    child: const Text(
                      "Voice",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 18),
                    child: Row(children: [
                      RadioMenuButton(
                        value: "Man",
                        groupValue: "Classifcation",
                        onChanged: (value) {},
                        child: const Text(
                          "Man",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      RadioMenuButton(
                          value: "Woman",
                          groupValue: "Classification",
                          onChanged: (value) {},
                          child: const Text("Woman",
                              style: TextStyle(fontSize: 20))),
                      RadioMenuButton(
                          value: "Kid",
                          groupValue: "Classifcation",
                          onChanged: (value) {},
                          child:
                              const Text("Kid", style: TextStyle(fontSize: 20)))
                    ]),
                  ),
                  CustomDivider(),
                  const SizedBox(
                    height: 3,
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    child: const Text(
                      "Theme",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                          left: 40,
                        ),
                        height: 60,
                        width: 95,
                        child: const CircleAvatar(
                          backgroundColor: ColorApp.backgroundColor,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 40,
                        ),
                        height: 60,
                        width: 95,
                        child: const CircleAvatar(
                          backgroundColor: ColorApp.secondaryColor,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          left: 40,
                        ),
                        height: 60,
                        width: 95,
                        child: const CircleAvatar(
                          backgroundColor: ColorApp.sdark,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                          left: 40,
                        ),
                        height: 80,
                        width: 95,
                        child: const CircleAvatar(
                          backgroundColor: ColorApp.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  CustomDivider(),
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(5),
                    child: const Text(
                      "Font Size",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // ignore: avoid_unnecessary_containers
                  Container(
                    child: Slider(
                      value: 0.8,
                      onChanged: (value) {},
                    ),
                  )
                ]))));
  }
}
