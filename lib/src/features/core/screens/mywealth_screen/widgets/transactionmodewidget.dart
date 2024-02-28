import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_wealth/src/constarits/colors.dart';
import 'package:my_wealth/src/constarits/image_strings.dart';
import 'package:my_wealth/src/features/core/screens/transaction_mode/transaction_mode_screen.dart';

class transactionModeWidget extends StatelessWidget {
  const transactionModeWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TradingModeScreen()));
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: tGrayColor),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 15),
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
                    'Trading mode',
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  )
                ],
              ),
              Icon(Icons.chevron_right_rounded)
            ],
          ),
        ),
      ),
    );
  }
}
