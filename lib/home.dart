import 'package:ai/wharType.dart';
import 'package:flutter/material.dart';

class Upload extends StatefulWidget {
  const Upload({super.key});

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xFF282929),
        title: Text("Ai summarizre", style: TextStyle(color: Colors.white)),
      ),
      backgroundColor: Color(0xFF282929),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black26,
              ),
              child: Center(
                child: Image.asset(
                  "assets/images/file.png",
                  height: 80,
                  width: 80,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Drope your image or Take a pic",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(_bottomToTopRoute(WhatType()));
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),

                ),
              ),
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [Color(0xFFB759CF), Color(0xFFA023DE)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,

                  ),
                ),
                child: Container(height: 60, width: 150,

                  child: Center(child: Text("Upload",style: TextStyle(fontSize: 24,color: Colors.white70,fontWeight: FontWeight.bold),)),

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
Route _bottomToTopRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    opaque: false,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0); // Start from bottom
      const end = Offset.zero;        // End at normal position
      const curve = Curves.ease;

      final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}