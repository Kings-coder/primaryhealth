// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:clearance_system/app/ui/pages/login_page/login_page.dart';
import 'package:clearance_system/app/ui/pages/register_page/widget/newdasboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../register_page/register_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          const HeroImageWidget(),
          // Menu
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 35, sigmaY: 35),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.5, 0.5),
                  end: Alignment(0.5, 0.5),
                  colors: [Color(0xFFAEA9A9), Color(0x00897E7E)],
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "HEALTH CARE MANAGEMENT SYSTEM",
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MenuItem(
                      text: "Doctor",
                      onTap: () {
                        // User? user = FirebaseAuth.instance.currentUser;

                        // if (user != null) {
                        //   // User is already logged in, navigate to Dashboard
                        //   Get.to(() => const UserDashBoard());
                        // } else {
                        // User is not logged in, navigate to AdminLoginPage
                        Get.to(() => const LoginPage());
                        //}
                      },
                    ),
                    MenuItem(
                      text: "Nurse",
                      onTap: () {
                        // User? user = FirebaseAuth.instance.currentUser;

                        // if (user != null) {
                        //   // User is already logged in, navigate to Dashboard
                        //   Get.to(() => const UserDashBoard());
                        // } else {
                        // User is not logged in, navigate to AdminLoginPage
                        Get.to(() => const LoginPage());
                        //}
                      },
                    ),
                    MenuItem(
                      text: "Admin",
                      onTap: () {
                        // User? user = FirebaseAuth.instance.currentUser;

                        // if (user != null) {
                        //   // User is already logged in, navigate to Dashboard
                        //   Get.to(() => const DashBoard());
                        // } else {
                        // User is not logged in, navigate to AdminLoginPage
                        Get.to(() => const LoginPage());
                        //}
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Image
        ],
      ),
    );
  }
}

class HeroImageWidget extends StatelessWidget {
  const HeroImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: Get.width,
          height: Get.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image:
                  AssetImage('assets/images/health.jpg'), // Add your hero image
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}

class ContactInformationWidget extends StatelessWidget {
  const ContactInformationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200], // Background color
        borderRadius: BorderRadius.circular(10.0), // Add rounded corners
      ),
      child: const Column(
        children: <Widget>[
          Text(
            "Contact Us",
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          ListTile(
            leading: Icon(Icons.email),
            title: Text(
              "Email:",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Text("contact@concordia.edu"),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text(
              "Phone:",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Text("+1 (123) 456-7890"),
          ),
        ],
      ),
    );
  }
}

class TestimonialsWidget extends StatelessWidget {
  const TestimonialsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample list of testimonials
    List<Map<String, String>> testimonials = [
      {
        'name': "John Doe",
        'comment': "Captain Elechi Amadi Polytechnic is a great institution!",
      },
      {
        'name': "Jane Smith",
        'comment': "I had a fantastic experience at this polytechnic.",
      },
      {
        'name': "Mary Johnson",
        'comment': "The staff is dedicated and supportive. Highly recommended.",
      },
      // Add more testimonials
    ];

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          const Text(
            "What People Are Saying",
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          Center(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: testimonials.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(testimonials[index]['comment']!),
                  subtitle: Text("- ${testimonials[index]['name']}"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OurSchool extends StatelessWidget {
  const OurSchool({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample list of testimonials
    List testimonials = [
      "assets/images/1.jpeg",
      "assets/images/3.jpeg",
      "assets/images/2.jpeg",
      "assets/images/4.jpeg",
      "assets/images/5.jpeg",
      "assets/images/6.jpeg",
      "assets/images/7.jpeg",
      "assets/images/8.jpeg",
      "assets/images/9.jpeg",
      "assets/images/1.jpeg",
    ];

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          const Text(
            "Our School",
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          Center(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5, // Number of columns in the grid
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 30.0,
              ),
              shrinkWrap: true,
              itemCount: testimonials.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  height: 300,
                  width: 300,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      testimonials[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  final String text;
  final GestureTapCallback onTap;
  const MenuItem({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        shadowColor: Colors.blue[900],
        elevation: 12,
        color: const Color.fromARGB(255, 103, 103, 104),
        child: SizedBox(
          height: 180,
          width: 300,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: const TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterButton extends StatelessWidget {
  const RegisterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          // User is already logged in, navigate to Dashboard
          Get.to(() => const UserDashBoard());
        } else {
          // User is not logged in, navigate to AdminLoginPage
          Get.to(() => const RegisterPage());
        }
        //Get.to(() => const RegisterPage());
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 160, 0, 0), // Text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 3.0, // Shadow
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      ),
      child: const Text(
        'Register',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.blue, // Footer background color
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text(
            "© 2023 Captain Elechi Amadi Polytechnic. All rights reserved.",
            style: TextStyle(color: Colors.white),
          ),
          Row(
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.facebook),
                onPressed: () {
                  // Handle social media links
                },
              ),
              IconButton(
                icon: const Icon(Icons.flutter_dash),
                onPressed: () {
                  // Handle social media links
                },
              ),
              IconButton(
                icon: const Icon(Icons.abc),
                onPressed: () {
                  // Handle social media links
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
