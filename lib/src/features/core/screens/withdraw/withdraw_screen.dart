import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_wealth/src/common_widgets/custom_textfield.dart';
import 'package:my_wealth/src/constarits/colors.dart';
import 'package:my_wealth/src/constarits/image_strings.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  TextEditingController _withdrawalamountController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  bool _isTextFieldEmpty = true;

  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String tetherAddress = '';

  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
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
                    padding: const EdgeInsets.only(left: 10, right: 15, top: 10, bottom: 10),
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
                            'Minimum amount to withdraw is 20.00',
                      ),
                    ),
                  )),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10, right: 10
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Available Balance :",
                        style: TextStyle(fontSize: 11),
                      ),
                      Text(
                        "10.00",
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
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
                  onPressed: () {},
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all(Colors.amber),
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
