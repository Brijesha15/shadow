import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Stack(
            children: [
              // Book Cover
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                child: Image.network(
                  'https://download.dadabhagwan.org/Books/Marathi/Images/Aptavani-7-Marathi.jpg',
                  width: 200,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),

              // Book Spine (Shadow Effect)
              Positioned(
                left: -16, // Adjusted for a better fit
                top: 0,
                bottom: 0,
                child: Container(
                  width: 30, // Thicker spine
                  height: 300, // Full height of the book
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12), // Curvature at the top
                      bottomLeft: Radius.circular(12), // Curvature at the bottom
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        Colors.black.withOpacity(0.2), // Adjust shadow opacity
                        Colors.transparent,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3), // Shadow color
                        offset: Offset(6, 0), // Shadow offset
                        blurRadius: 10, // Blurriness of shadow
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                ),
              ),

              // Soft Light Reflection on Spine
              Positioned(
                left: -10, // Subtle effect
                top: 0,
                bottom: 0,
                child: Container(
                  width: 5, // Width of the soft light
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.centerRight,
                      end: Alignment.centerLeft,
                      colors: [
                        Colors.white.withOpacity(0.4), // Softer highlight
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}