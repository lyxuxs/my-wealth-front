import 'package:flutter/material.dart';
import 'package:my_wealth/src/common_widgets/custom_container_btn.dart';
import 'package:my_wealth/src/constarits/colors.dart';
import 'package:my_wealth/src/constarits/image_strings.dart';

class WalletWidget extends StatelessWidget {
  const WalletWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: tGrayColor),
          borderRadius:
              BorderRadius.all(Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text('Protfolio Balance'),
                    Text(
                      '\$12,761.65',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    Row(
                      children: [
                        Text('+51,869'),
                        Text(
                          'Today\'s Profit',
                          style:
                              TextStyle(color: Colors.grey),
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      color: tShadoColor,
                      border: Border.all(color: tGrayColor),
                      borderRadius: BorderRadius.all(
                          Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 8.0,
                        right: 8.0,
                        top: 4,
                        bottom: 4),
                    child: Text('wallet'),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
              children: [
                CustomContinerBtn(
                  color: tLightBlueColor,
                  svgPath: depositSvg,
                  svgColor: Colors.white,
                  text: 'Deposit',
                ),
                CustomContinerBtn(
                  color: tShadoColor,
                  svgPath: withdrawSvg,
                  svgColor: tDarkGrayColor,
                  text: 'Withdraw',
                ),
                CustomContinerBtn(
                  color: tShadoColor,
                  svgPath: transferSvg,
                  svgColor: tDarkGrayColor,
                  text: 'Transfer',
                ),CustomContinerBtn(
                  color: tShadoColor,
                  svgPath: historySvg,
                  svgColor: tDarkGrayColor,
                  text: 'history',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}