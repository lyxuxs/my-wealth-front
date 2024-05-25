import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:my_wealth/src/constarits/colors.dart';
import 'package:my_wealth/src/constarits/server.dart';
import 'package:my_wealth/src/features/core/mainpage.dart';
import 'package:my_wealth/src/utils/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecurringTrading extends StatefulWidget {
  const RecurringTrading({Key? key}) : super(key: key);

  @override
  State<RecurringTrading> createState() => _RecurringTradingState();
}

class _RecurringTradingState extends State<RecurringTrading> {
  final TextEditingController verifyCodeController = TextEditingController();
  String errorMsg = '';
  String sendMsg = '';
  String buttonText = 'send code';

  @override
  void initState() {
    super.initState();
    verifyCodeController.addListener(() {
      setState(() {
        if (verifyCodeController.text.isEmpty ||
            verifyCodeController.text != '') {
          sendMsg = '';
          errorMsg = '';
          buttonText = 'Verify';
        }
      });
    });
  }

  @override
  void dispose() {
    verifyCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String timeZoneName = now.timeZoneName;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: tLightBlueColor,
        elevation: 0,
        title: const Text(
          "Recurring Trading",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        centerTitle: true,
      ),
      // newly added
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "configure your Recurring Trading (RT) Account",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                height: 1.0,
                color: Color.fromARGB(255, 181, 181, 181).withOpacity(0.3),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: tGrayColor.withOpacity(0.5)),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                    padding: EdgeInsets.only(
                        left: 15, right: 10, top: 10, bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextField(
                          controller: verifyCodeController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter recived verify code',
                          ),
                        ),
                        DottedLine(
                          direction: Axis.horizontal,
                          dashColor: tGrayColor,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: TextButton(
                            onPressed: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              if (buttonText == 'send code') {
                                final bodyData = <String, dynamic>{};
                                bodyData['userID'] = jsonDecode(prefs
                                        .getString('userDetails')
                                        .toString())["userID"]
                                    .toString();

                                try {
                                  final responce = await http.post(
                                      Uri.parse(API_URL + 'send_otp'),
                                      body: bodyData);

                                  var responseBody = json.decode(responce.body);

                                  if (responseBody["code"] == 200) {
                                    setState(() {
                                      sendMsg = "OTP send";
                                    });
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
                              } else if (buttonText == 'Verify') {
                                final bodyData = <String, dynamic>{};
                                bodyData['userID'] = jsonDecode(prefs
                                        .getString('userDetails')
                                        .toString())["userID"]
                                    .toString();
                                bodyData['OTP'] = verifyCodeController.text;

                                try {
                                  final responce = await http.post(
                                      Uri.parse(API_URL + 'check_user_OTP'),
                                      body: bodyData);

                                  var responseBody = json.decode(responce.body);

                                  if (responseBody["code"] == 200) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MainPage(initialIndex: 3)),
                                    );
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
                            },
                            child: Text(buttonText),
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(4.0),
                        //   child: Text(
                        //     'send code',
                        //   ),
                        // )

                        verifyCodeController.text.isEmpty
                            ? Text(
                                sendMsg,
                                style: TextStyle(
                                    fontSize: 12, color: Colors.green),
                              )
                            : SizedBox.shrink(),

                        Text(
                          errorMsg,
                          style: TextStyle(fontSize: 12, color: Colors.red),
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                decoration: BoxDecoration(
                  color: tShado1Color.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Timezone offset",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$timeZoneName',
                      style: TextStyle(color: Colors.black.withOpacity(0.5)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
                decoration: BoxDecoration(
                  color: tShado1Color.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Trade Amount",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Spot wallet balance',
                      style: TextStyle(color: Colors.black.withOpacity(0.5)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
