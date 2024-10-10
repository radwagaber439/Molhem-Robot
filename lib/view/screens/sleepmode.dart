import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../constants/imageassest.dart';
import '../../model/open_ai.dart';
import '../../utiltes/colors/colors_app.dart';
import '../components/navbar.dart';
import 'chatgpt.dart';

// Import your Arabic font if available
// import 'package:your_arabic_font_package.dart';

class Sleepmode extends StatefulWidget {
  const Sleepmode({Key? key}) : super(key: key);

  @override
  State<Sleepmode> createState() => _SleepmodeState();
}

class _SleepmodeState extends State<Sleepmode> {
  final speechToText = SpeechToText();
  final flutterTts = FlutterTts();
  final OpenAIService openAIService = OpenAIService();
  String? generatedContent;
  String? generatedImageUrl;
  String lastWords = '';
  bool displayDefaultPhoto = false;
  Timer? _timer;
  bool isListening = false;

  final arabicFont = TextStyle(
    fontFamily: 'YourArabicFontFamily',
    fontSize: 24.0,
  );

  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }
//
  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    await flutterTts.setLanguage('ar-EG');
    setState(() {});
  }
void move(){
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Chatgpt(texty: lastWords,)),
  );
}
  Future<void> initSpeechToText() async {
    bool available = await speechToText.initialize(
      onStatus: (status) {
        if (status == 'initialized') {
          setState(() {});
        }
      },
    );
    if (!available) {
      print('Speech recognition not available');
    }
  }

  Future<void> startListening() async {
    bool available = await speechToText.listen(
      onResult: onSpeechResult,
      localeId: 'ar-EG',
      listenFor: Duration(seconds: 20),
    );
    final speech = await openAIService.isArtPromptAPI(lastWords);



    if (!available) {
      print('Speech recognition not available');
    }
    setState(() {
      isListening = true;
    });
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {
      isListening = false;
    });
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
      print('Recognized Words: $lastWords');
      Duration(seconds: 20);
      if (lastWords.isNotEmpty) {
        move();
      }


      // For debugging purposes
    });
  }

  void _startTimer() {
    _timer = Timer(const Duration(seconds: 30), () {
      setState(() {
        displayDefaultPhoto = true;
      });
    });
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      displayDefaultPhoto = false;
    });
    _startTimer();
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () async {
          if (isListening) {
            await stopListening();
          } else {
            await startListening();
          }
          _resetTimer();
        },
        mini: false,
        child: isListening ? const Icon(Icons.mic_off) : const Icon(Icons.mic),
      ),
      drawer: const Navbar(),
      appBar: AppBar(
        backgroundColor: ColorApp.darks,
      ),
      body: GestureDetector(
        onTap: () {

          _resetTimer();
        },
        child: Stack(
          children: [
            Center(
              child: displayDefaultPhoto
                  ? Image.asset(
                AppImageAsset.ogif,
                width: width,
              )
                  : Image.asset(
                AppImageAsset.ogif,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  lastWords,
                  textDirection: TextDirection.rtl,
                  style: arabicFont,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
