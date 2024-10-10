import 'package:flutter/material.dart';

import 'package:molham/view/components/navbar.dart';
import 'package:molham/utiltes/colors/colors_app.dart';

class menu extends StatelessWidget {
  const menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Navbar(),
      appBar: AppBar(),
      body: Center(),
    );
  }
}
