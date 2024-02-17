import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_wealth/src/constarits/colors.dart';
import 'package:my_wealth/src/constarits/image_strings.dart';
import 'package:my_wealth/src/constarits/sizes.dart';
import 'package:my_wealth/src/constarits/text_strings.dart';
import 'package:my_wealth/src/features/authentication/screens/login/login_screen.dart';
import 'package:my_wealth/src/features/authentication/screens/signup/signup_scren.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Image(
                  image: AssetImage(tWelcomeImage),
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 60,
                    left: 30,
                    right: 30,
                    child: SvgPicture.asset(darklogowithtextSvg, width: 165.67, height: 38.93,)
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    AutoSizeText(
                      tWelcomeTitle,
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        height: 1.2
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    AutoSizeText(
                      tWelcomeSubTitle,
                      style: TextStyle(
                        fontFamily: 'PlusJakartaSans',
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: tDarkGrayColor,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: OutlinedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LoginScreen()));
                                },
                                style: OutlinedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9.0)),
                                  foregroundColor: Colors.black,
                                  side: BorderSide(
                                      color: authBtnBgColor, width: 2.0),
                                  padding: EdgeInsets.symmetric(
                                      vertical: tButtonHeight),
                                ),
                                child: Text(
                                  tSignin,
                                  style: TextStyle(
                                    fontFamily: 'PlusJakartaSans',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ))),
                        const SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SignupScreen()));
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(9.0)),
                                  foregroundColor: tWhiteColor,
                                  backgroundColor: authBtnBgColor,
                                  side: BorderSide(
                                      color: authBtnBgColor, width: 2.0),
                                  padding: EdgeInsets.symmetric(
                                      vertical: tButtonHeight),
                                ),
                                child: Text(
                                  tSignup,
                                  style: TextStyle(
                                    fontFamily: 'PlusJakartaSans',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ))),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 5.0,
              ),
              Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  tDemotrade,
                  style: TextStyle(
                      fontFamily: 'PlusJakartaSans',
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: tLightBlueColor),
                ),
              ]),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ),
    );
  }
}



