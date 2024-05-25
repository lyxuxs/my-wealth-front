import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_wealth/src/common_widgets/custom_textfield.dart';
import 'package:my_wealth/src/constarits/colors.dart';
import 'package:my_wealth/src/constarits/image_strings.dart';
import 'package:my_wealth/src/constarits/server.dart';
import 'package:my_wealth/src/features/core/mainpage.dart';
import 'package:my_wealth/src/utils/storage.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  TextEditingController _withdrawalamountController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  bool _isTextFieldEmpty = true;
  String errorMessage = '';

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String tetherAddress = '';

  // void dispose() {
  //   controller?.dispose();
  //   super.dispose();
  // }
  void _addWithdraw() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final bodyData = <String, dynamic>{};

    bodyData['Amount'] = _withdrawalamountController.text;
    bodyData['withdrawal_wallet_address'] = _addressController.text;
    bodyData['UserID'] =
        jsonDecode(prefs.getString('userDetails').toString())["userID"]
            .toString();

    try {
      final responce = await http.post(
        Uri.parse(API_URL + 'add_withdrawal'),
        body: bodyData,
      );
      var responseBody = json.decode(responce.body);

      if (responseBody["message"] == 'Withdrawal added successfully') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MainPage(initialIndex: 3)),
        );
      } else {
        setState(() {
          errorMessage = responseBody["message"];
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getMyDetails();
  }

  Future<String?> _getMyDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userDetails').toString();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getMyDetails(),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('No data found'));
        } else {
          final data = jsonDecode(snapshot.data!) as Map<String, dynamic>;

          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              iconTheme: IconThemeData(
                color: Colors.white, //change your color here
              ),
              backgroundColor: tLightBlueColor,
              elevation: 0,
              title: const Text(
                "Withdraw",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 20),
                        child: const Text(
                          "Address",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: tGrayColor),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 60.0,
                        color: tShado1Color,
                        child: SizedBox(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                  child: TextField(
                                controller: _addressController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelStyle: TextStyle(
                                    fontSize: 14,
                                  ),
                                  hintStyle: TextStyle(
                                    fontSize: 14,
                                  ),
                                  hintText:
                                      'Enter withdraw address (Long press to paste)',
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _isTextFieldEmpty = value.isEmpty;
                                  });
                                },
                              )),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => QRViewExample(
                                        onQRViewCreated: _onQRViewCreated,
                                      ),
                                    ),
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: new SvgPicture.asset(
                                    qrscannerIconSvg,
                                    height: 20.09,
                                    width: 20.81,
                                    allowDrawingOutsideViewBox: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                        ),
                        child: Visibility(
                          visible: _isTextFieldEmpty,
                          child: Text(
                            "Please enter Recipient's address",
                            style: TextStyle(fontSize: 11, color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(left: 10, top: 20),
                          child: Row(
                            children: [
                              const Text(
                                "Network",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: tGrayColor),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              new SvgPicture.asset(
                                infoSvg,
                                height: 13,
                                color: tGrayColor,
                                allowDrawingOutsideViewBox: true,
                              ),
                            ],
                          )),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 60.0,
                        color: tShado1Color,
                        child: SizedBox(
                            child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('BNB Smart Chain (BEP20)'), // Newly addd
                            ],
                          ),
                        )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 20),
                        child: const Text(
                          "Amount",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: tGrayColor),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 60.0,
                        color: tShado1Color,
                        child: SizedBox(
                            child: Padding(
                          padding: const EdgeInsets.only(
                              left: 10, right: 15, top: 10, bottom: 10),
                          child: TextField(
                            controller: _withdrawalamountController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              labelStyle: TextStyle(
                                fontSize: 14,
                              ),
                              hintStyle: TextStyle(
                                fontSize: 14,
                              ),
                              hintText: 'Minimum amount to withdraw is 20.00',
                            ),
                            onChanged: (value) {
                              setState(() {
                                double? inputValue = double.tryParse(value);
                                if (inputValue != null &&
                                        inputValue > data["fundingBalance"] ||
                                    inputValue != null && inputValue < 20) {
                                  errorMessage = 'Insufficient balance';
                                } else {
                                  errorMessage = '';
                                }
                              });
                            },
                          ),
                        )),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Available Balance :",
                              style: TextStyle(fontSize: 11),
                            ),
                            Text(
                              data["fundingBalance"].toString(),
                              style: TextStyle(fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 16.0, right: 16.0, top: 5.0),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              if (errorMessage.isNotEmpty)
                                TextSpan(
                                  text: errorMessage.isNotEmpty
                                      ? ' $errorMessage'
                                      : '',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontFamily: 'GT-America-Standard',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                )
                              else
                                TextSpan(
                                  text: data["fundingBalance"] != 0.0
                                      ? ''
                                      : 'No amount available to transfer.',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontFamily: 'GT-America-Standard',
                                      fontSize: 12,
                                      fontWeight: FontWeight
                                          .w400), // Set the color for the second phrase
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: SizedBox(
                      width: double.infinity,
                      height: 49,
                      child: ElevatedButton(
                        onPressed: () {
                          _addWithdraw();
                        },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.amber),
                          textStyle: MaterialStateProperty.all(
                            const TextStyle(color: Colors.white),
                          ),
                          minimumSize: MaterialStateProperty.all(
                            Size(MediaQuery.of(context).size.width / 2.5, 50),
                          ),
                        ),
                        child: const Text(
                          "withdraw",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        tetherAddress = scanData as String;
      });
    });
  }
}

class QRViewExample extends StatefulWidget {
  final Function(QRViewController) onQRViewCreated;

  const QRViewExample({required this.onQRViewCreated});

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  late QRViewController controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QRView(
        key: qrKey,
        onQRViewCreated: widget.onQRViewCreated,
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
