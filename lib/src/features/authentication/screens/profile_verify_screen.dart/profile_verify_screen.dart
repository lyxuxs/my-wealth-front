import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_wealth/src/constarits/colors.dart';
import 'package:my_wealth/src/constarits/image_strings.dart';
import 'package:my_wealth/src/features/authentication/screens/signup/signup_scren.dart';

class ProfileVerifyScreen extends StatefulWidget {
  const ProfileVerifyScreen({super.key});

  @override
  State<ProfileVerifyScreen> createState() => _ProfileVerifyScreenState();
}

class _ProfileVerifyScreenState extends State<ProfileVerifyScreen> {
  int _currentStep = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Verify your account",
          style: TextStyle(
              color: authBtnBgColor, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: bgColor,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // const Text(
                //   "Join to",
                //   style: TextStyle(
                //       fontSize: 22,
                //       fontWeight: FontWeight.w500,
                //       color: authBtnBgColor),
                // ),
                const SizedBox(
                  width: 5,
                ),
                new SvgPicture.asset(darklogowithtextSvg, width: 120),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            Stepper(
              steps: [
                Step(
                  isActive: _currentStep == 0,
                  title: Text('step 1'), 
                  content: Text('Information step 1'),),
                Step(
                  isActive: _currentStep == 1,
                  title: Text('step 1'), 
                  content: Text('Information step 1'),),
                Step(
                  isActive: _currentStep == 2,
                  title: Text('step 1'), 
                  content: Text('Information step 1'),),
              ],
              onStepTapped: (int newIndex) {
                setState(() {
                  _currentStep = newIndex;
                });
              },
              currentStep: _currentStep,
              onStepContinue: () {
                if (_currentStep != 2) {
                  setState(() {
                    _currentStep += 1;
                  });
                }
              },
              onStepCancel: () {
                if (_currentStep != 0) {
                  setState(() {
                    _currentStep -= 1;
                  });
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
