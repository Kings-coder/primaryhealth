import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../AdminPanel/model/menu_modal.dart';
import '../../../../AdminPanel/responsive.dart'; // Correct the import for SvgPicture

class UserMenu extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final ValueChanged<int>? onPageSelected;

  const UserMenu({Key? key, required this.scaffoldKey, this.onPageSelected})
      : super(key: key);

  @override
  _UserMenuState createState() => _UserMenuState();
}

class _UserMenuState extends State<UserMenu> {
  List<MenuModel> menu = [
    MenuModel(icon: 'assets/svg/home.svg', title: "Dashboard"),
    MenuModel(icon: 'assets/svg/remote.svg', title: "Patient List"),
    MenuModel(icon: 'assets/svg/remote.svg', title: "patients Triage"),
    MenuModel(icon: 'assets/svg/share-2.svg', title: "Patients Triage table"),
    MenuModel(icon: 'assets/svg/setting.svg', title: "patient List Medical"),
    MenuModel(icon: 'assets/svg/profile.svg', title: "About Us"),
    MenuModel(icon: 'assets/svg/signout.svg', title: "Exit"),
  ];

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colors.grey[800]!,
            width: 1,
          ),
        ),
        color: const Color(0xFF171821),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: Responsive.isMobile(context) ? 40 : 80,
              ),
              for (var i = 0; i < menu.length; i++)
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(6.0),
                    ),
                    color: selected == i
                        ? Theme.of(context).primaryColor
                        : Colors.transparent,
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selected = i;
                      });
                      widget.scaffoldKey.currentState!
                          .openEndDrawer(); // Use openEndDrawer to open the drawer from the right

                      // Invoke the onPageSelected callback when a menu item is selected
                      widget.onPageSelected?.call(i);

                      // The rest of your code for navigation can remain the same
                      switch (i) {
                        case 0: // Dashboard
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) =>
                          //         const MyAppAdmin(), // Replace with the correct page widget
                          //   ),
                          // );
                          break;
                        case 1: // Controller
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) =>
                          //         const ControllerPage(), // Replace with the correct page widget
                          //   ),
                          // );
                          break;
                        // Add similar cases for other menu items
                        case 2: // Connect
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) =>
                          //         const ControllerPage(), // Replace with the correct page widget
                          //   ),
                          // );
                          break;
                        case 3: // Payment
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) =>
                          //         const ControllerPage(), // Replace with the correct page widget
                          //   ),
                          // );
                          break;
                        case 4: // History
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) =>
                          //         const ControllerPage(), // Replace with the correct page widget
                          //   ),
                          // );
                          break;
                        case 5: // Settings
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) =>
                          //         const ControllerPage(), // Replace with the correct page widget
                          //   ),
                          // );
                          break;
                        case 6: // About Us
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) =>
                          //         const AboutUsPage(), // Replace with the correct page widget
                          //   ),
                          // );
                          break;
                        case 7: // Exit
                          // Handle exit logic
                          break;
                      }
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 13,
                            vertical: 7,
                          ),
                          child: SvgPicture.asset(
                            menu[i].icon,
                            color: selected == i ? Colors.black : Colors.grey,
                          ),
                        ),
                        Text(
                          menu[i].title,
                          style: TextStyle(
                            fontSize: 16,
                            color: selected == i ? Colors.black : Colors.grey,
                            fontWeight: selected == i
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        )
                      ],
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
