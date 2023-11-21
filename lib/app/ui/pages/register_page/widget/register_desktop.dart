// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:clearance_system/app/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:google_fonts/google_fonts.dart';

class RegisterDesktop extends StatefulWidget {
  const RegisterDesktop({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  State<RegisterDesktop> createState() => _RegisterDesktopState();
}

class _RegisterDesktopState extends State<RegisterDesktop> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    Get.put(RegisterController());

    return GetBuilder<RegisterController>(builder: (controller) {
      return Container(
        constraints: const BoxConstraints(maxWidth: 21),
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Text(
              //   'Welcome back',
              //   style: GoogleFonts.inter(
              //     fontSize: 17,
              //     color: Colors.black,
              //   ),
              // ),
              // const SizedBox(height: 8),
              Text(
                widget.text,
                style: const TextStyle(
                  fontSize: 23,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 35),

              // Name Field
              TextFormField(
                controller: controller.nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // Department Field
              TextFormField(
                controller: controller.departmentController,
                decoration: const InputDecoration(
                  labelText: 'Department',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // State of Origin Field
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                width: 130,
                height: 50,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        width: 0.50, color: Color.fromARGB(255, 86, 86, 86)),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: controller.selectedState,
                    hint: const Text('Select a state'),
                    onChanged: (String? newValue) {
                      setState(() {
                        controller.selectedState = newValue;
                      });
                    },
                    items: controller.states.map((String state) {
                      return DropdownMenuItem<String>(
                        value: state,
                        child: Text(state),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
// State of Origin Field
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                width: 130,
                height: 50,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                        width: 0.50, color: Color.fromARGB(255, 86, 86, 86)),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: controller.selectedRole,
                    hint: const Text('Select a Role'),
                    onChanged: (String? newValue) {
                      setState(() {
                        controller.selectedRole = newValue;
                      });
                    },
                    items: controller.roles.map((String role) {
                      return DropdownMenuItem<String>(
                        value: role,
                        child: Text(role),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              // LGA Field
              TextFormField(
                controller: controller.lgaController,
                decoration: const InputDecoration(
                  labelText: 'LGA',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // Phone No Field
              TextFormField(
                controller: controller.phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone No',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // Email Field
              TextFormField(
                controller: controller.emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // Password Field
              TextFormField(
                onTap: () {
                  controller.passtextColor = const Color(0xff9ca3af);
                  controller.passerrorMessage = '';
                  controller.passborderColor = const Color(0xffeaebed);
                },
                obscureText: controller.obscure,
                controller: controller.passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.onChangeObscure();
                    },
                    icon: Icon(
                      controller.obscure
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  ),
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 25),
              const SizedBox(height: 30),
              controller.isBusy
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.green),
                    )
                  : TextButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();

                        if (controller.emailController.text.isEmpty ||
                            controller.passwordController.text.isEmpty ||
                            controller.nameController.text.isEmpty ||
                            controller.departmentController.text.isEmpty ||
                            controller.selectedState!.isEmpty ||
                            controller.lgaController.text.isEmpty ||
                            controller.phoneController.text.isEmpty) {
                          controller.borderColor = Colors.red;
                          controller.textColor = Colors.red;
                          controller.errorMessage = 'All is required';
                        } else if (controller.passwordController.text.isEmpty) {
                          controller.passborderColor = Colors.red;
                          controller.passerrorMessage = 'Password is required';
                          controller.passtextColor = Colors.red;
                        } else {
                          controller.borderColor = const Color(0xffeaebed);
                          controller.errorMessage = '';
                          controller.registerUser(
                              controller.nameController.text,
                              controller.departmentController.text,
                              controller.selectedState!,
                              controller.lgaController.text,
                              controller.phoneController.text,
                              controller.emailController.text,
                              controller.passwordController.text,
                              context);
                        }
                      },
                      child: Container(
                        width: 300 * fem,
                        height: 10 * fem,
                        decoration: BoxDecoration(
                          color: controller.emailController.text.isEmpty ||
                                  controller.passwordController.text.isEmpty
                              ? const Color.fromARGB(94, 127, 128, 127)
                              : Colors.blue[900],
                          borderRadius: BorderRadius.circular(3 * fem),
                        ),
                        child: Center(
                          child: Text(
                            'Sign Up',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 6 * ffem,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xffffffff),
                            ),
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 15),
              // Center(
              //   child: TextButton(
              //     child: const Text("Go to Login Screen"),
              //     onPressed: () {
              //       Get.offAll(() => const LoginPage());
              //     },
              //   ),
              // ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      );
    });
  }
}
