import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_wealth/src/common_widgets/custom_container_btn.dart';
import 'package:my_wealth/src/constarits/colors.dart';
import 'package:my_wealth/src/constarits/image_strings.dart';
import 'package:my_wealth/src/features/core/screens/deposit/deposit_screen.dart';
import 'package:my_wealth/src/features/core/screens/history/historyscreen.dart';
import 'package:my_wealth/src/features/core/screens/transfer/transfer_screen.dart';
import 'package:my_wealth/src/features/core/screens/withdraw/withdraw_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletWidget extends StatelessWidget {
  const WalletWidget({
    super.key,
  });

  Future<String?> _getMyDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userDetails').toString();
  }


  @override
  Widget build(BuildContext context) {
    return 
    FutureBuilder<String?>(
      future: _getMyDetails(),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('No data found'));
        } else {
          return Container(
      decoration: BoxDecoration(
          border: Border.all(color: tGrayColor),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Protfolio Balance'),
                    Text(
                      
                      '\$'+jsonDecode('${snapshot.data}')["spotBalance"].toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Row(
                      children: [
                        
                        Text('+'+jsonDecode('${snapshot.data}')["profit"].toString()),
                        Text(
                          'Today\'s Profit',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  height: 50.0,
                  width: 1,
                  color: Color.fromARGB(255, 181, 181, 181).withOpacity(0.3),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Funding Balance', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),),
                    Text(
                      
                      '\$'+jsonDecode('${snapshot.data}')["fundingBalance"].toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DepositScreen()));
                  },
                  child: CustomContinerBtn(
                    color: tLightBlueColor,
                    svgPath: depositSvg,
                    svgColor: Colors.white,
                    text: 'Deposit',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => WithdrawScreen()));
                  },
                  child: CustomContinerBtn(
                    color: tShadoColor,
                    svgPath: withdrawSvg,
                    svgColor: tDarkGrayColor,
                    text: 'Withdraw',
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TransferScreen()));
                  },
                  child: CustomContinerBtn(
                    color: tShadoColor,
                    svgPath: transferSvg,
                    svgColor: tDarkGrayColor,
                    text: 'Transfer',
                  ),
                ),
                InkWell(
                  onTap: () {
                  },
                  child: CustomContinerBtn(
                    color: tShadoColor,
                    svgPath: historySvg,
                    svgColor: tDarkGrayColor,
                    text: 'history',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
        }
      },
    );


     }
}
