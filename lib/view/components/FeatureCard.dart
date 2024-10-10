import 'package:flutter/material.dart';

class FeatureCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onTap;
  final Color startColor;
  final Color endColor;

  const FeatureCard({

    required this.title,
    required this.imagePath,
    required this.onTap,
    required this.startColor,
    required this.endColor,
  }) ;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height * 0.38,
        width: MediaQuery.of(context).size.height * 0.5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [startColor, endColor],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            stops: [0.25, 0.90],
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.transparent,
              offset: Offset(-12, 12),
              blurRadius: 8,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Image.asset(
                imagePath,
                height: MediaQuery.of(context).size.height * 0.25,
                width:MediaQuery.of(context).size.height * 0.30,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
