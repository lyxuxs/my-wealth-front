import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_wealth/src/common_widgets/trade_color_util.dart';
import 'package:my_wealth/src/constarits/colors.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_wealth/src/constarits/server.dart';

class TradesScreen extends StatelessWidget {
//  const TradesScreen({super.key});

  final String textValue = '-1.00';
  List<dynamic> tradeList = [];

  Future<void> fetchDataAndUpdateList() async {
    final response = await http.get(
      Uri.parse(API_URL + '/trade'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    //if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    tradeList.clear();

    print("..........................fetching data");
    for (var item in data) {
      final tradeData = {
        'balance': item['balance'],
        'equity': item['equality'],
        'margin': item['freeMargin'],
        'freeMargin': item['freeMargin'],
        'marginLevel': item['marginLevel']
      };

      tradeList.add(tradeData);
    }
    print(tradeList);

    //} else {
    //print('Failed to fetch data: ${response.statusCode}');
    //}
  }

  @override
  Widget build(BuildContext context) {
    fetchDataAndUpdateList();
    return Scaffold(
      appBar: 
      AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: tLightBlueColor,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'Trades',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Text("No Trade Yet.")
        // Column(children: [
        //   SizedBox(
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         Padding(
        //           padding: const EdgeInsets.all(10),
        //           child: Text(
        //             'Positions',
        //             style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        //           ),
        //         ),
        //         Container(
        //           height: 1.0,
        //           color: Color.fromARGB(255, 181, 181, 181).withOpacity(0.1),
        //         )
        //       ],
        //     ),
        //   ),
        //   SizedBox(
        //     //height: MediaQuery.of(context).size.height * 0.6,
        //     child: ListView(
        //       shrinkWrap: true,
        //       children: tradeList.map((data) {
        //         print("::::::::::::::::::::::::::::::::::::");
        //         print(data);
        //         return Column(children: [
        //           Text("Balance: " + data['balance'].toString()),
        //           Text("Equity: " + data['equity'].toString()),
        //           Text("Margin: " + data['margin'].toString()),
        //           Text("Free Margin: " + data['freeMargin'].toString()),
        //           Text("Margin Level(%): " + data['marginLevel'].toString()),
        //         ]);
        //       }).toList(),
        //     ),
        //   ),
        //   tradewidget()
        // ]),
      
      ),
    );
  }

// New Widget to display trades
  Container tradewidget() {
    return Container(
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Trade ID - 01",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      Row(
                        children: [
                          const Text(
                            "buy",
                            style: TextStyle(
                                color: tLightBlueColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                            Icons.arrow_right_alt,
                            color: Colors.black45,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          const Text(
                            "0.04",
                            style: TextStyle(
                                color: tLightBlueColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                        ],
                      ),
                    ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      textValue,
                      style: TextStyle(
                        fontSize: 15,
                        color: TextColorUtil.calculateTextColor(textValue),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            height: 1.0,
            color: Color.fromARGB(255, 181, 181, 181).withOpacity(0.3),
          )
        ],
      ),
    );
  }
}
