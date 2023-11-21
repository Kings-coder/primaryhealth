// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../controllers/patient_register_controller.dart';

class PatientRegisterDesktop extends StatefulWidget {
  const PatientRegisterDesktop({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  State<PatientRegisterDesktop> createState() => _PatientRegisterDesktopState();
}

class _PatientRegisterDesktopState extends State<PatientRegisterDesktop> {
  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    Get.put(PatientController());

    return GetBuilder<PatientController>(builder: (controller) {
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
                style: GoogleFonts.inter(
                  fontSize: 23,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 35),

              // Name Field
              TextFormField(
                controller: controller.patientIdController,
                decoration: const InputDecoration(
                  labelText: 'Patient Id',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // Department Field
              TextFormField(
                controller: controller.fullNameController,
                decoration: const InputDecoration(
                  labelText: 'full name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              const SizedBox(height: 10),
              // LGA Field
              TextFormField(
                controller: controller.ageController,
                decoration: const InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // Phone No Field
              TextFormField(
                controller: controller.phoneNoController,
                decoration: const InputDecoration(
                  labelText: 'Phone No',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              // Email Field
              TextFormField(
                controller: controller.genderController,
                decoration: const InputDecoration(
                  labelText: 'Gender',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),

              TextFormField(
                controller: controller.stateController,
                decoration: const InputDecoration(
                  labelText: 'State',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.lgaController,
                decoration: const InputDecoration(
                  labelText: 'LGA',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.homeTownController,
                decoration: const InputDecoration(
                  labelText: 'Home Town',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.maritalStatusController,
                decoration: const InputDecoration(
                  labelText: 'Marital status',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.currentAdddresscontroller,
                decoration: const InputDecoration(
                  labelText: 'Current Address',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "PARENT OR GUIDIAN",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.parentFullNameController,
                decoration: const InputDecoration(
                  labelText: 'fullname',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.relationshipToChildController,
                decoration: const InputDecoration(
                  labelText: 'relationship to child',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: controller.parentPhoneNumberController,
                decoration: const InputDecoration(
                  labelText: 'Phonenumber',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 10),
              const SizedBox(height: 25),
              const SizedBox(height: 30),
              controller.isBusy
                  ? const Center(
                      child: CircularProgressIndicator(color: Colors.green),
                    )
                  : TextButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();

                        if (controller
                                .currentAdddresscontroller.text.isEmpty ||
                            controller.patientIdController.text.isEmpty ||
                            controller.fullNameController.text.isEmpty ||
                            controller.ageController.text.isEmpty ||
                            controller.phoneNoController.text.isEmpty ||
                            controller.genderController.text.isEmpty ||
                            controller.stateController.text.isEmpty ||
                            controller.lgaController.text.isEmpty ||
                            controller.homeTownController.text.isEmpty ||
                            controller.maritalStatusController.text.isEmpty ||
                            controller
                                .parentFullNameController.text.isEmpty ||
                            controller
                                .relationshipToChildController.text.isEmpty ||
                            controller
                                .parentPhoneNumberController.text.isEmpty) {
                          controller.borderColor = Colors.red;
                          controller.textColor = Colors.red;
                          controller.errorMessage = 'All is required';
                        } else {
                          controller.borderColor = const Color(0xffeaebed);
                          controller.errorMessage = '';
                          controller.saveDataToFirestore(context);
                        }
                      },
                      child: Container(
                        width: 300 * fem,
                        height: 10 * fem,
                        decoration: BoxDecoration(
                          color: Colors.blue[900],
                          borderRadius: BorderRadius.circular(3 * fem),
                        ),
                        child: Center(
                          child: Text(
                            'Register Patient',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
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
