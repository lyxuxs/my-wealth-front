import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_wealth/src/constarits/colors.dart';
import 'package:my_wealth/src/constarits/image_strings.dart';
import 'package:my_wealth/src/constarits/text_strings.dart';
import 'package:my_wealth/src/features/core/screens/transaction/transaction_successScreen.dart';

class TransactionConfirationScreen extends StatelessWidget {
  const TransactionConfirationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Transaction Confirmation',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Transfer Out',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: tLightBlueColor)),
                SizedBox(height: 5),
                Text('\$100.0',
                    style: TextStyle(
                        letterSpacing: 0,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: tDarkGrayColor)),
                SizedBox(height: 8),
                Text(
                  'Your order will be exected,\nwith in few seconds.',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Price',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: tDarkGrayColor)),
                    Text('\$100.00',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        )),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 1.0,
                  color: Color.fromARGB(255, 181, 181, 181).withOpacity(0.3),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text('Fees',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: tDarkGrayColor)),
                        SizedBox(
                          width: 5,
                        ),
                        SvgPicture.asset(
                          infoiconSvg,
                          height: 18,
                          color: tGrayColor,
                        )
                      ],
                    ),
                    Text('\$0.20',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        )),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 1.0,
                  color: Color.fromARGB(255, 181, 181, 181).withOpacity(0.3),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Transaction type',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: tDarkGrayColor)),
                    Text('Transfer Out',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        )),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 1.0,
                  color: Color.fromARGB(255, 181, 181, 181).withOpacity(0.3),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: tDarkGrayColor)),
                    Text('\$99.80',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        )),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "tconfirmationagreemnetText",
                  style: TextStyle(fontSize: 13, color: tDarkGrayColor),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
            child: SizedBox(
              width: double.infinity,
              height: 49,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TransactionSuccessScreen()));
                },
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
                  "Confirm",
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
    );
  }
}
