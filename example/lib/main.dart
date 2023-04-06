import 'package:flutter/material.dart';
import 'package:wtf_rotary_dial/wtf_rotary_dial.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WTF Rotary Dial',
      home: Scaffold(
        body: Center(
          child: RotaryDial(
            onDigitSelected: (value) {
              // The value is entered number.
            },
            rotaryDialThemeData: RotaryDialThemeData(
              spinnerColor: const Color(0xFFFFFFFF),
              rotaryDialColor: const Color(0xFF1871F0),
              dialColor: const Color(0xFF529AFF),
              numberColor: const Color(0xFFFFFFFF),
              margin: null,
              dialBorderRadius: null,
            ),
            duration: const Duration(milliseconds: 500),
            curve: Curves.decelerate,
          ),
        ),
      ),
    );
  }
}
