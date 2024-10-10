import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';

import 'LoadingIndicator.dart';
import 'QiblahCompass.dart';
import 'QiblahMaps.dart';
class Qiblah extends StatefulWidget {
  const Qiblah({Key? key}) : super(key: key);

  @override
  State<Qiblah> createState() => _QiblahState();
}
final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();

class _QiblahState extends State<Qiblah> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _deviceSupport,
        builder: (_, AsyncSnapshot<bool?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) return LoadingIndicator();
          if (snapshot.hasError)
            return Center(
              child: Text("Error: ${snapshot.error.toString()}"),
            );

          if (snapshot.data!)
            return QiblahCompass();
          else
            return QiblahMaps();
        },
      ),


    );
  }
}
