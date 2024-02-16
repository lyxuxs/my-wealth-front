import 'package:flutter/material.dart';
import 'package:my_wealth/src/common_widgets/custom_container_btn.dart';
import 'package:my_wealth/src/constarits/colors.dart';
import 'package:my_wealth/src/constarits/image_strings.dart';
import 'package:my_wealth/src/features/core/screens/deposit/deposit_screen.dart';
import 'package:my_wealth/src/features/core/screens/history/historyscreen.dart';
import 'package:my_wealth/src/features/core/screens/transfer/transfer_screen.dart';
import 'package:my_wealth/src/features/core/screens/withdraw/withdraw_screen.dart';

class WalletWidget extends StatelessWidget {
  const WalletWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                      '\$12,761.65',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                    Row(
                      children: [
                        Text('+51,869'),
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
                      '\$12,761.65',
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
}
