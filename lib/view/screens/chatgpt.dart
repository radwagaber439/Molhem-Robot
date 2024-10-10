import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../model/open_ai.dart';
import '../../utiltes/colors/colors_app.dart';
import '../../utiltes/size/size_app.dart';
import '../components/navbar.dart';

class Chatgpt extends StatefulWidget {
  final String texty;

  const Chatgpt({Key? key, required this.texty}) : super(key: key);

  @override
  State<Chatgpt> createState() => _ChatgptState();
}

class _ChatgptState extends State<Chatgpt> {
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
  void  cs()
  async {
    if (result != null) {
      speak("$result"); // Example Arabic text to speak
    }

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
            //5//// fadfef/effaesfe/fea/fedf
            //split /
            ElevatedButton(
              onPressed: () async {
                String result = await openAIService.chatGPTAPI(widget.texty);
                print('Result from isArtPromptAPI: $result');


                setState(() {
                  this.result = result;
                });
                if (result != null) {
                  cs(); // Call your function to speak
                }
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
/*
      Image.network("$result")
*/


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
                    result??"loading", // Display the obtained result here
                    style: TextStyle(
                      fontFamily: 'Playpen Sans',
                      color: Colors.black,
                      fontSize: SizeApp.screenHeight(context) * .02,
                    ),
                  ),
                ),
              ),

            ),






          ],
        ),
      ),
    );
  }
}


class YourWidget extends StatefulWidget {
  final String texty;
  const YourWidget({Key? key, required this.texty}) : super(key: key);

  @override
  State<YourWidget> createState() => _YourWidgetState();
}

class _YourWidgetState extends State<YourWidget> {


  final OpenAIService openAIService = OpenAIService();
 // Create an instance of OpenAIService
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Widget'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Use the isArtPromptAPI method
            String result = await openAIService.chatGPTAPI(widget.texty);

            // Handle the result or use it as needed
            print('Result from isArtPromptAPI: $result');
          },
          child: Text('Call OpenAI Service'),
        ),
      ),
    );
  }
}