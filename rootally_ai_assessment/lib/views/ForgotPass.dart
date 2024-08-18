import 'package:flutter/material.dart';

class UnderDev extends StatelessWidget {
  const UnderDev({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Oops!",
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(34, 46, 88, 1)),
              textAlign: TextAlign.center,
            ),
            Text(
              "This screen is under \nDevelopment.",
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(34, 46, 88, 1)),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
