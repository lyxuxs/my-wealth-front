import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_wealth/src/constarits/colors.dart';
import 'package:my_wealth/src/constarits/image_strings.dart';
import 'package:my_wealth/src/data_models/user_data.dart';

class HideableHeader extends StatelessWidget {
  const HideableHeader({
    super.key,
  });

  String _getLevelText(int level) {
  switch (level) {
    case 1:
      return 'Level 1';
    case 2:
      return 'Level 2';
    case 3:
      return 'Level 3';
    default:
      return 'intro';
  }
}

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
      alignment: Alignment.bottomCenter,
      height: 80,
      decoration: BoxDecoration(color: tLightBlueColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          new SvgPicture.asset(logowithtextSvg, width: 120),
          InkWell(
            onTap: () {},
            child: Container(
                height: 45.0,
                padding: EdgeInsets.only(left: 12, right: 12 ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: users['19991124']?.Verify == true ? myWealtlightgreenColor : Colors.grey,
                ),
                child: Text(
                  users['19991124']!.Level =='0' ? 'Intro' : _getLevelText(int.parse(users['19991124']!.Level)),
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                )),
          ),
        ],
      ),
    );
  }
}