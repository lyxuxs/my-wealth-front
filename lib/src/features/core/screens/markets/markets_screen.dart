import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_wealth/src/constarits/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_wealth/src/constarits/image_strings.dart';
import 'package:my_wealth/src/features/authentication/screens/login/login_screen.dart';
import 'package:my_wealth/src/features/core/models/forexmarketdata/forex_market_data.dart';
import 'package:http/http.dart' as http;
import 'package:my_wealth/src/features/core/screens/markets/cryptoCard.dart';
import 'dart:developer';

class MarketsScreen extends StatefulWidget {
  const MarketsScreen({super.key});

  @override
  State<MarketsScreen> createState() => _MarketsScreenState();
}

class _MarketsScreenState extends State<MarketsScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0; // Initial tab index
  late TabController _tabController;
  late Timer _timer;

  Future<List<ForexMarketData>> fetcCoins() async {
    coinList = [];
    var url1 = "https://api.binance.com/api/v3/ticker/price?symbol=";
    var url2 = [
      "BTCUSDT",
      "ETHUSDT",
      "XRPUSDT",
      "TRXUSDT",
      "PEPEUSDT",
      "BNBUSDT",
      "SOLUSDT",
      "SHIBUSDT",
      "DOGEUSDT",
      "ADAUSDT"
    ];
    var coinLogos = [
      BTCUSDT,
      ETHUSDT,
      XRPUSDT,
      TRXUSDT,
      PEPEUSDT,
      BNBUSDT,
      SOLUSDT,
      SHIBUSDT,
      DOGEUSDT,
      ADAUSDT
    ];
    List<dynamic> values = [];
    for (int i = 0; i < url2.length; i++) {
      var url = Uri.parse(url1 + url2[i]);
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> values = json.decode(response.body);
        Map<String, dynamic> map = {
          'image': coinLogos[i],
          'symbol': url2[i],
          'current_price': double.parse(values['price']),
        };
        coinList.add(ForexMarketData.fromJson(map));
      } else {
        throw Exception('Failed to load coins');
      }
    }

    setState(() {
      coinList;
    });
    return coinList;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);
    fetcCoins();
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      fetcCoins();
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _timer.cancel();
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
          //appBar: PreferredSize(
          //preferredSize: Size.fromHeight(80),
          //child: Container(
//              color: tLightBlueColor,
          //             padding: EdgeInsets.only(left: 10, right: 20),
          //           child: AppBar(
          //           leading: InkWell(
          //             onTap: () {},
          //           child: Padding(
          //           padding: const EdgeInsets.all(8.0),
          //         child: Icon(Icons.edit_outlined, color: Colors.white),
          //     )),
          //actions: [
          //InkWell(
          //onTap: () {},
          //child: Icon(CupertinoIcons.add, color: Colors.white),
          //),
          //],
          //backgroundColor: tLightBlueColor,
          //elevation: 0,
          ////centerTitle: false,
          //flexibleSpace: Container(
          //alignment: Alignment.center,
          //padding: EdgeInsets.only(top: 30),
          //child: Container(
          //           alignment: Alignment.center,
          //           child: Container(
          //               width: 180,
          //             padding: EdgeInsets.only(
          //                   left: 20, right: 20, top: 10, bottom: 10),
          //               decoration: BoxDecoration(
          //                 color: tShado1Color.withOpacity(0.8),
          //                 borderRadius: BorderRadius.circular(10),
          //               ),
          //               child: Row(
          //                crossAxisAlignment: CrossAxisAlignment.center,
          //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
          //                 children: [
          //                   GestureDetector(
          //                     onTap: () {
          //                      setState(() {
          //                         _currentIndex = 0;
          //                         _tabController.animateTo(0);
          //                       });
          //                     },
          //                     child: Text('Simple',
          //                         style: TextStyle(
          //                             color: _currentIndex == 0
          //                                 ? Colors.blue
          //                                 : Colors.black,
          //                           fontWeight: _currentIndex ==0 ? FontWeight.bold : null)),
          //                   ),
          //                 Container(
          //                    height: 15,
          //                     width: 1,
          //                    color: Color.fromARGB(255, 172, 172, 172)
          //                         ,
          //                   ),
          //                  GestureDetector(
          //                    onTap: () {
          //                      setState(() {
          //                        _currentIndex = 1;
          //                        _tabController.animateTo(1);
          //                     });
          //                    },
          //                    child: Text('Advanced',
          //                    style: TextStyle(
          //                           color: _currentIndex == 1
          //                               ? Colors.blue
          //                           : Colors.black,
          //                           fontWeight: _currentIndex ==1 ? FontWeight.bold : null)),
          //                ),
          //             ],
          //           )),
          //     ),
          // ),
          //   //),
          //  ),
          // ),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            iconTheme: IconThemeData(
              color: Colors.white,
            ),
            backgroundColor: tLightBlueColor,
            elevation: 0,
            centerTitle: false,
            title: const Text(
              'Markets',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: coinList.length,
                itemBuilder: (context, index) {
                  return SingleChildScrollView(
                    child: cryptoCard(
                      symbol: coinList[index].symbol,
                      current_price: coinList[index].current_price,
                    ),
                  );
                },
              )
            ],
          )),
    );
  }
}
