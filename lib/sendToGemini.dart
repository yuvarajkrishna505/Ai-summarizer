import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GeminiUi extends StatefulWidget {
  final File? imageFile;
  final String words;
  final String? text;
  const GeminiUi({super.key,required this.imageFile,required this.words,required this.text});

  @override
  State<GeminiUi> createState() => _GeminiUiState();
}
class _GeminiUiState extends State<GeminiUi> {
  String? _result;
  bool _isloading = true;

  @override
  void initState() {
    super.initState();
    _fetchSummary();
  }

  Future<void> _fetchSummary() async {
    String result;
    if (widget.text != null) {
      result = await _summarizeText(widget.text!,widget.words);
    } else if (widget.imageFile != null) {
      result = await _GeminiUi(widget.imageFile!,);
    } else {
      result = "no input";
    }
    setState(() {
      _result = result;
      _isloading = false;
    });
  }

  Future<String> _GeminiUi(File imageFile) async {
    const apiKey = "AIzaSyA7s3PcblL-WkBEC3FPogYVGn7j7a4pMfQ";
    final uri = Uri.parse(
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey");

    final base64Image = base64Encode(await imageFile.readAsBytes());

    final body = {
      "contents": [
        {
          "parts": [
            {
              "text": "Summarize the content of this image that a student a study all information about that image like making a short note about it in ${widget
                  .words} words."
            },
            {
              "inline_data": {
                "mime_type": "image/jpeg",
                "data": base64Image,
              }
            }
          ]
        }
      ]
    };

    final response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["candidates"][0]["content"]["parts"][0]["text"] ??
          "No summary found.";
    } else {
      return "Error: ${response.body}";
    }
  }

  Future<String> _summarizeText(String text,String words) async {
    const apiKey = "AIzaSyA7s3PcblL-WkBEC3FPogYVGn7j7a4pMfQ";
    final uri = Uri.parse(
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey");

    final body = {
      "contents": [
        {
          "parts": [
            {"text": "Summarize this text in simple words that a student a study all information about that image like making a short note about it in the text is: $text that should be under $words words"}
          ]
        }
      ]
    };

    final response = await http.post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["candidates"][0]["content"]["parts"][0]["text"] ??
          "No summary found.";
    } else {
      return "Error: ${response.body}";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF282929),
        appBar: AppBar(centerTitle: true,
          backgroundColor: Color(0xFF282929),
          title: Text(
            "AI Summarizer", style: TextStyle(color: Colors.white70),),
        ),
        body: Center(
            child: _isloading ? const CircularProgressIndicator() : Container(
                height: 900,
                width: 450,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),

                child: Column(mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(" Summary..", style: TextStyle(
                        color: Colors.white38,
                        fontSize: 25,
                        fontWeight: FontWeight.normal),),
                    Padding(
                      padding: const EdgeInsets.all(8.0),

                      child: Text(_result ?? "no data fount",
                        style: TextStyle(fontSize: 16, color: Colors.white),),
                    ),
                  ],
                )
            )
        )


    );
  }
}
