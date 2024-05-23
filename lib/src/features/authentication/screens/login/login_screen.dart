import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_wealth/src/common_widgets/custom_textfield.dart';
import 'package:my_wealth/src/constarits/colors.dart';
import 'package:my_wealth/src/constarits/server.dart';
import 'package:my_wealth/src/features/authentication/screens/welcome/welcome_screen.dart';
import 'package:http/http.dart' as http;
import 'package:my_wealth/src/utils/storage.dart';
import 'dart:convert';
import 'package:my_wealth/src/features/core/mainpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String errorMsg = '';

  // final AuthService authService = AuthService();

  // void loginUser() {
  //   authService.signInUser(
  //     context: context,
  //     email: emailController.text,
  //     password: passwordController.text,
  //   );
  // }

  // Inside the _LoginScreenState class
  Color buttonColor = Colors.grey;

  // Inside the _LoginScreenState class
  @override
  void initState() {
    super.initState();
    emailController.addListener(updateButtonColor);
    passwordController.addListener(updateButtonColor);
  }

  void updateButtonColor() {
    setState(() {
      if (emailController.text.isNotEmpty &&
          passwordController.text.isNotEmpty) {
        buttonColor = Colors.blue;
      } else {
        buttonColor = Colors.grey;
      }
    });
  }

  @override
  void dispose() {
    emailController.removeListener(updateButtonColor);
    passwordController.removeListener(updateButtonColor);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: bgColor,
        elevation: 0,
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(
              CupertinoIcons.bubble_middle_bottom,
              color: Colors.green,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome Back!",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: authBtnBgColor),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
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
                    hintText: 'example@gmail.com',
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
              Text(
                errorMsg,
                style: TextStyle(fontSize: 12, color: Colors.red),
              ),
              SizedBox(
                width: double.infinity,
                height: 49,
                child: ElevatedButton(
                  onPressed: () {
                    _loginUser();
                  },
                  // emailController.text.isNotEmpty &&
                  //         passwordController.text.isNotEmpty
                  //     ? loginUser
                  //     : null,
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
                    "Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              //  const Center(
              //      child: Text('Forgot Password?',
              //          style: TextStyle(
              //              fontSize: 14,
              //              fontWeight: FontWeight.bold,
              //              color: Colors.green))),
            ],
          ),
        ),
      ),
    );
  }

  void _loginUser() async {
    setState(() {
      errorMsg = "";
    });
    String email = emailController.text;
    String password = passwordController.text;

    final bodyData = <String, dynamic>{};
    bodyData['email'] = email;
    bodyData['password'] = password;

    try {
    
      final responce =
          await http.post(Uri.parse(API_URL + 'user_login'), body: bodyData);
          
      var responseBody = json.decode(responce.body);
      

      if (responseBody["code"] == 200) {
        
        SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('userDetails', json.encode(responseBody));
        storage.setItem('userDetails', responseBody);
        
            await prefs.setBool('isLoggedIn', true);
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
}
