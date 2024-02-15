import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_wealth/src/constarits/colors.dart';
import 'package:my_wealth/src/constarits/image_strings.dart';

class transactionModeWidget extends StatelessWidget {
  const transactionModeWidget({
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
        padding: EdgeInsets.only(
            left: 20, right: 20, top: 15, bottom: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  transactionModeSvg,
                  width: 30,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'Transaction mode',
                  style: TextStyle(
                      color: Colors.black, fontSize: 14),
                )
              ],
            ),
            Icon(Icons.chevron_right_rounded)
          ],
        ),
      ),
    );
  }
}