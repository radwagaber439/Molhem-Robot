import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/secret.dart';
final List<Map<String, String>> messages = [];

class OpenAIService {

  Future<String> isArtPromptAPI(String prompt) async {
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {
              'role': 'user',
              'content':
              'Does this message want to generate an AI picture, image, art or anything similar? $prompt . Simply answer with a yes or no.',
            }

          ],
        }),
      );
      print(res.body);
      if (res.statusCode == 200) {
        String content =
        jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();

        switch (content) {
          case 'Yes':
          case 'yes':
          case 'Yes.':
          case 'yes.':
            final res = await dallEAPI(prompt);
            return res;
          default:
            final res = await chatGPTAPI(prompt);
            return res;
        }
      }
      return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }


  Future<String> chatGPTAPI(String prompt) async {
    try {
      List<Map<String, String>> messages = [
        {
          'role': 'user',
          'content': prompt,
        }
      ];

      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": messages,
          "max_tokens": 250,
          "temperature": 0,
          "top_p": 1,
        }),
      );

      if (res.statusCode == 200) {
        // Use utf8.decode to handle Arabic text decoding
        String content = jsonDecode(res.body)['choices'][0]['message']['content'];
        content = utf8.decode(content.codeUnits); // Decode Arabic text
        content = content.trim();

        List<Map<String, String>> updatedMessages = List.from(messages); // Create a copy
        updatedMessages.add({
          'role': 'assistant',
          'content': content,
        });

        return content;
      }
      return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }
  Future<String> dallEAPI(String prompt) async {
    messages.add({
      'role': 'user',
      'content': prompt,
    });
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/images/generations'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey',
        },
        body: jsonEncode({
          'prompt': prompt,
          'n': 1,
        }),
      );

      if (res.statusCode == 200) {
        String imageUrl = jsonDecode(res.body)['data'][0]['url'];
        imageUrl = imageUrl.trim();

        messages.add({
          'role': 'assistant',
          'content': imageUrl,
        });
        return imageUrl;
      }
      return 'An internal error occurred';
    } catch (e) {
      return e.toString();
    }
  }
}
//check ---- r----chat- dall send  ----r2
// last words. contain (art-image)---move