import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_wealth/src/constarits/colors.dart';
import 'package:my_wealth/src/constarits/image_strings.dart';
import 'package:my_wealth/src/features/core/screens/invite_friends/invite_friends_screen.dart';
import 'package:my_wealth/src/features/core/screens/Customer_Service/customer_service.dart';
class Rafrral_n_CustomerServiceWidget extends StatelessWidget {
  const Rafrral_n_CustomerServiceWidget({
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
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => InviteFrinedsScreen()));
              },
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        raffralsSvg,
                        width: 25,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Invite your friends',
                        style: TextStyle(
                            color: Colors.black, fontSize: 14),
                      )
                    ],
                  ),
                  Icon(Icons.chevron_right_rounded)
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CustomerServiceScreen()));
              },
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        contactSupportSvg,
                        width: 25,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Customer service',
                        style: TextStyle(
                            color: Colors.black, fontSize: 14),
                      )
                    ],
                  ),
                  Icon(Icons.chevron_right_rounded)
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}