import 'package:flutter/material.dart';
import 'package:my_wealth/src/common_widgets/trade_color_util.dart';
import 'package:my_wealth/src/constarits/colors.dart';

class TradesScreen extends StatelessWidget {
  const TradesScreen({super.key});

  final String textValue = '-1.00';
  

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
        child: Column(
          children: [
            TradeFullDetailsWidget(),
            SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Positions',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                  ),
                  Container(
                    height: 1.0,
                    color: Color.fromARGB(255, 181, 181, 181).withOpacity(0.1),
                  )
                ],
              ),
            ),
            tradewidget()
          ],
        ),
      ),
    );
  }

// New Widget to display trades
  Container tradewidget() {
    return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
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
                                    fontWeight: FontWeight.w600, fontSize: 15),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(Icons.arrow_right_alt, color: Colors.black45,),
                                SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  "0.04",
                                  style: TextStyle(
                                    color: tLightBlueColor,
                                    fontWeight: FontWeight.w600, fontSize: 15),
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

class TradeFullDetailsWidget extends StatelessWidget {
  const TradeFullDetailsWidget({
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
                      const Text(
                        "Balance:",
                      ),
                      const Text(
                        "0.00",
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Equity:",
                      ),
                      const Text(
                        "0.00",
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Margin:",
                      ),
                      const Text(
                        "0.00",
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Free margin:",
                      ),
                      const Text(
                        "0.00",
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Margin level(%):",
                      ),
                      const Text(
                        "0.00",
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
