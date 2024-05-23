import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_wealth/src/common_widgets/custom_textfield.dart';
import 'package:my_wealth/src/constarits/colors.dart';
import 'package:my_wealth/src/constarits/image_strings.dart';
import 'package:my_wealth/src/constarits/server.dart';
import 'package:my_wealth/src/utils/storage.dart';
import 'package:my_wealth/src/constarits/text_strings.dart';
import 'package:http/http.dart' as http;
import 'package:my_wealth/src/features/authentication/screens/login/login_screen.dart';

import '../../../core/mainpage.dart';
import '../profile_verify_screen/profile_verify_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController referralController = TextEditingController();

  int _currentStep = 0;
  bool _showReferralStep = true;
  bool _showEmailStep = false;
  String errorMsg = "";

  void _nextStep() {
    setState(() {
      errorMsg = "";
      if (_currentStep == 0) {
        // _showReferralStep = false;
        // _showEmailStep = true;
        // _currentStep = 1;
        chechRef();
      } else {
        // Handle form submission
      }
    });
  }

  void chechRef() async {
    try {
      final adminResponse = await http.get(
        Uri.parse(API_URL +
            'search_admin_referral?adminReferral=' +
            referralController.text),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      final userResponse = await http.get(
        Uri.parse(API_URL +
            'check_my_referral?myReferral=' +
            referralController.text),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (json.decode(adminResponse.body)['code'] == 200 ||
          json.decode(userResponse.body)['code'] == 200) {
        setState(() {
          _showReferralStep = false;
          _showEmailStep = true;
          _currentStep = 1;
        });
      } else {
        setState(() {
          errorMsg = "Referral is not found.";
        });
      }
    } catch (e) {
      setState(() {
        errorMsg = e.toString();
      });
    }
  }

  void _previousStep() {
    setState(() {
      if (_currentStep == 1) {
        _showEmailStep = false;
        _showReferralStep = true;
        _currentStep = 0;
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
          "Create an account",
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
            JoinMyWealthHeader(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.08),
            if (_showReferralStep) Step1Widget(context),
            if (_showEmailStep)
              Step2Widget(
                  referralController: referralController,
                  nameController: nameController,
                  emailController: emailController,
                  passwordController: passwordController),
          ],
        ),
      ),
    );
  }

  Column Step1Widget(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              tReferralText,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 5,
            ),
            CustomTextField(
              controller: referralController,
              hintText: 'REFERRAL01MCO',
            ),
            const SizedBox(
              height: 3,
            ),
            Text(
              errorMsg,
              style: TextStyle(fontSize: 12, color: Colors.red),
            ),
            const Text(
              tReferralConditionText,
              style: TextStyle(fontSize: 9),
            ),
          ],
        ),
        const SizedBox(height: 40),
        SizedBox(
          width: double.infinity,
          height: 49,
          child: ElevatedButton(
            onPressed: _nextStep,
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              backgroundColor: MaterialStateProperty.all(authBtnBgColor),
              textStyle: MaterialStateProperty.all(
                const TextStyle(color: Colors.white),
              ),
              minimumSize: MaterialStateProperty.all(
                Size(MediaQuery.of(context).size.width / 2.5, 50),
              ),
            ),
            child: const Text(
              "Next",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}

class JoinMyWealthHeader extends StatelessWidget {
  const JoinMyWealthHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            const Text(
              "Join to",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: authBtnBgColor),
            ),
            const SizedBox(
              width: 5,
            ),
            new SvgPicture.asset(darklogowithtextSvg, width: 120),
          ],
        ),
        InkWell(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginScreen())),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(50)),
            child: const Padding(
              padding:
                  EdgeInsets.only(left: 8.0, right: 8.0, top: 4, bottom: 4),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.square_arrow_right,
                    color: Colors.black54,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Login',
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/*
class Step2Widget extends StatelessWidget {
  const Step2Widget({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
  });

  Column Step2Widget(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Full Name",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 5,
            ),
            CustomTextField(
              controller: nameController,
              hintText: 'Enter your name',
            ),
            const SizedBox(
              height: 3,
            ),
            const Text(
              "Please enter your full name.",
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Email Address",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 5,
            ),
            CustomTextField(
              controller: emailController,
              hintText: 'johnsmith@gmail.com',
            ),
            const SizedBox(
              height: 3,
            ),
            const Text(
              "We will send you an email to verify your account.",
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Password",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 5,
            ),
            CustomTextField(
              controller: passwordController,
              hintText: 'Enter your password',
            ),
          ],
        ),
        const SizedBox(height: 40),
        SizedBox(
          width: double.infinity,
          height: 49,
          child: ElevatedButton(
            onPressed: () {
              _registerUser();
            },
            */
/*style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              backgroundColor: MaterialStateProperty.all(authBtnBgColor),
               textStyle: MaterialStateProperty.all(
                const TextStyle(color: Colors.white),
              ),
              minimumSize: MaterialStateProperty.all(
                Size(MediaQuery.of(context).size.width / 2.5, 50),
              ),
            ),*/
/*

            child: const Text(
              "Create an account",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }

  void _registerUser() async {
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;
    String referral = referralController.text;

    print(name);
    print(email);
    print(password);
    print(referral);

    try {
      final responce = await http.post(
        Uri.parse(API_URL + '/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'cusName': name,
          'imgURL': "",
          'referal': referral,
          'email': email,
          'RT': false,
          'STP': false,
          'password': password
        }),
      );
      print(responce);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } catch (e) {
      print("eeeeeeeeeeeeeeeeeeee");
      print(e);
    }
  }
}

class JoinMyWealthHeader extends StatelessWidget {
  const JoinMyWealthHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            const Text(
              "Join to",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                  color: authBtnBgColor),
            ),
            const SizedBox(
              width: 5,
            ),
            new SvgPicture.asset(darklogowithtextSvg, width: 120),
          ],
        ),
        InkWell(
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginScreen())),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.black54),
                borderRadius: BorderRadius.circular(50)),
            child: const Padding(
              padding:
                  EdgeInsets.only(left: 8.0, right: 8.0, top: 4, bottom: 4),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.square_arrow_right,
                    color: Colors.black54,
                    size: 20,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Login',
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
*/
class Step2Widget extends StatefulWidget {
  const Step2Widget({
    Key? key,
    required this.referralController,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  final TextEditingController referralController;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  _Step2WidgetState createState() => _Step2WidgetState();
}

class _Step2WidgetState extends State<Step2Widget> {
  String errorMsg = '';

  void _registerUser() async {
    setState(() {
      errorMsg = "";
    });
    String name = widget.nameController.text;
    String email = widget.emailController.text;
    String password = widget.passwordController.text;
    String referral = widget.referralController.text;

    final bodyData = <String, dynamic>{};
    bodyData['friendReferral'] = referral;
    bodyData['name'] = name;
    bodyData['email'] = email;
    bodyData['password'] = password;
    bodyData['packageID'] = '1';

    try {
      final responce =
          await http.post(Uri.parse(API_URL + 'user_register'), body: bodyData);
      var responseBody = json.decode(responce.body);
      if (responseBody["code"] == 200) {
        storage.setItem('userDetails', responseBody);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => MainPage()));
      } else {
        setState(() {
          errorMsg = responseBody["message"];
        });
      }
    } catch (e) {
      setState(() {
        errorMsg = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Full Name",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 5,
            ),
            CustomTextField(
              controller: widget.nameController,
              hintText: 'Enter your name',
            ),
            const SizedBox(
              height: 3,
            ),
            const Text(
              "Please enter your full name.",
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Email Address",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 5,
            ),
            CustomTextField(
              controller: widget.emailController,
              hintText: 'johnsmith@gmail.com',
            ),
            const SizedBox(
              height: 3,
            ),
            const Text(
              "We will send you an email to verify your account.",
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Password",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 5,
            ),
            CustomTextField(
              controller: widget.passwordController,
              hintText: 'Enter your password',
            ),
          ],
        ),
        const SizedBox(height: 40),
        Text(
          errorMsg,
          style: TextStyle(fontSize: 12, color: Colors.red),
        ),
        SizedBox(
          width: double.infinity,
          height: 49,
          child: ElevatedButton(
            onPressed: _registerUser,
            // onPressed: () async {
            //   final responseCode = await _registerUser();
            //   if (responseCode == 200) {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => ProfileVerifyScreen()));
            //   }
            // },
            style: ButtonStyle(
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              backgroundColor: MaterialStateProperty.all(authBtnBgColor),
              textStyle: MaterialStateProperty.all(
                const TextStyle(color: Colors.white),
              ),
              minimumSize: MaterialStateProperty.all(
                Size(MediaQuery.of(context).size.width / 2.5, 50),
              ),
            ),
            child: const Text(
              "Create an account",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
