
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_wealth/src/constarits/colors.dart';
import 'package:my_wealth/src/constarits/image_strings.dart';
import 'package:my_wealth/src/features/core/screens/chart_Screen/chart_screen.dart';
import 'package:my_wealth/src/features/core/screens/history/historyscreen.dart';
import 'package:my_wealth/src/features/core/screens/markets/markets_screen.dart';
import 'package:my_wealth/src/features/core/screens/mywealth_screen/mywealth_screen.dart';
import 'package:my_wealth/src/features/core/screens/trades/trades_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;
  final screens = [
    MarketsScreen(),
    ChartScreen(),
    TradesScreen(),
    HistoryScreen(),
    MyWealthScreen(),
  ];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: screens[index],

        bottomNavigationBar: BottomNavigationBarTheme(
          data: const BottomNavigationBarThemeData(
            backgroundColor: bgColor,
              selectedItemColor: tPrimaryColor,
              unselectedLabelStyle: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: Colors.grey,
                  height: 1.5),
              selectedLabelStyle: TextStyle(
                  fontFamily: 'PlusJakartaSans',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: tPrimaryColor,
                  height: 1.5),),
          child: Container(
            decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.black12, width: 0.5))),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: true,
              currentIndex: index,
              onTap: (int newIndex) {
                setState(() {
                  index = newIndex;
                });
              },
              items: [
                BottomNavigationBarItem(
                    activeIcon: SvgPicture.asset(
                      tmarketfillSvg,
                      height: 22.02,
                      width: 20.77,
                      allowDrawingOutsideViewBox: true,
                    ),
                    icon: SvgPicture.asset(
                      tmarketoutSvg,
                      height: 22.02,
                      width: 20.77,
                      allowDrawingOutsideViewBox: true,
                    ),
                    label: 'markets'),
                BottomNavigationBarItem(
                    activeIcon: SvgPicture.asset(
                      thomefillSvg,
                      height: 22.86,
                      width: 18.53,
                      allowDrawingOutsideViewBox: true,
                    ),
                    icon: SvgPicture.asset(
                      thomeoutSvg,
                      height: 22.86,
                      width: 18.53,
                      allowDrawingOutsideViewBox: true,
                    ),
                    label: 'chart'),
                BottomNavigationBarItem(
                    activeIcon: SvgPicture.asset(
                      ttradefillSvg,
                      height: 22.75,
                      width: 22.55,
                      allowDrawingOutsideViewBox: true,
                    ),
                    icon: SvgPicture.asset(
                      ttradeoutSvg,
                      height: 22.75,
                      width: 22.55,
                      allowDrawingOutsideViewBox: true,
                    ),
                    label: 'trades'),
                BottomNavigationBarItem(
                    activeIcon: SvgPicture.asset(
                      tpoolfillSvg,
                      height: 20.57,
                      width: 20.66,
                      allowDrawingOutsideViewBox: true,
                    ),
                    icon: SvgPicture.asset(
                      tpooloutSvg,
                      height: 20.57,
                      width: 20.66,
                      allowDrawingOutsideViewBox: true,
                    ),
                    label: 'history'),
                BottomNavigationBarItem(
                    activeIcon: SvgPicture.asset(
                      twalletfillSvg,
                      height: 19.57,
                      width: 20.66,
                      allowDrawingOutsideViewBox: true,
                    ),
                    icon: SvgPicture.asset(
                      twalletoutSvg,
                      height: 19.57,
                      width: 20.66,
                      allowDrawingOutsideViewBox: true,
                    ),
                    label: 'MyWealth'),
              ],
            ),
          ),
        ));
  }
}
