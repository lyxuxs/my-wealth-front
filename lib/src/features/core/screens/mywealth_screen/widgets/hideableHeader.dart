import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_wealth/src/constarits/colors.dart';
import 'package:my_wealth/src/constarits/image_strings.dart';
import 'package:my_wealth/src/constarits/server.dart';
import 'package:my_wealth/src/data_models/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HideableHeader extends StatelessWidget {
  const HideableHeader({
    super.key,
  });

  Future<String?> _getMyDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.getString('userDetails').toString();

    try {
      final bodyData = <String, dynamic>{};
      bodyData['personalFund'] = jsonDecode(
              '${prefs.getString('userDetails').toString()}')["spotBalance"]
          .toString();
      final responce = await http
          .post(Uri.parse(API_URL + 'search_package_by_fund'), body: bodyData);
      var responseBody = json.decode(responce.body);

      return responseBody['packageName'];
    } catch (e) {
      return "";
    }
  }

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
    return FutureBuilder<String?>(
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
                      padding: EdgeInsets.only(left: 12, right: 12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: users['19991124']?.Verify == true
                            ? myWealtlightgreenColor
                            : Colors.grey,
                      ),
                      child: Text(
                        // users['19991124']!.Level =='0' ? 'Intro' : _getLevelText(int.parse(users['19991124']!.Level)),
                        snapshot.data!,
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      )),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
