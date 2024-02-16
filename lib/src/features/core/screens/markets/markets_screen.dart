import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_wealth/src/constarits/colors.dart';
import 'package:my_wealth/src/features/authentication/screens/login/login_screen.dart';
import 'package:my_wealth/src/features/core/models/forexmarketdata/forex_market_data.dart';

class MarketsScreen extends StatefulWidget {
  const MarketsScreen({super.key});

  @override
  State<MarketsScreen> createState() => _MarketsScreenState();
}

class _MarketsScreenState extends State<MarketsScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0; // Initial tab index
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  String formatNumber(double number) {
  String formattedNumber;
  if (number >= 100000) {
    formattedNumber = number.toStringAsFixed(0);
  } else if (number >= 10000) {
    formattedNumber = number.toStringAsFixed(1);
  } else if (number >= 1000) {
    formattedNumber = number.toStringAsFixed(2);
  } else if (number >= 100) {
    formattedNumber = number.toStringAsFixed(3);
  } else if (number >= 10) {
    formattedNumber = number.toStringAsFixed(4);
  } else {
    formattedNumber = number.toStringAsFixed(5);
  }
  return formattedNumber;
}
  

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: Container(
              color: tLightBlueColor,
              padding: EdgeInsets.only(left: 10, right: 20),
              child: AppBar(
                leading: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.edit_outlined, color: Colors.white),
                    )),
                actions: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: Icon(CupertinoIcons.add, color: Colors.white),
                  ),
                ],
                backgroundColor: tLightBlueColor,
                elevation: 0,
                centerTitle: false,
                flexibleSpace: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: 30),
                  child: Container(
                    alignment: Alignment.center,
                    child: Container(
                        width: 180,
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                        decoration: BoxDecoration(
                          color: tShado1Color,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _currentIndex = 0;
                                  _tabController.animateTo(0);
                                });
                              },
                              child: Text('Simple',
                                  style: TextStyle(
                                      color: _currentIndex == 0
                                          ? Colors.blue
                                          : Colors.black)),
                            ),
                            Container(
                              height: 15,
                              width: 1,
                              color: Color.fromARGB(255, 181, 181, 181)
                                  .withOpacity(0.4),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _currentIndex = 1;
                                  _tabController.animateTo(1);
                                });
                              },
                              child: Text('Advanced',
                                  style: TextStyle(
                                      color: _currentIndex == 1
                                          ? Colors.blue
                                          : Colors.black)),
                            ),
                          ],
                        )),
                  ),
                ),
              ),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              // Simple Tab View
              ListView(
                children: forexMarketDataList.map((data) {
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(data.currencyPair, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(formatNumber(data.lowValue)..toString()), // Show low value with 6 digits
                                SizedBox(
                                  width: 40,
                                ),
                                Text(formatNumber(data.highValue)..toString()),
                                
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 1.0,
                        color:
                            Color.fromARGB(255, 181, 181, 181).withOpacity(0.3),
                      )
                    ],
                  );
                }).toList(),
              ),
              // Advanced Tab View
              ListView(
                children: [
                  // Add your content for the advanced tab here
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('BTCUSDT'), Text('1.07271')],
                        ),
                      ),
                      Container(
                        height: 1.0,
                        color:
                            Color.fromARGB(255, 181, 181, 181).withOpacity(0.3),
                      )
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
