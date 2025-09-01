import 'dart:io' show File;

import 'package:ai/sendToGemini.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class WhatType extends StatefulWidget {
  const WhatType({super.key});

  @override
  State<WhatType> createState() => _WhatTypeState();
}

class _WhatTypeState extends State<WhatType> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _controller = TextEditingController();
  String words = "";

  // Future<void> _textSend(BuildContext context) async{
  //   if(_controller.text.isNotEmpty ){
  //     Navigator.push(context, MaterialPageRoute(builder: (context)=>GeminiUi(imageFile: null, words: words, text: _controller.text)));
  //   }
  // }

  Future<void> _pickImageGallery(BuildContext context) async {
    final XFile? pickedImage = await _picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null ) {
      Navigator.push(context,MaterialPageRoute(builder: (context)=>GeminiUi(imageFile: File(pickedImage.path), words: words, text: null)));
    }
  }

  Future<void> _openCamera(BuildContext context) async {
    //open camera
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null ) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              GeminiUi(imageFile: File(pickedFile.path), words: words, text: null),
        ),
      );
    }
  }

  void _HowManyWords(String value) {
    //how many words
    setState(() {
      words = value;
    });
  }

  Color _containerColor1 = Color(0xFF404141);
  Color _containerColor2 = Color(0xFF404141);
  Color _containerColor3 = Color(0xFF404141);

  void _changeColor1() {
    //color change
    setState(() {
      _containerColor1 = _containerColor1 == Color(0xFF404141)
          ? Color(0xFF717575)
          : Color(0xFF404141);
    });
  }

  void _changeColor2() {
    setState(() {
      _containerColor2 = _containerColor2 == Color(0xFF404141)
          ? Color(0xFF717575)
          : Color(0xFF404141);
    });
  }

  void _changeColor3() {
    setState(() {
      _containerColor3 = _containerColor3 == Color(0xFF404141)
          ? Color(0xFF717575)
          : Color(0xFF404141);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              color: Colors.transparent,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 250,
              width: double.infinity,
              color: Colors.white70,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 60), //how many words container
                      GestureDetector(
                        onTap: () {
                          _HowManyWords("10 to 20");
                          _changeColor1();
                        },
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            color: _containerColor1,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "10-20",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          _HowManyWords("20 to 30");
                          _changeColor2();
                        },
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            color: _containerColor2,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "20-30",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {
                          _HowManyWords("more than 30");
                          _changeColor3();
                        },
                        child: Container(
                          height: 40,
                          width: 100,
                          decoration: BoxDecoration(
                            color: _containerColor3,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              "more+",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Row(
                      children: [
                        const SizedBox(width: 80),
                        GestureDetector(
                          onTap: () {
                            _openCamera(context);
                          },
                          child: Container(
                            //camera
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF282929),
                            ),
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: Colors.white70,
                              size: 40,
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
                        GestureDetector(
                          onTap: () {
                            _pickImageGallery(context);
                          },
                          child: Container(
                            //gallery
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF282929),
                            ),
                            child: Icon(
                              Icons.image,
                              color: Colors.white70,
                              size: 40,
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),

                        GestureDetector(//Text field
                          onTap: () {
                              showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(backgroundColor: Color(0xFF282929),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  content: SizedBox(

                                    width: 300,
                                    child: TextField(
                                      controller: _controller,
                                      keyboardType: TextInputType.multiline,
                                      maxLines: 5, // unlimited lines, grows as you type
                                      minLines: 3,
                                      style: const TextStyle(
                                        color: Colors.white54,
                                      ),
                                      decoration: InputDecoration(
                                        hintText: "Type here..",
                                        hintStyle: const TextStyle(
                                          color: Colors.grey,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          borderSide: const BorderSide(
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  actions: [
                                    Center(
                                      child: Row(

                                        children: [
                                          const SizedBox(width: 50,),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.black54,
                                                minimumSize: const Size(80, 50),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                              ),
                                              onPressed: (){
                                            if(_controller.text.isNotEmpty){

                                              Navigator.pop(context);

                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>GeminiUi(imageFile: null, words: words, text: _controller.text)));


                                            }


                                          }, child: Text("submit")),
                                          const SizedBox(width: 10,),
                                          ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.black54,
                                                minimumSize: const Size(80, 50),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                              ),
                                              onPressed: (){
                                                _controller.clear();
                                              }, child: Text("Clear"))
                                        ],
                                      ),
                                    ),

                                  ],
                                );
                              },
                            );
                          },

                          child: Container(
                            //Text Field
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFF282929),
                            ),
                            child: Icon(
                              Icons.text_fields,
                              color: Colors.white70,
                              size: 40,
                            ),
                          ),
                        ),
                      ],
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
}
