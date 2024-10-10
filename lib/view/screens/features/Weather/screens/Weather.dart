import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;

import '../../../../../utiltes/size/size_app.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  String location = "Your Location";
  bool isLoading = true;
  String? error;
  Map<String, dynamic>? weatherData;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
    getWeatherData().then((value) => speak('درجة الحرارة ${_convertTemperature(weatherData!['main']['temp']).round()}°C'));
  }

  Future<void> speak(String text) async {
    FlutterTts flutterTts = FlutterTts();
    await flutterTts.setLanguage('ar-EG'); // Set language to Arabic (Egypt)
    await flutterTts.setSpeechRate(0.5); // Set speech rate (speed)
    await flutterTts.speak(text);
  }

  Future<void> getWeatherData() async {
    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?lat=31.2700528&lon=30.0036131&appid=5ea288b75204fd805229671b3c3117ff'));
      if (response.statusCode == 200) {
        setState(() {
          weatherData = jsonDecode(response.body);
          location = weatherData?['name'] ?? 'Location not found';
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
          error = 'Failed to fetch weather data';
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        error = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'asset/icons/weather.jpg',
            fit: BoxFit.cover,
          ),
          Center(
            child: weatherData != null
                ? FadeTransition(
              opacity: _animation,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Temperature: ${_convertTemperature(weatherData!['main']['temp'])}°C',
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                  Text(
                    'Description: ${weatherData!['weather'][0]['description']}',
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Container(
                      height: SizeApp.screenHeight(context)*.2,
                      width:SizeApp.screenWidth(context)*.3,
                      child: ElevatedButton(
                        onPressed: () {
                          getWeatherData().then((value) =>
                              speak('سرعة الرياح ${weatherData!['wind']['speed']}'));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text('الرياح', style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white)),
                      ),
                    ),
                    SizedBox(width: 20,),
                    Container(
                      height: SizeApp.screenHeight(context)*.2,
                      width:SizeApp.screenWidth(context)*.3,
                      child: ElevatedButton(
                        onPressed: () {
                          getWeatherData().then((value) =>
                              speak('الغيوم ${weatherData!['clouds']['all']}'));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text('الغيوم',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white)),
                      ),
                    ),
                      SizedBox(width: 20,),
                    Container(
                      height: SizeApp.screenHeight(context)*.2,
                      width:SizeApp.screenWidth(context)*.3,
                      child: ElevatedButton(
                        onPressed: () {
                          getWeatherData().then((value) =>
                              speak('الضغط الجوي ${weatherData!['main']['pressure']}'));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          onPrimary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text('الضغط الجوي',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white)),
                      ),
                    ),
                  ],),

                ],
              ),
            )
                : Text(
              error ?? 'Error occurred',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }

  double _convertTemperature(double kelvinTemp) {
    return kelvinTemp - 273.15;
  }
}
