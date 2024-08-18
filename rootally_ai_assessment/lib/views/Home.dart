import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rootally_ai_assessment/views/HealthRisk.dart';
import 'package:rootally_ai_assessment/views/Login.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String username = "user";
  bool isAssessmentSelected = true;

  @override
  void initState() {
    super.initState();
    _fetchUsername();
  }

  Future<void> _fetchUsername() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userDoc.exists) {
        setState(() {
          username = userDoc['username'];
        });
      } else {
        setState(() {
          username = "No username found";
        });
      }
    }
  }

  List<Map<String, String>> exercises = [
    {
      'imagePath': 'assets/images/list 1.png',
      'title': 'Sweat Starter',
      'type': 'Full Body',
      'difficulty': 'Medium',
    },
    {
      'imagePath': 'assets/images/list 2.png',
      'title': 'Cardio Blast',
      'type': 'Cardio',
      'difficulty': 'Hard',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Hello $username",
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Color.fromRGBO(37, 95, 213, 1)),
                    ),
                    const Expanded(child: SizedBox()),
                    GestureDetector(
                      onTap: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: SvgPicture.asset(
                        'assets/images/Person icon.svg', // Path to your SVG asset
                        width: 28, // Adjust the size as needed
                        height: 28,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(241, 241, 249, 1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            left: isAssessmentSelected
                                ? 0
                                : MediaQuery.of(context).size.width * 0.5 - 24,
                            right: isAssessmentSelected
                                ? MediaQuery.of(context).size.width * 0.5 - 24
                                : 0,
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                alignment: Alignment.center,
                                height: 40,
                                width: MediaQuery.of(context).size.width * 0.5 -
                                    24,
                                decoration: BoxDecoration(
                                  color: Colors
                                      .white, // White background for the selected button
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isAssessmentSelected = true;
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "My Assessments",
                                      style: TextStyle(
                                        color: isAssessmentSelected
                                            ? const Color.fromRGBO(
                                                37, 95, 213, 1)
                                            : const Color.fromRGBO(
                                                107, 107, 107, 1),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isAssessmentSelected = false;
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "My Appointments",
                                      style: TextStyle(
                                        color: isAssessmentSelected
                                            ? const Color.fromRGBO(
                                                107, 107, 107, 1)
                                            : const Color.fromRGBO(
                                                37, 95, 213, 1),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.42,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(241, 241, 249, 1),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          // Determine if the animation is entering or exiting
                          bool isReversing =
                              animation.status == AnimationStatus.reverse;

                          // Define the offset for entering and exiting animations
                          Offset enteringOffset = Offset(
                              isReversing ? -1.0 : 1.0,
                              0.0); // Adjust the direction here
                          Offset exitingOffset =
                              Offset(isReversing ? 1.0 : -1.0, 0.0);

                          // Create the animations for sliding in and out
                          final inAnimation = Tween<Offset>(
                            begin: enteringOffset,
                            end: Offset.zero,
                          ).animate(animation);

                          final outAnimation = Tween<Offset>(
                            begin: Offset.zero,
                            end: exitingOffset,
                          ).animate(animation);

                          return SlideTransition(
                            position: isReversing ? outAnimation : inAnimation,
                            child: child,
                          );
                        },
                        child: isAssessmentSelected
                            ? _buildAssessmentsContent()
                            : _buildAppointmentsContent(),
                      ),
                    ),
                    Container(
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(241, 241, 249, 1),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 30,
                              width: 120,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 3), // Adjust padding as needed
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(
                                    35, 47, 88, 1), // Dark blue color
                                borderRadius: BorderRadius.circular(
                                    20), // Rounded corners
                              ),
                              child: const Center(
                                child: Text(
                                  "View all",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white, // White text color
                                    fontWeight:
                                        FontWeight.w500, // Semi-bold text
                                    fontSize: 12, // Adjust font size as needed
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Challenges",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        const Text(
                          "View All",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        SvgPicture.asset(
                          'assets/images/Arrow icon.svg', // Path to your SVG asset
                          width: 30, // Adjust the size as needed
                          height: 30,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(193, 234, 209, 1),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(14, 10, 8, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Today's Challenge!",
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Color.fromRGBO(43, 122, 113, 1)),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromRGBO(43, 122, 113, 1),
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                    child: Text(
                                      "Push Up 20x",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Stack(
                                  children: [
                                    // Background progress bar
                                    Container(
                                      height: 10.0,
                                      width: 180,
                                      decoration: BoxDecoration(
                                        color: Colors.white, // Background color
                                        borderRadius: BorderRadius.circular(
                                            12.0), // Rounded corners
                                      ),
                                    ),
                                    // Foreground progress bar (progress indicator)
                                    Container(
                                      height: 10.0,
                                      width:
                                          90, // Width based on progress, adjust this value
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            255, 136, 165, 1), // Progress color
                                        borderRadius: BorderRadius.circular(
                                            12.0), // Rounded corners
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                    height:
                                        4.0), // Spacing between progress bar and text
                                // Progress Text
                                const Row(
                                  children: [
                                    Text(
                                      "10/20",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      " Complete",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(12, 8, 12, 8),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/play button.svg', // Path to your SVG asset
                                          width:
                                              20, // Adjust the size as needed
                                          height: 20,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text(
                                          "Continue",
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color:
                                                Color.fromRGBO(37, 95, 213, 1),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Image.asset(
                            'assets/images/push up.png', // Path to your SVG asset
                            width: 150, // Adjust the size as needed
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        const Text(
                          "Workout Routines",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                        const Expanded(child: SizedBox()),
                        const Text(
                          "View All",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        SvgPicture.asset(
                          'assets/images/Arrow icon.svg', // Path to your SVG asset
                          width: 30, // Adjust the size as needed
                          height: 30,
                        ),
                      ],
                    ),
                    Container(
                      height: 170,
                      padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: exercises.length,
                        itemBuilder: (context, index) {
                          // Step 2: Retrieve the data for each exercise from the list
                          final exercise = exercises[index];
                          return Container(
                            height: 170,
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            width: MediaQuery.of(context).size.width *
                                0.8, // Adjust width as needed
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border:
                                  Border.all(color: Colors.black, width: 0.4),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    bottomLeft: Radius.circular(15),
                                  ),
                                  child: Image.asset(
                                    exercise['imagePath']!,
                                    fit: BoxFit.cover,
                                    height: 140,
                                    width: 120,
                                  ),
                                ),
                                Expanded(
                                  // Use Expanded to avoid overflow
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 8, 8, 8),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          exercise['title']!,
                                          style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          exercise['type']!,
                                          style: const TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black,
                                                width: 0.5),
                                            borderRadius:
                                                BorderRadius.circular(25.0),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 5, 10, 5),
                                            child: Text(
                                              "Lose Weight",
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color.fromRGBO(
                                                      37, 95, 213, 1)),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "Difficulty :",
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              ' ${exercise['difficulty']}',
                                              style: TextStyle(
                                                color: exercise['difficulty'] ==
                                                        'Medium'
                                                    ? const Color.fromRGBO(
                                                        255, 136, 165, 1)
                                                    : exercise['difficulty'] ==
                                                            'Hard'
                                                        ? Colors.red
                                                        : Colors.green,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Poppins',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAssessmentsContent() {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: fetchAssessments(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No assessments found.'));
        }

        final assessments = snapshot.data!;

        return ListView.builder(
          itemCount: assessments.length,
          itemBuilder: (context, index) {
            final assessment = assessments[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
              child: Container(
                // width: MediaQuery.of(context).size.width * 0.80,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    if (assessment['imageUrl'] != null)
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(
                              10.0), // Adjust the radius as needed
                          bottomLeft: Radius.circular(10.0),
                        ),
                        child: Image.network(
                          assessment['imageUrl'],
                          width: 150,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 2.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              assessment['title'] ?? 'No Title',
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14.0,
                                fontWeight: FontWeight.w600,
                                color: Color.fromRGBO(34, 46, 88, 1),
                                height: 1.5,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2.0),
                            // Display the instruction
                            Text(
                              assessment['instruction'] ?? 'No Instruction',
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10,
                                  color: Color.fromRGBO(42, 42, 42, 1)),
                            ),
                            const SizedBox(height: 4.0),
                            // Display the link
                            if (assessment['link'] != null)
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: const HealthRisk(),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/play button.svg', // Path to your SVG asset
                                      width: 30, // Adjust the size as needed
                                      height: 30,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text(
                                      "Start",
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color:
                                              Color.fromRGBO(37, 95, 213, 1)),
                                    ),
                                  ],
                                ),
                              ),
                            const SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Stream<List<Map<String, dynamic>>> fetchAssessments() {
    return FirebaseFirestore.instance.collection('assessments').snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList());
  }

  Widget _buildAppointmentsContent() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('appointments').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        var appointments = snapshot.data!.docs;

        return GridView.builder(
          padding: const EdgeInsets.all(8.0),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
            childAspectRatio: 2.3 / 2,
          ),
          itemCount: appointments.length,
          itemBuilder: (context, index) {
            var appointment = appointments[index];
            return _buildAppointmentCard(
              appointment['title'],
              appointment['icon'],
              appointment['color'], // Fetching the color value from Firestore
            );
          },
        );
      },
    );
  }

  Widget _buildAppointmentCard(
      String title, String imageUrl, String colorValue) {
    Color backgroundColor =
        Color(int.parse(colorValue.replaceFirst('#', '0xFF')));

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 5,
          ),
          SvgPicture.network(
            imageUrl,
            height: 60,
            width: 60,
            placeholderBuilder: (context) => const CircularProgressIndicator(),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: Color.fromRGBO(34, 46, 88, 1),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
