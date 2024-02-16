import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_wealth/src/constarits/colors.dart';
import 'package:my_wealth/src/constarits/image_strings.dart';
import 'package:my_wealth/src/constarits/sizes.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        backgroundColor: tLightBlueColor,
        elevation: 0,
        title: const Text(
          "Deposit USDT",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            QrCodeWidget(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'USDT deposit address',
                    maxLines: 2,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: tGrayColor),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 60.0,
                  color: tShado1Color,
                  child: SizedBox(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: AutoSizeText(
                            '0x8bcda8978c4344554f345665b35335d11234gh42',
                            maxLines: 1,
                            style: TextStyle(
                                fontFamily: 'PlusJakartaSans',
                                fontWeight: FontWeight.w400,
                                fontSize: 13,
                                color: tSecondoryColor),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async {
                            await Clipboard.setData(
                                    ClipboardData(text: '12345'))
                                .then((_) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("copied to clipboard")));
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: new SvgPicture.asset(
                              copyIconSvg,
                              height: 24.09,
                              width: 20.81,
                              allowDrawingOutsideViewBox: true,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                ),
                // -- network -- //
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Network',
                    maxLines: 2,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: tGrayColor),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: AutoSizeText(
                          'BNB Smart Chain (BEP20)',
                          maxLines: 2,
                          style: TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: tSecondoryColor),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: new SvgPicture.asset(
                          icon_exchangeSvg,
                          height: 14.98,
                          width: 20.81,
                          allowDrawingOutsideViewBox: true,
                        ),
                      ),
                    ],
                  ),
                ),
                // -- network -- //
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    children: [
                      Text(
                        'Selected wallet',
                        maxLines: 2,
                        style: TextStyle(
                            fontFamily: 'PlusJakartaSans',
                            fontWeight: FontWeight.w500,
                            fontSize: 13,
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
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: AutoSizeText(
                          'Funding Wallet',
                          maxLines: 2,
                          style: TextStyle(
                              fontFamily: 'PlusJakartaSans',
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: tSecondoryColor),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      color: tShado1Color,
                      borderRadius: BorderRadius.all(Radius.circular(9)),
                    ),
                    child: SizedBox(
                        child: Padding(
                      padding: const EdgeInsets.all(tSecondorytSize),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: AutoSizeText(
                                  'Expected arrival',
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontFamily: 'PlusJakartaSans',
                                      fontSize: 13,
                                      color: tDarkGrayColor),
                                ),
                              ),
                              Flexible(
                                child: AutoSizeText(
                                  '15 network confim..',
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontFamily: 'PlusJakartaSans',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: tSecondoryColor),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: AutoSizeText(
                                  'Expected unlock',
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontFamily: 'PlusJakartaSans',
                                      fontSize: 13,
                                      color: tDarkGrayColor),
                                ),
                              ),
                              Flexible(
                                child: AutoSizeText(
                                  '15 network confim..',
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontFamily: 'PlusJakartaSans',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: tSecondoryColor),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: AutoSizeText(
                                  'Contact Information',
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontFamily: 'PlusJakartaSans',
                                      fontSize: 13,
                                      color: tDarkGrayColor),
                                ),
                              ),
                              Flexible(
                                child: AutoSizeText(
                                  '***97955',
                                  maxLines: 2,
                                  style: TextStyle(
                                      fontFamily: 'PlusJakartaSans',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      color: tSecondoryColor),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
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

class QrCodeWidget extends StatelessWidget {
  const QrCodeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 30,
        ),
        QrImageView(
          data: '0x8bcda8978c4344554f345665b35335d11234gh42',
          version: QrVersions.auto,
          size: 200,
        ),
        SizedBox(
          height: 20,
        ),
        AutoSizeText(
          'Send only USDT to this deposit address.\nThis address does not support other currencies.',
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
              fontFamily: 'PlusJakartaSans',
              fontWeight: FontWeight.w600,
              fontSize: 10,
              color: tGrayColor),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 1.0,
          color: Color.fromARGB(255, 181, 181, 181).withOpacity(0.3),
        )
      ],
    );
  }
}
