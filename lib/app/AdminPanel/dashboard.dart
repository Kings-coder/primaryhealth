import 'package:clearance_system/app/ui/pages/register_page/patient_rgister/patient_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../ui/pages/landing_page/landing_page.dart';
import '../ui/pages/register_page/patient_rgister/patient_dta.dart';
import '../ui/pages/register_page/widget/register_desktop.dart';
import 'pages/assign_patientpage.dart';
import 'pages/home/home_page.dart';
import 'responsive.dart';
import 'widgets/aboutUs.dart';
import 'widgets/menu.dart';
import 'widgets/profile/profile.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
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
      body: SafeArea(
        child: Row(
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Menu(
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
                  HomePage(
                      scaffoldKey:
                          _scaffoldKey), // Replace with your actual pages
                  // Add more pages as needed
                  const PatientDataTable(),
                  const RegisterDesktop(
                    text: 'Register Doctor',
                  ),
                  const RegisterDesktop(
                    text: 'Register Nurse',
                  ),
                  const PatientRegisterDesktop(text: "Register Patient"),
                  const AdminAssignDoctorScreen(),
                  // const AdminStudentHistoryTable1(),
                  // const AdminPaymentHistoryTable(),
                  // const AdminPaymentHistoryTable1(),
                  // const AdminPaymentHistoryTable2(),
                  const AboutUsPage(),
                  Container(
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
                  )
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
      ),
    );
  }
}
