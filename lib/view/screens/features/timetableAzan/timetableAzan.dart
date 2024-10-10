import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class PrayerTimesAzan extends StatefulWidget {
  @override
  _PrayerTimesAzanState createState() => _PrayerTimesAzanState();
}

class _PrayerTimesAzanState extends State<PrayerTimesAzan> {
  Map<String, dynamic>? prayerTimesData;
  AudioCache audioPlayer = AudioCache();

  @override
  void initState() {
    super.initState();
    fetchPrayerTimes();
    Timer.periodic(Duration(minutes: 1), (timer) {
      checkPrayerTime();
    });
  }

  Future<void> fetchPrayerTimes() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    final response = await http.get(Uri.parse(
        'http://api.aladhan.com/v1/calendar/2017/4?latitude=${position.latitude}&longitude=${position.longitude}&method=2'));

    if (response.statusCode == 200) {
      setState(() {
        prayerTimesData = jsonDecode(response.body)['data'][0]['timings'];
      });
    } else {
      throw Exception('Failed to load prayer times');
    }
  }

  void checkPrayerTime() {
    var now = DateTime.now();
    var formatter = DateFormat('HH:mm');

    prayerTimesData?.forEach((key, value) {
      if (value == formatter.format(now)) {
        playAudio();
      }
    });
  }

  Future<void> playAudio() async {
    final player = AudioPlayer();
    await player.play(UrlSource(
        'https://www.boomplay.com/songs/38242274?srModel=COPYLINK&srList=WEB'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Azan Times',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'asset/icons/background_img.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Center(
                      child: prayerTimesData == null
                          ? const CircularProgressIndicator()
                          : ListView(
                        padding: const EdgeInsets.all(5.0),
                        children: prayerTimesData!.entries
                            .map((entry) => Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5),
                          child: buildPrayerTimeCard(
                              entry.key, entry.value),
                        ))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPrayerTimeCard(String title, String time) {
    return Card(
      color: Colors.indigo.withOpacity(0.8),
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          children: [
            const Icon(
              Icons.access_alarm,
              size: 64.0,
              color: Colors.white,
            ),
            const SizedBox(width: 20.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32.0,
                      color: Colors.white),
                ),
                const SizedBox(height: 10.0),
                Text(
                  time,
                  style: const TextStyle(fontSize: 28.0, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

