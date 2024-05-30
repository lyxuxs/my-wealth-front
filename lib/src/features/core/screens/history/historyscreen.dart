import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_wealth/src/constarits/colors.dart';
import 'package:my_wealth/src/constarits/image_strings.dart';
import 'package:my_wealth/src/constarits/server.dart';
import 'package:my_wealth/src/features/core/models/tradedata/trade_data.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool showDateRangeInput = false;
  DateTime startDate = DateTime(2024, 3, 25);
  DateTime endDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: tLightBlueColor,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'History',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      //  PreferredSize(
      //   preferredSize: Size.fromHeight(80),
      //   child:
      //   AppBar(
      //     automaticallyImplyLeading: false,
      //     backgroundColor: tLightBlueColor,
      //     elevation: 0,
      //     centerTitle: false,
      //     flexibleSpace: Container(
      //       alignment: Alignment.center,
      //       padding: EdgeInsets.only(top: 30),
      //       child: Container(
      //         alignment: Alignment.center,
      //         child: showDateRangeInput
      //             ? buildDateRangeInput()
      //             : buildDefaultContent(),
      //       ),
      //     ),
      //   ),
      // ),
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //   Center(child: new SvgPicture.asset(tpoolfillSvg, color: tShado1Color, width: 100,))
      // ]),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          HistoryMainDetailsWidget(),
          TransactionDetailsWidget(),
          TradetransactionDetailsWidget(),
        ]),
      ),
    );
  }

  Container buildDateRangeInput() {
    return Container(
      alignment: Alignment.center,
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          decoration: BoxDecoration(
            color: tShado1Color.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            child: Container(
              child: Text(
                  '${startDate.day}/${startDate.month}/${startDate.year}',
                  style: TextStyle(color: Colors.black)),
            ),
            onTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return Container(
                    height: 250,
                    width: double.infinity,
                    color: Colors.white,
                    child: CupertinoDatePicker(
                      backgroundColor: Colors.white,
                      initialDateTime: startDate,
                      onDateTimeChanged: (DateTime newTime) {
                        setState(() => startDate = newTime);
                      },
                      mode: CupertinoDatePickerMode.date,
                    ),
                  );
                },
              );
            },
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text('to'),
        SizedBox(
          width: 10,
        ),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          decoration: BoxDecoration(
            color: tShado1Color.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: InkWell(
            child: Container(
              child: Text('${endDate.day}/${endDate.month}/${endDate.year}',
                  style: TextStyle(color: Colors.black)),
            ),
            onTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return Container(
                    height: 250,
                    width: double.infinity,
                    color: Colors.white,
                    child: CupertinoDatePicker(
                      backgroundColor: Colors.white,
                      initialDateTime: endDate,
                      onDateTimeChanged: (DateTime newTime) {
                        setState(() => endDate = newTime);
                      },
                      mode: CupertinoDatePickerMode.date,
                    ),
                  );
                },
              );
            },
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
          decoration: BoxDecoration(
            color: tShado1Color.withOpacity(0.9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text('Done',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
        ),
      ]),
    );
  }

  Container buildDefaultContent() {
    return Container(
      width: 320,
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: tShado1Color.withOpacity(0.9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text('Day', style: TextStyle(color: Colors.black)),
          Container(
            height: 15,
            width: 1,
            color: Color.fromARGB(255, 172, 172, 172),
          ),
          Text('Week', style: TextStyle(color: Colors.black)),
          Container(
            height: 15,
            width: 1,
            color: Color.fromARGB(255, 172, 172, 172),
          ),
          Text('Month', style: TextStyle(color: Colors.black)),
          Container(
            height: 15,
            width: 1,
            color: Color.fromARGB(255, 172, 172, 172),
          ),
          GestureDetector(
              onTap: () {
                setState(() {
                  showDateRangeInput = !showDateRangeInput;
                });
              },
              child: Text('Custom', style: TextStyle(color: Colors.black))),
        ],
      ),
    );
  }
}

class TradetransactionDetailsWidget extends StatelessWidget {
  const TradetransactionDetailsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Trade ID: ${tradeList[0]["trade ID"]}',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      Row(
                        children: [
                          Text(
                            '${tradeList[0]["trade date"]}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${tradeList[0]["trade time"]}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${tradeList[0]["trade"]}',
                            style: TextStyle(
                                color: tradeList[0]["trade"] == "Buy"
                                    ? Colors.blue
                                    : Colors.red,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '${tradeList[0]["trade Amount"]}',
                            style: TextStyle(
                                color: tradeList[0]["trade"] == "Buy"
                                    ? Colors.blue
                                    : Colors.red,
                                fontWeight: FontWeight.w600,
                                fontSize: 15),
                          ),
                        ],
                      ),
                      Text(
                        '${tradeList[0]["output amount"]}',
                        style: TextStyle(
                          color: tradeList[0]["trade output"] == "profit"
                              ? Colors.blue
                              : Colors.red,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ]),
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

class TransactionDetailsWidget extends StatefulWidget {
  const TransactionDetailsWidget({Key? key}) : super(key: key);

  @override
  _TransactionDetailsWidgetState createState() =>
      _TransactionDetailsWidgetState();
}

class _TransactionDetailsWidgetState extends State<TransactionDetailsWidget> {
  List<dynamic> transList = [];

  @override
  void initState() {
    super.initState();
  }

  Future<List?> _fetchTrans() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final responce = await http.get(
        Uri.parse(API_URL +
            'transaction_by_user_id?UserID=' +
            jsonDecode(prefs.getString('userDetails').toString())["userID"]
                .toString()),
      );
      var responseBody = json.decode(responce.body);
      if (responseBody is List) {
        transList = responseBody;
        return transList;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List?>(
      future: _fetchTrans(),
      builder: (BuildContext context, AsyncSnapshot<List?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('No data found'));
        } else {
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  child: ListView(
                    shrinkWrap: true,
                    children: snapshot.data!.map((data) {
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "Balance",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15),
                                ),
                                Text(
                                  data['DateTime'].toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  data['TransactionType'].toString(),
                                ),
                                Text(
                                  data['Amount'].toString(),
                                  style: TextStyle(
                                    color: tLightBlueColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ]);
                    }).toList(),
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
      },
    );
  }
}

class HistoryMainDetailsWidget extends StatelessWidget {
  const HistoryMainDetailsWidget({
    super.key,
  });

  Future<Map<String, int?>?> _fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      final responce = await http.get(
        Uri.parse(API_URL +
            'transaction_by_user_id?UserID=' +
            jsonDecode(prefs.getString('userDetails').toString())["userID"]
                .toString()),
      );
      var responseBody = json.decode(responce.body);
      if (responseBody is List) {
        int profit = 0;
        int credit = 0;
        int? deposit = 0;
        int? withdrawal = 0;

        responseBody.forEach((data) {
          if (data['TransactionType'] == 'Withdrawal') {
            withdrawal = (withdrawal! + data['Amount']) as int?;
          } else {
            deposit = (deposit! + data['Amount']) as int?;
          }
        });

        final historyData = {
          'Profit': profit,
          'Credit': credit,
          'Deposit': deposit,
          'Withdrawal': withdrawal,
          'Balance': deposit! - withdrawal!,
        };

        return historyData;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, int?>?>(
      future: _fetchData(),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, int?>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('No data found'));
        } else {
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Profit:",
                            ),
                            Text(snapshot.data!['Profit'].toString()),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Credit:",
                            ),
                            Text(snapshot.data!['Credit'].toString()),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Deposit:",
                            ),
                            Text(snapshot.data!['Deposit'].toString()),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Withdrawal:",
                            ),
                            Text(snapshot.data!['Withdrawal'].toString()),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Balance:",
                            ),
                            Text(snapshot.data!['Balance'].toString()),
                          ],
                        ),
                      ]),
                ),
                Container(
                  height: 1.0,
                  color: Color.fromARGB(255, 181, 181, 181).withOpacity(0.3),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
