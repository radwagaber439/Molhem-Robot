import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:molham/utiltes/size/size_app.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:molham/view/components/FeatureCard.dart';
import 'package:molham/view/screens/sleepmode.dart';
import 'package:molham/view/screens/test.dart';
import '../../utiltes/colors/colors_app.dart';
import 'Calrioes calc.dart';
import 'Medical remndier.dart';
import 'deelE.dart';
import 'features/Azan/azan.dart';
import 'features/MolhemAI/FromTenLisning.dart';
import 'features/QRcode.dart';
import 'features/Qiblah/Qiblah.dart';
import 'features/Weather/screens/Weather.dart';
import 'features/fitines/Sprit.dart';
import 'features/games/GameHome.dart';
import 'features/mangetime/mange_time.dart';
import 'features/timetableAzan/timetableAzan.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            /*Container(
              width: SizeApp.screenWidth(context),
              height: SizeApp.screenHeight(context)*.5,
              color: ColorApp.blcki,
              child: Column(
                children: [


                  Container(
                    width: SizeApp.screenWidth(context)*.45,
                    height: SizeApp.screenHeight(context)*.2,
                    child: AnalogClock(
                      dateTime: DateTime.now(),
                      isKeepTime: true,

                    ),
                  ),
                  SizedBox(
                    height: SizeApp.screenHeight(context)*.05,
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top: SizeApp.screenHeight(context)*.1),
                    child: AnimatedTextKit(

                      animatedTexts: [

                        FadeAnimatedText('اهلا بك ',
                          textStyle: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold,color: Colors.white),

                        ),
                        FadeAnimatedText('في ',
                          textStyle: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                        FadeAnimatedText('ملهم',
                          textStyle: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                      ],
                    ),
                  ),



                ],
              ),
            ),*//*Container(
              width: SizeApp.screenWidth(context),
              height: SizeApp.screenHeight(context)*.5,
              color: ColorApp.blcki,
              child: Column(
                children: [


                  Container(
                    width: SizeApp.screenWidth(context)*.45,
                    height: SizeApp.screenHeight(context)*.2,
                    child: AnalogClock(
                      dateTime: DateTime.now(),
                      isKeepTime: true,

                    ),
                  ),
                  SizedBox(
                    height: SizeApp.screenHeight(context)*.05,
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top: SizeApp.screenHeight(context)*.1),
                    child: AnimatedTextKit(

                      animatedTexts: [

                        FadeAnimatedText('اهلا بك ',
                          textStyle: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold,color: Colors.white),

                        ),
                        FadeAnimatedText('في ',
                          textStyle: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                        FadeAnimatedText('ملهم',
                          textStyle: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                      ],
                    ),
                  ),



                ],
              ),
            ),*/
            Container(
              color: Color(0xFF272431),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     FeatureCard(title: 'مواعيد الصلاة', imagePath: 'asset/icons/pray.png', onTap: (){   Navigator.push(context, MaterialPageRoute(builder: (context) => PrayerTimesPage()),);}, startColor:  Color(0xFFdfc5a8), endColor: Color(0xFFdfc5a8),),
                      FeatureCard(title: 'الاذان', imagePath: 'asset/icons/azan.png', onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => PrayerTimesAzan()),);}, startColor:  Color(0xFF1c4904), endColor: Color(0xFF1c4904),)
                      ,FeatureCard(title: 'اتجاه القبلة', imagePath: 'asset/icons/q.png', onTap: (){    Navigator.push(context, MaterialPageRoute(builder: (context) => Qiblah()),);}, startColor: Color(0xFF959494), endColor: Color(0xFF959494)),

                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FeatureCard(title: 'الطقس', imagePath: 'asset/icons/weather.png', onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()),);}, startColor:Color(0xFF27395f), endColor:Color(0xFF27395f))
                     , FeatureCard(title: 'اسال ملهم', imagePath: 'asset/icons/qu.png', onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Sleepmode()),);}, startColor: Color(0xFFa4444c), endColor: Color(0xFFa4444c)),
                      FeatureCard(title: 'التخيلات', imagePath: 'asset/icons/im.png', onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => DellMain()),);}, startColor: Color(0xFF492E87), endColor: Color(0xFF492E87))
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FeatureCard(title: 'الالعاب والترفيه', imagePath: 'asset/icons/game.png', onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => GameHome()),);}, startColor: Color(0xFFabdbe3), endColor: Color(0xFFabdbe3)),

                      FeatureCard(title: 'اداره الوقت', imagePath: 'asset/icons/mange.png', onTap: (){  Navigator.push(context, MaterialPageRoute(builder: (context) => TaskListScreen()),);}, startColor: Color(0xFFd0c50e), endColor: Color(0xFFd0c50e),),
                      FeatureCard(title: 'تقيم الاجابه', imagePath: 'asset/icons/t1.png', onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => FromTen()),);}, startColor: Color(0xFF638889), endColor: Color(0xFF638889))
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FeatureCard(title: 'النشاط والصحة', imagePath: 'asset/icons/man.png', onTap: (){  Navigator.push(context, MaterialPageRoute(builder: (context) => FitnessDemo()),);}, startColor: Color(0xFFbfbebf), endColor: Color(0xFFbfbebf))
                      ,FeatureCard(title: 'شات ملهم', imagePath: 'asset/icons/wrobot.gif', onTap: (){  Navigator.push(context, MaterialPageRoute(builder: (context) => VoiceApp()),);}, startColor: Color(0xFF451c3a), endColor: Color(0xFF451c3a))
                      ,FeatureCard(title: 'QR', imagePath: 'asset/icons/QR.jpg', onTap: (){  Navigator.push(context, MaterialPageRoute(builder: (context) => ScanScreen()),);}, startColor: Color(0xFF63759f), endColor: Color(0xFF63759f))

                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FeatureCard(title: 'التصحيح', imagePath: 'asset/icons/correct.gif', onTap: (){  Navigator.push(context, MaterialPageRoute(builder: (context) => FitnessDemo()),);}, startColor: Color(0xFFe3c3da), endColor: Color(0xFFe3c3da))
                      ,FeatureCard(title: 'السعرات الحرارية', imagePath: 'asset/icons/aa.png', onTap: (){  Navigator.push(context, MaterialPageRoute(builder: (context) => CalorieCalculatorScreen()),);}, startColor: Color(0xFF612034), endColor: Color(0xFF612034))
                      ,FeatureCard(title: 'وقت الدواء', imagePath: 'asset/icons/md.gif', onTap: (){  Navigator.push(context, MaterialPageRoute(builder: (context) => ReminderScreen()),);}, startColor: Color(0xFFd7ca86), endColor: Color(0xFFd7ca86))

                    ],
                  ),


                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
