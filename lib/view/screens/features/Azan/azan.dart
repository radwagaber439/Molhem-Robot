import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'dart:convert';

class PrayerTimesPage extends StatefulWidget {
  @override
  _PrayerTimesPageState createState() => _PrayerTimesPageState();
}

class _PrayerTimesPageState extends State<PrayerTimesPage> {
  Future<Map<String, dynamic>>? prayerTimesDataFuture;
  late Map<String, Color> prayerTimeColors;
  late Map<String, IconData> prayerTimeIcons;

  @override
  void initState() {
    super.initState();
    prayerTimesDataFuture = fetchPrayerTimes();
    // Define prayer time colors and icons
    prayerTimeColors = {
      'Fajr': Colors.blue[100]!,
      'Sunrise': Colors.orange[100]!,
      'Dhuhr': Colors.yellow,
      'Asr': Colors.purple[100]!,
      'Sunset': Colors.yellow[100]!,
      'Maghrib': Colors.deepOrange[100]!,
      'Isha': Colors.black12,
      'Midnight': Colors.cyan[100]!,
      'Last Third': Colors.black12,
      'Imsak': Colors.red[100]!,
      'First Third': Colors.black12,
    };

    prayerTimeIcons = {
      'Fajr': Icons.brightness_2,
      'Sunrise': Icons.wb_sunny,
      'Dhuhr': Icons.access_time,
      'Asr': Icons.access_time,
      'Sunset': Icons.wb_sunny,
      'Maghrib': Icons.brightness_3,
      'Isha': Icons.nightlight,
      'Midnight': Icons.night_shelter,
      'Last Third': Icons.bed,
      'Imsak': Icons.access_alarm,
      'First Third': Icons.hourglass_bottom,
    };
  }

  Future<Map<String, dynamic>> fetchPrayerTimes() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    final response = await http.get(Uri.parse(
        'http://api.aladhan.com/v1/calendar/2017/4?latitude=${position.latitude}&longitude=${position.longitude}&method=2'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body)['data'][0]['timings'];
    } else {
      throw Exception('Failed to load prayer times');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pray Times'),
        backgroundColor: Colors.indigo,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: prayerTimesDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            Map<String, dynamic>? prayerTimesData = snapshot.data;
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Colors.indigo,
                  floating: false, // Keep the app bar always visible
                  expandedHeight: 250, // Height of the image
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.asset(
                      'asset/icons/prayer.png', // Path to your image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final int firstIndex = index * 2;
                      final int secondIndex = index * 2 + 1;

                      final firstEntry =
                      prayerTimesData!.entries.elementAt(firstIndex);
                      final secondEntry = secondIndex < prayerTimesData.length
                          ? prayerTimesData.entries.elementAt(secondIndex)
                          : null;

                      return Row(
                        children: [
                          buildPrayerTimeCard(
                            firstEntry.key,
                            firstEntry.value,
                            prayerTimeColors[firstEntry.key] ?? Colors.grey,
                            prayerTimeIcons[firstEntry.key] ?? Icons.error,
                            false,
                          ),
                          SizedBox(width: 24.0),
                          if (secondEntry != null)
                            buildPrayerTimeCard(
                              secondEntry.key,
                              secondEntry.value,
                              prayerTimeColors[secondEntry.key] ?? Colors.grey,
                              prayerTimeIcons[secondEntry.key] ?? Icons.error,
                              false,
                            ),
                        ],
                      );
                    },
                    childCount: (prayerTimesData!.length / 2).ceil(),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget buildPrayerTimeCard(
      String title,
      String time,
      Color color,
      IconData icon,
      bool isLastThird,
      ) {
    return Expanded(
      child: SizedBox(
        width: isLastThird ? 150.0 : double.infinity,
        child: Container(
          margin: EdgeInsets.all(8.0),
          child: Card(
            color: color,
            elevation: 6,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    icon,
                    size: 64.0,
                    color: Colors.black,
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    title,
                    style:
                    TextStyle(fontWeight: FontWeight.bold, fontSize: 32.0),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    time,
                    style: TextStyle(fontSize: 28.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

