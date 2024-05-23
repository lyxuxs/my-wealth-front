import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dart:convert';
import 'package:my_wealth/src/common_widgets/verifybanner.dart';
import 'package:my_wealth/src/common_widgets/wallet_widget.dart';
import 'package:my_wealth/src/constarits/colors.dart';
import 'package:my_wealth/src/constarits/image_strings.dart';
import 'package:my_wealth/src/features/core/screens/mywealth_screen/widgets/fixedHeader.dart';
import 'package:my_wealth/src/features/core/screens/mywealth_screen/widgets/hideableHeader.dart';
import 'package:my_wealth/src/features/core/screens/mywealth_screen/widgets/learnaboutsilder.dart';
import 'package:my_wealth/src/features/core/screens/mywealth_screen/widgets/rafrral_n_customerservicewidget.dart';
import 'package:my_wealth/src/features/core/screens/mywealth_screen/widgets/transactionmodewidget.dart';
import 'package:my_wealth/src/features/authentication/screens/signup/signup_scren.dart';
import 'package:my_wealth/src/features/core/screens/Customer_Service/customer_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyWealthScreen extends StatelessWidget {
  const MyWealthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: tLightBlueColor,
      child: SafeArea(
        child: Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                automaticallyImplyLeading: false,
                expandedHeight: 50.0, // adjust the height as needed
                floating: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: HideableHeader(),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverPersistentHeaderDelegate(
                  child: FixedHeader(),
                ),
              ),
              SliverPadding(
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                sliver: SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      // VerifyBanner(),
                      SizedBox(
                        height: 10,
                      ),
                      WalletWidget(),
                      SizedBox(
                        height: 10,
                      ),
                      transactionModeWidget(),
                      SizedBox(
                        height: 10,
                      ),
                      Rafrral_n_CustomerServiceWidget(),
                      SizedBox(
                        height: 20,
                      ),
                      LearnAboutSilder(),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 49,
                        child: OutlinedButton(
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setBool('isLoggedIn', false);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignupScreen()));
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9),
                              ),
                            ),
                            textStyle: MaterialStateProperty.all(
                              const TextStyle(color: tDarkGrayColor),
                            ),
                            minimumSize: MaterialStateProperty.all(
                              Size(MediaQuery.of(context).size.width / 2.5, 50),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.logout, color: tDarkGrayColor),
                              const Text(
                                "Log Out",
                                style: TextStyle(
                                    color: tDarkGrayColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                          child: Text(
                        '© 2024 MyWealth. All rights reserved. 0.0.1 version',
                        style: TextStyle(color: tDarkGrayColor),
                      ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;

  _SliverPersistentHeaderDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 80.0; // adjust the max extent as needed

  @override
  double get minExtent => 80.0; // adjust the min extent as needed

  @override
  bool shouldRebuild(covariant _SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
