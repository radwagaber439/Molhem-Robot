import 'package:flutter/material.dart';
import 'package:molham/utiltes/size/size_app.dart';

import '../components/CricleImage.dart';
class CalorieCalculatorScreen extends StatefulWidget {
  @override
  _CalorieCalculatorScreenState createState() => _CalorieCalculatorScreenState();
}

class _CalorieCalculatorScreenState extends State<CalorieCalculatorScreen> {
  final _weightController = TextEditingController();
  final _durationController = TextEditingController();
  double _caloriesBurned = 0;

  void _calculateCalories() {
    final double weight = double.tryParse(_weightController.text) ?? 0;
    final double duration = double.tryParse(_durationController.text) ?? 0;
    final double metValue = 4.0;

    setState(() {
      _caloriesBurned = metValue * weight * (1/60) * duration;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        color: Color(0xFF272431),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularImageWidget(
              image: AssetImage('asset/icons/fit.gif'),
              radius: 150.0,
            ),
            SizedBox(height: 50),

            TextField(
              controller: _weightController,
              decoration: InputDecoration(
                labelText: 'Weight (kg)',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 20), // Smaller font size
            ),
            SizedBox(height: 40), // Add some spacing between text fields
            TextField(
              controller: _durationController,
              decoration: InputDecoration(
                labelText: 'Duration (minutes)',
                labelStyle: TextStyle(color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              ),
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 14), // Smaller font size
            ),

            SizedBox(height: 40),
            ElevatedButton(
              onPressed: _calculateCalories,
              child: Text('Calculate Calories'),
            ),
            SizedBox(height: 20),
            Text(
              'Calories Burned: $_caloriesBurned',
              style: TextStyle(fontSize: 24,color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}