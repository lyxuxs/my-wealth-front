import 'package:flutter/material.dart';
import 'package:my_wealth/src/constarits/colors.dart';
import 'package:my_wealth/src/data_models/user_data.dart';
import 'package:my_wealth/src/utils/storage.dart';
import 'dart:convert';

class FixedHeader extends StatelessWidget {
  const FixedHeader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: tLightBlueColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: myWealtlightgreenColor
                          .withOpacity(0.2), // 50% opacity
                      border: Border.all(color: myWealtlightgreenColor),
                    ),
                    child: Center(
                        child:
                            // Text( _getInitials(users['19991124']!.Username),
                            Text(
                      storage.getItem('userDetails')["name"][0],
                      style: TextStyle(
                          color: myWealtlightgreenColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    )),
                  ),
                  SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(storage.getItem('userDetails')["name"],
                          /* Text(
                         users['19991124']!.Username.length > 19
                              ? users['19991124']!.Username.substring(0, 19)
                              : users['19991124']!.Username,*/
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      // Text(
                      //   'Your account and details',
                      //   style: TextStyle(color: Colors.black54),
                      //  ),
                    ],
                  )
                ],
              ),
              Icon(Icons.chevron_right_rounded)
            ],
          ),
        ));
  }

  String _getInitials(String name) {
    List<String> names = name.split(" ");
    String initials = "";
    if (names.length > 0) {
      initials += names[0][0];
      if (names.length > 1) {
        initials += names[1][0];
      }
    }
    return initials;
  }
}
