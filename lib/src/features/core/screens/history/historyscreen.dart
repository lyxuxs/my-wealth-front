import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_wealth/src/constarits/colors.dart';
import 'package:my_wealth/src/constarits/image_strings.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: tLightBlueColor,
          elevation: 0,
          centerTitle: false,
          flexibleSpace: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 30),
            child: Container(
              alignment: Alignment.center,
              child: Container(
                width: 320,
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: tShado1Color,
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
                      color:
                          Color.fromARGB(255, 181, 181, 181).withOpacity(0.4),
                    ),
                    Text('Week', style: TextStyle(color: Colors.black)),
                    Container(
                      height: 15,
                      width: 1,
                      color:
                          Color.fromARGB(255, 181, 181, 181).withOpacity(0.4),
                    ),
                    Text('Month', style: TextStyle(color: Colors.black)),
                    Container(
                      height: 15,
                      width: 1,
                      color:
                          Color.fromARGB(255, 181, 181, 181).withOpacity(0.4),
                    ),
                    Text('Custom', style: TextStyle(color: Colors.black)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      // body: Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: [
      //   Center(child: new SvgPicture.asset(tpoolfillSvg, color: tShado1Color, width: 100,))
      // ]),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          
          transactionDetailsWidget(),
          HistoryMainDetailsWidget(),
        ]),
      ),
    );
  }
}

class transactionDetailsWidget extends StatelessWidget {
  const transactionDetailsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                  "Balance",
                ),
                const Text(
                  "2024.02.14 22:00:00",
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Deposit",
                ),
                const Text(
                  "100 000.00",
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

class HistoryMainDetailsWidget extends StatelessWidget {
  const HistoryMainDetailsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                      const Text(
                        "0.00",
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Credit:",
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
                        "Deposit:",
                      ),
                      const Text(
                        "100 000.00",
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Withdrawal:",
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
                        "Balance:",
                      ),
                      const Text(
                        "100 000.00",
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
