import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomContinerBtn extends StatelessWidget {
  final double height;
  final double width;
  final double borderRadius;
  final Color color;
  final Color svgColor;
  final String svgPath;
  final String text;

  CustomContinerBtn({
    this.height = 52.0,
    this.width = 52.0,
    this.borderRadius = 15,
    required this.color,
    required this.svgPath,
    required this.text, 
    required this.svgColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Container(
            height: height,
            width: width,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: color,
            ),
            child: SvgPicture.asset(
              svgPath,
              height: 20,
              width: 20,
              color: svgColor,
            ),
          ),
          Text(text),
        ],
      ),
    );
  }
}