import 'package:flutter/material.dart';
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:" MY NEW APP",
      home: Container(
        color: const Color.fromARGB(255, 128, 75, 75)
      ),
    );
  }
}