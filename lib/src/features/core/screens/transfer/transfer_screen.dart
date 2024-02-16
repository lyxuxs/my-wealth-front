import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_wealth/src/constarits/colors.dart';
import 'package:my_wealth/src/constarits/image_strings.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {

  String text1 = 'Spot';
  String text2 = 'Funding';

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    double selectedWalletValue = 0.0;
    String selectedWalletText = '';

    if (text1 == 'Spot') {
      selectedWalletValue = walletList.spotWalletValue;
      selectedWalletText = 'Spot Wallet';
    } else if (text1 == 'Funding') {
      selectedWalletValue = walletList.fundingWalletValue;
      selectedWalletText = 'Funding Wallet';
    }
    String errorMessage = '';
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: tLightBlueColor,
        elevation: 0,
        title: const Text(
          "Transfer",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40.0,
              ),
              Container(
                color: tShado1Color,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: Row(
                    children: [
                      Text(
                        'From',
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(text1)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      String temp = text1;
                      text1 = text2;
                      text2 = temp;
            
                      if (text1 == 'Spot') {
                        selectedWalletValue = walletList.spotWalletValue;
                        selectedWalletText = 'Spot Wallet';
                      } else if (text1 == 'Funding') {
                        selectedWalletValue = walletList.fundingWalletValue;
                        selectedWalletText = 'Funding Wallet';
                      }
                    });
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                        border: Border.all(color: authBtnBgColor)),
                    padding: EdgeInsets.all(7),
                    child: new SvgPicture.asset(
                      transferSvg,
                      height: 21,
                      width: 21.78,
                      color: tLightBlueColor,
                      allowDrawingOutsideViewBox: true,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                color: tShado1Color,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Row(
                    children: [
                      Text(
                        'To',
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(text2)
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 5.0),
                child: Text("Amount"),
              ),
              Container(
                color: tShado1Color,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Row(
                    children: [
                      Container(
                        width: 200,
                        child: TextFormField(
                          keyboardType:
                              TextInputType.numberWithOptions(signed: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Minimum 1.00',
                            hintStyle: TextStyle(
                                color: tDarkGrayColor,
                                fontFamily: 'GT-America-Standard',
                                fontWeight: FontWeight.w400,
                                fontSize: 15),
                          ),
                          controller: controller,
                          onChanged: (value) {
                            setState(() {
                              double? inputValue = double.tryParse(value);
                              if (inputValue != null &&
                                  inputValue > selectedWalletValue) {
                                errorMessage = 'Insufficient balance';
                              } else {
                                errorMessage = '';
                              }
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'USDT',
                              style: TextStyle(
                                  color: authBtnBgColor,
                                  fontFamily: 'GT-America-Standard',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            GestureDetector(
                                onTap: () {
                                  setState(() {
                                    // Autofill the TextFormField with selectedWalletValue
                                    // Replace the 'controller' with your TextFormField's controller
                                    controller.text =
                                        selectedWalletValue.toString();
                                  });
                                },
                                child: Text(
                                  'Max',
                                  style: TextStyle(
                                      color: authBtnBgColor,
                                      fontFamily: 'GT-America-Standard',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 15),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 16.0, right: 16.0, top: 5.0),
                child: RichText(
                  text: TextSpan(
                    children: [
                      if (errorMessage.isNotEmpty)
                        TextSpan(
                          text: errorMessage.isNotEmpty ? ' $errorMessage' : '',
                          style: TextStyle(
                            color: Colors.red,
                            fontFamily: 'GT-America-Standard',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      else if (selectedWalletValue != 0.0)
                        TextSpan(
                          text:
                              'Amount available to transfer: $selectedWalletValue',
                          style: TextStyle(
                              color: authBtnBgColor,
                              fontFamily: 'GT-America-Standard',
                              fontSize: 12,
                              fontWeight: FontWeight
                                  .w400), // Set the color for the first phrase
                        )
                      else
                        TextSpan(
                          text: selectedWalletValue != 0.0
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
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(10.0),
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
                      backgroundColor: MaterialStateProperty.all(tLightBlueColor),
                      textStyle: MaterialStateProperty.all(
                        const TextStyle(color: Colors.white),
                      ),
                      minimumSize: MaterialStateProperty.all(
                        Size(MediaQuery.of(context).size.width / 2.5, 50),
                      ),
                    ),
                    child: const Text(
                      "Transfer",
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
        ],
      ),
    );
  }
}


class Wallet {
  double spotWalletValue;
  double fundingWalletValue;

  Wallet(this.spotWalletValue, this.fundingWalletValue);
}

Wallet walletList = Wallet(100.0, 200.0);