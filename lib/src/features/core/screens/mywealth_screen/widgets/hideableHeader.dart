import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_wealth/src/constarits/colors.dart';
import 'package:my_wealth/src/constarits/image_strings.dart';

class HideableHeader extends StatelessWidget {
  const HideableHeader({
    super.key,
  });

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
                  color: myWealtlightgreenColor,
                ),
                child: Text(
                  'Intro',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                )),
          ),
        ],
      ),
    );
  }
}