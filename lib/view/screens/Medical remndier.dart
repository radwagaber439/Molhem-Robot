import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../components/CricleImage.dart';

class ReminderScreen extends StatefulWidget {
  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  final _medicineController = TextEditingController();
  TimeOfDay _selectedTime = TimeOfDay.now();
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    final initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
    final initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _scheduleNotification(TimeOfDay time) async {
    final now = DateTime.now();
    final scheduledNotificationDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    final tzScheduledNotificationDateTime = tz.TZDateTime.from(scheduledNotificationDateTime, tz.local);

    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
    );
    const platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Medicine Reminder',
      'It\'s time to take your medicine',
      tzScheduledNotificationDateTime,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> _saveReminder(String medicineName, TimeOfDay time) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('medicine', medicineName);
    prefs.setInt('hour', time.hour);
    prefs.setInt('minute', time.minute);
  }

  void _setReminder() {
    final medicineName = _medicineController.text;
    if (medicineName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a medicine name')),
      );
      return;
    }
    _saveReminder(medicineName, _selectedTime);
    _scheduleNotification(_selectedTime);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Reminder set for $medicineName at ${_selectedTime.format(context)}')),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF272431),
      child: Scaffold(

        body: Container(
          color: Color(0xFF272431),
          child: Column(
            children: [
              const CircularImageWidget(
                image: AssetImage('asset/icons/md.gif'),
                radius: 150.0,
              ),
              SizedBox(height: 50),
              TextField(
                controller: _medicineController,
                decoration: InputDecoration(
                  labelText: 'Medicine Name',
                  labelStyle: TextStyle(color: Colors.white),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                readOnly: true,
                onTap: () => _selectTime(context),
                decoration: InputDecoration(
                  labelText: 'Reminder Time',

                  labelStyle: TextStyle(color: Colors.white),

                  hintText: _selectedTime.format(context),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _setReminder,
                child: Text('Set Reminder'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
