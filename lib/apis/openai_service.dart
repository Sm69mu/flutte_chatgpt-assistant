import 'dart:convert';

import 'package:flutter_chatgpt_assistant/keys/openaiapi_key.dart';
import 'package:http/http.dart' as http;

class OpenAiservice {
  final List<Map<String, String>> messages = [];
  Future<String> isArtPromptApi(String prompt) async {
    try {
      var res = await http.post(
          Uri.parse('https://api.openai.com/v1/chat/completions'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $openkey',
          },
          body: jsonEncode(
            {
              'model': 'gpt-3.5-turbo',
              'messages': [
                {
                  'role': 'user',
                  'content':
                      "Does this message want to generate an AI picture, image, art or anything similar ? $prompt. simply answer with a yes or no"
                }
              ]
            },
          ));
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
            final res = await DallEApi(prompt);
            return res;
          default:
            final res = await chatGPTApi(prompt);
            return res;
        }
      }
      return 'an internal error occured';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> chatGPTApi(String prompt) async {
    messages.add({'role': 'user', 'content': prompt});
    try {
      var res = await http.post(
          Uri.parse('https://api.openai.com/v1/chat/completions'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $openkey',
          },
          body: jsonEncode(
            {'model': 'gpt-3.5-turbo', 'messages': messages},
          ));

      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();

        messages.add({'role': 'assistant', 'content': content});
        return content;
      }
      return 'an internal error occured';
    } catch (e) {
      return e.toString();
    }
  }

  // ignore: non_constant_identifier_names
  Future<String> DallEApi(String prompt) async {
    messages.add({'role': 'user', 'content': prompt});
    try {
      var res = await http.post(
          Uri.parse('https://api.openai.com/v1/images/generations'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $openkey',
          },
          body: jsonEncode(
            {
              'prompt': prompt,
              'n': 1,
            },
          ));

      if (res.statusCode == 200) {
        String imageUrl = jsonDecode(res.body)['data'][0]['url'];
        imageUrl = imageUrl.trim();

        messages.add({'role': 'assistant', 'content': imageUrl});
        return imageUrl;
      }
      return 'an internal error occured';
    } catch (e) {
      return e.toString();
    }
    // return 'dalle';
  }
}
