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
  void goToNextStep() {
    setState(() {
      if (_currentStep < 2) {
        _currentStep++;
      }
    });
  }

  void goToPreviousStep() {
    setState(() {
      if (_currentStep > 0) {
        _currentStep--;
      }
    });
  }

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
            SizedBox(height: MediaQuery.of(context).size.height * 0.04),
            Column(
              children: [
                StepWidget(
                  isActive: _currentStep >= 0,
                  title: 'Step 1',
                  content: _currentStep == 0
                      ? Column(
                          children: [
                            Text('Content for Step 1'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: goToNextStep,
                                  child: Text('Next'),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Container(
                          child: Icon(Icons.check, color: Colors.green),
                        ),
                ),
                StepWidget(
                  isActive: _currentStep >= 1,
                  title: 'Step 2',
                  content: _currentStep == 1
                      ? Column(
                          children: [
                            Text('Content for Step 2'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: goToPreviousStep,
                                  child: Text('Previous'),
                                ),
                                ElevatedButton(
                                  onPressed: goToNextStep,
                                  child: Text('Next'),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Container(
                          child: Icon(Icons.check, color: Colors.green),
                        ),
                ),
                StepWidget(
                  isActive: _currentStep >= 2,
                  title: 'Step 3',
                  content: _currentStep == 2
                      ? Column(
                          children: [
                            Text('Content for Step 3'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: goToPreviousStep,
                                  child: Text('Previous'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    // Handle submission logic here
                                  },
                                  child: Text('Submit'),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Container(
                          child: Icon(Icons.check, color: Colors.green),
                        ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class StepWidget extends StatelessWidget {
  final bool isActive;
  final String title;
  final Widget content;

  StepWidget(
      {required this.isActive, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isActive ? Colors.green : Colors.grey,
              ),
              child: Center(
                child: Text(
                  isActive ? '✓' : '',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(width: 12),
            Text(title),
          ],
        ),
        SizedBox(height: 8),
        content,
      ],
    );
  }
}
