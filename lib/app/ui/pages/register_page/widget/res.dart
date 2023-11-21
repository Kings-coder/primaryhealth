import 'package:clearance_system/app/ui/pages/home_page/home_page.dart';
import 'package:clearance_system/app/ui/pages/home_page/widgets/show_payment.dart';
import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  PageController pageController = PageController();
  SideMenuController sideMenu = SideMenuController();

  bool isCardExpanded = false;

  final TextEditingController _textFieldController = TextEditingController();

  late AnimationController _animationController;

  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: toggleCard,
        backgroundColor: Colors.blue[900],
        child: const Icon(Icons.message),
      ),
      body: Stack(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SideMenu(
                  controller: sideMenu,
                  style: SideMenuStyle(
                    // showTooltip: false,
                    displayMode: SideMenuDisplayMode.auto,
                    hoverColor: Colors.blue[100],
                    selectedHoverColor: Colors.blue[100],
                    selectedColor: Colors.lightBlue,
                    selectedTitleTextStyle:
                        const TextStyle(color: Colors.white),
                    selectedIconColor: Colors.white,
                    // decoration: BoxDecoration(
                    //   borderRadius: BorderRadius.all(Radius.circular(10)),
                    // ),
                    // backgroundColor: Colors.blueGrey[700]
                  ),
                  title: Column(
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 150,
                          maxWidth: 150,
                        ),
                        child: Image.asset(
                          'assets/images/igna-removebg-preview.png',
                        ),
                      ),
                      const Divider(
                        indent: 8.0,
                        endIndent: 8.0,
                      ),
                    ],
                  ),
                  footer: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.lightBlue[100],
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 10),
                        child: Text(
                          'PRIMARY HEALTH CARE',
                          style:
                              TextStyle(fontSize: 15, color: Colors.grey[800]),
                        ),
                      ),
                    ),
                  ),
                  items: [
                    SideMenuItem(
                      title: 'Dashboard',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(Icons.home),
                      badgeContent: const Text(
                        '3',
                        style: TextStyle(color: Colors.white),
                      ),
                      tooltipContent: "This is a tooltip for Dashboard item",
                    ),
                    SideMenuItem(
                      title: 'Patient List',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(Icons.supervisor_account),
                    ),
                    SideMenuItem(
                      title: 'HeathCare News',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(Icons.file_copy_rounded),
                      trailing: Container(
                          decoration: const BoxDecoration(
                              color: Colors.amber,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6.0, vertical: 3),
                            child: Text(
                              'New',
                              style: TextStyle(
                                  fontSize: 11, color: Colors.grey[800]),
                            ),
                          )),
                    ),
                    // SideMenuItem(
                    //   title: 'Student News',
                    //   onTap: (index, _) {
                    //     sideMenu.changePage(index);
                    //   },
                    //   icon: const Icon(Icons.download),
                    // ),
                    SideMenuItem(
                      builder: (context, displayMode) {
                        return const Divider(
                          endIndent: 8,
                          indent: 8,
                        );
                      },
                    ),
                    SideMenuItem(
                      title: 'Settings',
                      onTap: (index, _) {
                        sideMenu.changePage(index);
                      },
                      icon: const Icon(Icons.settings),
                    ),
                    // SideMenuItem(
                    //   onTap:(index, _){
                    //     sideMenu.changePage(index);
                    //   },
                    //   icon: const Icon(Icons.image_rounded),
                    // ),
                    // SideMenuItem(
                    //   title: 'Only Title',
                    //   onTap:(index, _){
                    //     sideMenu.changePage(index);
                    //   },
                    // ),
                    const SideMenuItem(
                      title: 'Exit',
                      icon: Icon(Icons.exit_to_app),
                    ),
                  ],
                ),
                Expanded(
                  child: PageView(
                    controller: pageController,
                    children: [
                      const HomePage(),
                      const PaymentHistoryTable(),
                      Container(
                        color: Colors.white,
                        child: const Center(
                          child: Text(
                            'Files',
                            style: TextStyle(fontSize: 35),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: const Center(
                          child: Text(
                            'Download',
                            style: TextStyle(fontSize: 35),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: const Center(
                          child: Text(
                            'Settings',
                            style: TextStyle(fontSize: 35),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: const Center(
                          child: Text(
                            'Only Title',
                            style: TextStyle(fontSize: 35),
                          ),
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        child: const Center(
                          child: Text(
                            'Only Icon',
                            style: TextStyle(fontSize: 35),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
                                // Send message logic
                                print(_textFieldController.text);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  fixedSize: const Size(100, 29)),
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
          ),
        ],
      ),
    );
  }
}
