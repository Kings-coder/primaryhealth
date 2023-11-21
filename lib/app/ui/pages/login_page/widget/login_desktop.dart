import 'package:clearance_system/app/controllers/login_controller.dart';
import 'package:clearance_system/app/ui/pages/register_page/register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../global_widgets/ListTileWithStartIcon.dart';

class LoginDesktop extends StatelessWidget {
  const LoginDesktop({super.key});

  final bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    final screenHeight = MediaQuery.of(context).size.height;
    LoginController controller = Get.put(LoginController());
    return GetBuilder<LoginController>(builder: (controller) {
      return Row(
        children: [
          Expanded(
              //<-- Expanded widget
              child: Container(
            color: Colors.blue[900],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxHeight: 200,
                      maxWidth: 200,
                    ),
                    child: Image.asset(
                      'assets/images/igna-removebg-preview.png',
                    ),
                  ),
                  Text(
                    "HEALTHCARE MANAGEMENT SYSTEM",
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(255, 255, 255, 255),
                    ),
                  )
                ],
              ),
            ),
          )),
          Expanded(
            //<-- Expanded widget
            child: Container(
              constraints: const BoxConstraints(maxWidth: 21),
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Welcome back',
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Login to your account',
                    style: GoogleFonts.inter(
                      fontSize: 23,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 35),
                  const Text("Email Address"),
                  const SizedBox(height: 10),
                  textFeildWithOutBorders(
                    ontap: () {
                      controller.errorMessage = ''; // clear error message
                      controller.textColor = const Color(0xff9ca3af);
                      controller.borderColor = const Color(0xffeaebed);
                    },
                    controller: controller.emailController,
                    obscuretext: false,
                  ),
                  const SizedBox(height: 20),
                  const Text("Password"),
                  const SizedBox(height: 10),
                  textFeildWithOutBorders(
                      ontap: () {
                        controller.passtextColor = const Color(0xff9ca3af);
                        controller.passerrorMessage = '';
                        controller.passborderColor = const Color(0xffeaebed);
                      },
                      obscuretext: controller.obscure,
                      controller: controller.passwordController,
                      icon: IconButton(
                          onPressed: () {
                            controller.onChangeObscure();
                          },
                          icon: Icon(
                              controller.obscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey))),
                  const SizedBox(height: 25),
                  const Row(
                      //...
                      ),
                  const SizedBox(height: 30),
                  controller.isBusy
                      ? const Center(
                          child: CircularProgressIndicator(color: Colors.green),
                        )
                      : TextButton(
                          onPressed: () {
                            FocusScope.of(context).unfocus();

                            if (controller.emailController.text.isEmpty) {
                              controller.borderColor =
                                  Colors.red; // set border color to red
                              controller.textColor =
                                  Colors.red; // set border color to red
                              controller.errorMessage =
                                  'Email is required'; // show error message
                            } else if (controller
                                .passwordController.text.isEmpty) {
                              controller.passborderColor = Colors.red; // set bo
                              controller.passerrorMessage =
                                  'Password is required'; //
                              controller.passtextColor = Colors.red;
                            } else {
                              controller.borderColor = const Color(
                                  0xffeaebed); // set border color to default
                              controller.errorMessage =
                                  ''; // clear error message
                              // perform
                              controller.login(controller.emailController.text,
                                  controller.passwordController.text, context);
                            }
                          },
                          child: Container(
                            width: 300 * fem,
                            height: 10 * fem,
                            decoration: BoxDecoration(
                              color: controller.emailController.text.isEmpty ||
                                      controller.passwordController.text.isEmpty
                                  ? const Color.fromARGB(94, 73, 73, 73)
                                  : Colors.blue[900],
                              borderRadius: BorderRadius.circular(3 * fem),
                            ),
                            child: Center(
                              child: Text(
                                'Sign in',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: 6 * ffem,
                                  fontWeight: FontWeight.w600,
                                  // height: 1.5 * ffem / fem,
                                  color: const Color(0xffffffff),
                                ),
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(height: 15),
                  // Center(
                  //   child: TextButton(
                  //     child: const Text("Go to Register Screen"),
                  //     onPressed: () {
                  //       Get.offAll(() => const RegisterPage());
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
