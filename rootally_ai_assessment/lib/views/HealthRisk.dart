// ignore: file_names
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HealthRisk extends StatefulWidget {
  const HealthRisk({super.key});

  @override
  State<HealthRisk> createState() => _HealthRiskState();
}

class _HealthRiskState extends State<HealthRisk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //background container
          Container(
            height: 350,
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(0.0, -0.5),
                radius: 5.0,
                colors: [
                  Color.fromRGBO(105, 245, 187, 0.5),
                  Color.fromRGBO(145, 182, 85, 0.5),
                ],
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 70,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 16, 16, 16),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: SvgPicture.asset(
                              'assets/images/backArrow.svg', // Path to your SVG asset
                              width: 14, // Adjust the size as needed
                              height: 14,
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          const Text(
                            'Health Risk \nAssessment',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(34, 46, 88, 1),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/timer.svg', // Path to your SVG asset
                                    width: 20, // Adjust the size as needed
                                    height: 20,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  const Text(
                                    "4 min",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Color.fromRGBO(34, 46, 88, 1),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                      const Expanded(child: SizedBox()),
                      Image.asset(
                        'assets/images/fit_person.png', // Path to your SVG asset
                        width: 170, // Adjust the size as needed
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          //Front container
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height - 330,
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 16, left: 16),
                      child: Text(
                        'What do you get ?',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Color.fromRGBO(34, 46, 88, 1)),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/images/instructions.svg', // Path to your SVG asset
                          width: MediaQuery.of(context).size.width * 0.95,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Row(
                        children: [
                          const Text(
                            'How we do it ?',
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(34, 46, 88, 1)),
                          ),
                          const Expanded(child: SizedBox()),
                          Image.asset(
                            'assets/images/round.png',
                            width: 140,
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 1.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(width: 0.2),
                      ),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(
                                20.0), // Set your desired border radius here
                            child: Image.asset(
                              'assets/images/yogaman.png', // Path to your image asset
                              width: MediaQuery.of(context).size.width * 0.90,
                              fit: BoxFit
                                  .cover, // Adjust the image's fit as needed
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromRGBO(0, 191, 77, 0.1)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/security_icon (2).svg', // Path to your SVG asset
                                    width: 20, // Adjust the size as needed
                                    height: 20,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text(
                                    'We do not store or share your personal data',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 10,
                                      color: Color.fromRGBO(112, 112, 112, 1),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Center(
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            "1. Ensure that you are in a well-lit space\n",
                                      ),
                                      WidgetSpan(
                                        child: SizedBox(height: 12.0),
                                      ),
                                      TextSpan(
                                        text:
                                            "2. Allow camera access and place your device against a stable object or wall\n",
                                      ),
                                      WidgetSpan(
                                        child: SizedBox(height: 12.0),
                                      ),
                                      TextSpan(
                                        text:
                                            "3. Avoid wearing baggy clothes\n",
                                      ),
                                      WidgetSpan(
                                        child: SizedBox(height: 12.0),
                                      ),
                                      TextSpan(
                                        text:
                                            "4. Make sure you exercise as per the instructions provided by the trainer\n",
                                      ),
                                      WidgetSpan(
                                        child: SizedBox(height: 12.0),
                                      ),
                                      TextSpan(
                                        text:
                                            "5. Watch the short preview before each exercise",
                                      ),
                                    ],
                                  ),
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
