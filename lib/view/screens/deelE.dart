import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:learning_translate/learning_translate.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../constants/imageassest.dart';
import '../../model/open_ai.dart';
import '../../utiltes/colors/colors_app.dart';
import '../../utiltes/size/size_app.dart';
import '../components/navbar.dart';

class Dell extends StatefulWidget {
  final String texty;

  const Dell({Key? key, required this.texty}) : super(key: key);

  @override
  State<Dell> createState() => _DellState();
}

class _DellState extends State<Dell> {
  String? result;
  final OpenAIService openAIService = OpenAIService();

  FlutterTts flutterTts = FlutterTts();
  @override
  void initState() {
    super.initState();
    initTts();
  }
  Future<void> initTts() async {
    await flutterTts.setLanguage('ar'); // Set language to Arabic
    // Other configurations such as volume, pitch, etc., can be set here
  }
  Future<void> speak(String text) async {
    await flutterTts.setSpeechRate(.5); // Set speech rate (speed)
    await flutterTts.speak(text);
  }
  @override
  void dispose() {
    flutterTts.stop(); // Stop TTS when the page is disposed
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Navbar(),
      appBar: AppBar(
        title: const Center(
          child: Text("Assistant Molhem"),
        ),
        titleTextStyle: const TextStyle(
          fontSize: 30,
          fontFamily: "Playpen Sans",
          fontWeight: FontWeight.bold,
          color: ColorApp.textColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () async {
                String result = await openAIService.dallEAPI(widget.texty);
                print('Result from isArtPromptAPI: $result');

                setState(() {
                  this.result = result;
                });
              },
              child: Text('Call OpenAI Service'),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 40).copyWith(
                top: 30,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(200, 200, 200, 1),
                ),
                borderRadius: BorderRadius.circular(20).copyWith(
                  topLeft: Radius.zero,
                ),

              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Text(
                    widget.texty ?? '', // Display the obtained result here
                    style: TextStyle(
                      fontFamily: 'Playpen Sans',
                      color: Colors.black,
                      fontSize: SizeApp.screenHeight(context) * .02,
                    ),
                  ),
                ),
              ),

            ),



            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              margin: const EdgeInsets.symmetric(horizontal: 40).copyWith(
                top: 30,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromRGBO(200, 200, 200, 1),
                ),
                borderRadius: BorderRadius.circular(20).copyWith(
                  topLeft: Radius.zero,
                ),

              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Image.network(result??'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNULjOF_hZzfyv8MMKTRJ6Y3n9B3ReI1XFMA&usqp=CAU'),
                ),
              ),

            ),




          ],
        ),
      ),
    );
  }
}



class DellMain extends StatefulWidget {
  const DellMain({Key? key}) : super(key: key);

  @override
  State<DellMain> createState() => _DellMainState();
}

class _DellMainState extends State<DellMain> {
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
  Future<void> move() async {

    Translator translator = Translator(from: ARABIC, to: ENGLISH);
    String translatedText = await translator.translate(lastWords);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Dell(texty: translatedText,)),
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
                AppImageAsset.two,
                width: width,
              )
                  : Image.asset(
                AppImageAsset.one,
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
