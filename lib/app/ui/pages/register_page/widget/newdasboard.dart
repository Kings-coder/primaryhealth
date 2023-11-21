import 'package:clearance_system/app/ui/pages/landing_page/landing_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../AdminPanel/responsive.dart';
import '../../../../AdminPanel/widgets/menu.dart';
import '../../../../AdminPanel/widgets/profile/profile.dart';
import '../../home_page/home_page.dart';
import '../../nurse_page/patient_medication.dart';
import '../../nurse_page/patient_test_table.dart';
import '../../nurse_page/patient_testpage.dart';
import '../patient_rgister/patient_dta.dart';
import 'new_menu.dart';

class UserDashBoard extends StatefulWidget {
  const UserDashBoard({Key? key}) : super(key: key);

  @override
  _UserDashBoardState createState() => _UserDashBoardState();
}

class _UserDashBoardState extends State<UserDashBoard>
    with SingleTickerProviderStateMixin {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  bool isCardExpanded = false;

  final TextEditingController _textFieldController = TextEditingController();

  late AnimationController _animationController;

  late Animation<double> _animation;
  final List<String> messages = [];
  @override
  void initState() {
    super.initState();

    // Add a listener to Firestore to update messages in real-time
    // _firestore.collection('messages').snapshots().listen((snapshot) {
    //   for (var doc in snapshot.docs) {
    //     final messageText = doc['text'];
    //     setState(() {
    //       messages.add(messageText);
    //     });
    //   }
    // });

    sideMenu.addListener((index) {
      pageController.jumpToPage(index);
    });

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  void toggleCard() {
    setState(() {
      isCardExpanded = !isCardExpanded;
      if (isCardExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final PageController _pageController = PageController();
  int currentPage = 0;

  void _navigateToPage(int pageIndex) {
    setState(() {
      currentPage = pageIndex;
      _pageController.jumpToPage(pageIndex);
    });
  }

  Future<void> _handleSignOut() async {
    final FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth.signOut();
      Get.offAll(() => const LandingPage());
      // You can add additional code to navigate to the login screen or perform other actions after logout.
    } catch (e) {
      print("Error during sign out: $e");
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String message) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        // Do not clear the existing messages, just add the new one
        setState(() {
          messages.add(message);
        });
        _textFieldController.clear(); // Clear the text field
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Message sent successfully'),
        ));

        // Save the message to Firestore
        await _firestore.collection('messages').add({
          'text': message,
          'userId': user.uid,
          'timestamp': FieldValue.serverTimestamp(),
        });
      } else {
        // Handle user not logged in
      }
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: !Responsive.isDesktop(context)
          ? SizedBox(
              width: 250,
              child: Menu(
                  scaffoldKey: _scaffoldKey, onPageSelected: _navigateToPage))
          : null,
      endDrawer: Responsive.isMobile(context)
          ? SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: const Profile(),
            )
          : null,
      floatingActionButton: FloatingActionButton(
        onPressed: toggleCard,
        backgroundColor: Colors.blue[900],
        child: const Icon(Icons.message),
      ),
      body: Stack(
        children: [
          Row(
            children: [
              if (Responsive.isDesktop(context))
                Expanded(
                  flex: 3,
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: UserMenu(
                        scaffoldKey: _scaffoldKey,
                        onPageSelected: _navigateToPage),
                  ),
                ),
              Expanded(
                flex: 8,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                    });
                  },
                  children: [
                    const HomePage(),
                    const PatientDataTable(),
                    const NurseTestReportScreen(),
                    PatientTestReportsPage(),
                    PatientListScreen(),
                    
                    Container(
                      color: Colors.white,
                      child: const Center(
                        child: Text(
                          'About',
                          style: TextStyle(fontSize: 35),
                        ),
                      ),
                    ),
                   
                    Container(
                      color: Colors.white,
                      child: Center(
                        child: TextButton(
                          onPressed: () {
                            _handleSignOut();
                          },
                          child: Container(
                            width: 300,
                            height: 30,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(94, 249, 2, 2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                'Sign Out',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  // height: 1.5 * ffem / fem,
                                  color: const Color(0xffffffff),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // if (!Responsive.isMobile(context))
              //   const Expanded(
              //     flex: 4,
              //     child: Profile(),
              //   ),
            ],
          ),
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Positioned(
                bottom: Get.height * 0.14 - (40 * _animation.value),
                left: Get.width * 0.7,
                right: 50,
                child: Opacity(
                  opacity: _animation.value,
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      height: Get.height * 0.4,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'How can we assist you?',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Expanded(
                            child: ListView.builder(
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                return Text(messages[index]);
                              },
                            ),
                          ),
                          TextField(
                            controller: _textFieldController,
                            decoration: const InputDecoration(
                              hintText: 'Type your message...',
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () {
                                final message = _textFieldController.text;
                                if (message.isNotEmpty) {
                                  sendMessage(message);
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                fixedSize: const Size(100, 29),
                              ),
                              child: const Text(
                                'Send',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
