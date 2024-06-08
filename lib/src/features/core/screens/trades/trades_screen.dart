import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_wealth/src/common_widgets/trade_color_util.dart';
import 'package:my_wealth/src/constarits/colors.dart';
import 'dart:async';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:my_wealth/src/constarits/server.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TradesScreen extends StatefulWidget {
  const TradesScreen({Key? key}) : super(key: key);

  @override
  _TradesScreenState createState() => _TradesScreenState();
}

class _TradesScreenState extends State<TradesScreen> {
  final String textValue = '-1.00';
  late double balance;
  late int margin;
  late String package;
  final Color color1 = Colors.red;
  final Color color2 = Colors.blue;
  late Color currentColor;
  List<dynamic> tradeList = [];
  late String _dateTimeString;
  late StreamController<double> _streamController;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<double>();
    _startTimer();
    currentColor = color1;
    _getData();
  }

  void _getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double spot = jsonDecode(
        '${prefs.getString('userDetails').toString()}')["spotBalance"];
    setState(() {
      balance = spot;
    });
    try {
      final bodyData = <String, dynamic>{};
      bodyData['personalFund'] = spot.toString();

      final responce = await http
          .post(Uri.parse(API_URL + 'search_package_by_fund'), body: bodyData);

      var responseBody = json.decode(responce.body);

      setState(() {
        margin = responseBody['personalMinFund'];
      });
    } catch (e) {
      print(e);
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      Random random = Random();
      double randomDouble = random.nextDouble();
      double randomTen = randomDouble * 10;
      bool shouldAdd = random.nextBool();
      _streamController.add(randomDouble);

      tradeList.clear();
      double equity = shouldAdd
          ? (balance + (randomDouble * 0.12))
          : (balance - (randomDouble * 0.12));
      final tradeData = {
        'equity': equity.toStringAsFixed(2),
        'freeMargin': (equity-margin).toStringAsFixed(2),
        'marginLevel': 2,
        'amount': (Random().nextDouble() * 1000).toStringAsFixed(2),
        'tradeID': 1,
        'profit': (Random().nextDouble() * 100).toStringAsFixed(2),
      };

      setState(() {
        tradeList.add(tradeData);
        currentColor = (random.nextInt(2) == 0) ? color1 : color2;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
        child: tradeList == null
            ? Text("No Trade Yet.")
            : Column(children: [
                SizedBox(
                  //height: MediaQuery.of(context).size.height * 0.6,
                  child: StreamBuilder<double>(
                    stream: _streamController.stream,
                    initialData: 0.0, // Initial value
                    builder: (context, snapshot) {
                      return ListView(
                        shrinkWrap: true,
                        children: tradeList.map((data) {
                          return Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 10),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Balance: "),
                                        Text(balance.toString()),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Equity: "),
                                        Text('${data['equity'].toString()}'),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Margin: "),
                                        Text(margin.toStringAsFixed(2)),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("Free Margin: "),
                                        Text(data['freeMargin'].toString()),
                                      ],
                                    ),
                                    // Row(
                                    //   mainAxisAlignment:
                                    //       MainAxisAlignment.spaceBetween,
                                    //   children: [
                                    //     Text("Margin Level(%): "),
                                    //     Text("2"),
                                    //     // Text(data['marginLevel'].toString()),
                                    //   ],
                                    // ),
                                    Container(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Text(
                                                    'Positions',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 15),
                                                  ),
                                                ),
                                                Container(
                                                  height: 1.0,
                                                  color: Color.fromARGB(
                                                          255, 181, 181, 181)
                                                      .withOpacity(0.1),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 10,
                                                bottom: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Trade ID - #" +
                                                                data['tradeID']
                                                                    .toString(),
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 15),
                                                          ),
                                                          // const Text(
                                                          //   "buy",
                                                          //   style: TextStyle(
                                                          //       color:
                                                          //           tLightBlueColor,
                                                          //       fontWeight:
                                                          //           FontWeight
                                                          //               .w600,
                                                          //       fontSize: 15),
                                                          // ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .arrow_right_alt,
                                                            color:
                                                                Colors.black45,
                                                          ),
                                                          SizedBox(
                                                            width: 5,
                                                          ),
                                                          Text(
                                                            data['amount']
                                                                .toString(),
                                                            style: TextStyle(
                                                                // color:
                                                                //     tLightBlueColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 15),
                                                          ),
                                                        ],
                                                      ),
                                                    ]),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      data['profit'].toString(),
                                                      style: TextStyle(
                                                        fontSize: 15,
                                                        color: currentColor,
                                                        // color: TextColorUtil
                                                        //     .calculateTextColor(
                                                        //         textValue),
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 1.0,
                                            color: Color.fromARGB(
                                                    255, 181, 181, 181)
                                                .withOpacity(0.3),
                                          )
                                        ],
                                      ),
                                    )
                                  ]));
                        }).toList(),
                      );
                    },
                  ),
                ),

                // tradewidget()
              ]),
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
                        "Trade ID - 1",
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
                            "tradeBuyValue,",
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
