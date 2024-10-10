import 'package:flutter/material.dart';
import 'package:molham/utiltes/colors/colors_app.dart';

import '../../utiltes/size/size_app.dart';

class FeatureBox extends StatelessWidget {
  final Color color;
  final String headerText;
  final String descriptionText;
  const FeatureBox({
    super.key,
    required this.color,
    required this.headerText,
    required this.descriptionText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 35,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0).copyWith(
          left: 15,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                headerText,
                style:  TextStyle(
                  fontFamily: 'Cera Pro',
                  color: ColorApp.textColor,
                  fontSize: SizeApp.screenHeight(context)*.035,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 3),
            Padding(
              padding:  EdgeInsets.only(right: 20),
              child: Text(
                descriptionText,
                style:  TextStyle(
                  fontFamily: 'Cera Pro',
                  color: ColorApp.textColor,
                  fontSize: SizeApp.screenHeight(context)*.025,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}