import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_wealth/src/constarits/colors.dart';
import 'package:my_wealth/src/constarits/image_strings.dart';

class ChartScreen extends StatefulWidget {
  const ChartScreen({super.key});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: tLightBlueColor,
        elevation: 0,
        title: const Text(
          "Market Chart",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$27,672.36',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_circle_up_rounded,
                          size: 22,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('\$123.45'),
                      ],
                    ),
                    Row(
                      children: [
                        Text('Vol:'),
                        Text('\$320.45M'),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 15, bottom: 15),
                        decoration: BoxDecoration(
                            color: Color.fromARGB(141, 228, 72, 60),
                            border: Border.all(color: tredColor, width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(child: Text("Sell")),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 15, bottom: 15),
                        decoration: BoxDecoration(
                            color: tGreenColor,
                            border: Border.all(color: tGreenColor, width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(child: Text("Buy")),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
              child: SvgPicture.asset(
            chartSvg,
            fit: BoxFit.cover,
          )),
          Container(
            height: 60.0,
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: tShado1Color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text('1D', style: TextStyle(color: Colors.black))),
                SizedBox(
                  width: 10,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: tShado1Color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('1W', style: TextStyle(color: Colors.black)),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: tShado1Color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('1M', style: TextStyle(color: Colors.black)),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: tShado1Color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('3M', style: TextStyle(color: Colors.black)),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: tShado1Color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text('1Y', style: TextStyle(color: Colors.black)),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: tShado1Color,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(Icons.settings)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                color: tShado1Color.withOpacity(0.5),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: EdgeInsets.only(
                          left: 15, right: 15, top: 10, bottom: 10),
                      decoration: BoxDecoration(
                        color: tShado1Color,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Text('Order Book',
                          style: TextStyle(color: Colors.black))),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      // color: tShado1Color,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text('Depth', style: TextStyle(color: Colors.black)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: EdgeInsets.only(
                        left: 15, right: 25, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      // color: tShado1Color,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child:
                        Text('Trades', style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Price'),
                        Text('Amount'),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 30,
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        backgroundColor: Color.fromARGB(141, 228, 72, 60),
                        value: 0.1, // Replace with the actual progress value
                      ),
                    ),
                    Positioned(
                      left: 10,
                      bottom: 5,
                      top: 5,
                      child: Text(
                        '\$22,510.66',
                        style: TextStyle(color: tredColor),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 5,
                      top: 5,
                      child: Text(
                        '0.284793',
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 30,
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        backgroundColor: Color.fromARGB(141, 228, 72, 60),
                        value: 0.1, // Replace with the actual progress value
                      ),
                    ),
                    Positioned(
                      left: 10,
                      bottom: 5,
                      top: 5,
                      child: Text(
                        '\$22,510.66',
                        style: TextStyle(color: tredColor),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 5,
                      top: 5,
                      child: Text(
                        '0.284793',
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 30,
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        backgroundColor: Color.fromARGB(141, 228, 72, 60),
                        value: 0.3, // Replace with the actual progress value
                      ),
                    ),
                    Positioned(
                      left: 10,
                      bottom: 5,
                      top: 5,
                      child: Text(
                        '\$22,510.66',
                        style: TextStyle(color: tredColor),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 5,
                      top: 5,
                      child: Text(
                        '0.284793',
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 30,
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        backgroundColor: Color.fromARGB(141, 228, 72, 60),
                        value: 0.5, // Replace with the actual progress value
                      ),
                    ),
                    Positioned(
                      left: 10,
                      bottom: 5,
                      top: 5,
                      child: Text(
                        '\$22,510.66',
                        style: TextStyle(color: tredColor),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 5,
                      top: 5,
                      child: Text(
                        '0.284793',
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Spread of \$0.01 USD',textAlign: TextAlign.left,)),
              ),
              Container(
                height: 30,
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        backgroundColor: tGreen1Color,
                        value: 0.1, // Replace with the actual progress value
                      ),
                    ),
                    Positioned(
                      left: 10,
                      bottom: 5,
                      top: 5,
                      child: Text(
                        '\$22,510.66',
                        style: TextStyle(color: Colors.green),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 5,
                      top: 5,
                      child: Text(
                        '0.284793',
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 30,
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        backgroundColor: tGreen1Color,
                        value: 0.1, // Replace with the actual progress value
                      ),
                    ),
                    Positioned(
                      left: 10,
                      bottom: 5,
                      top: 5,
                      child: Text(
                        '\$22,510.66',
                        style: TextStyle(color: Colors.green),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 5,
                      top: 5,
                      child: Text(
                        '0.284793',
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 30,
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        backgroundColor: tGreen1Color,
                        value: 0.3, // Replace with the actual progress value
                      ),
                    ),
                    Positioned(
                      left: 10,
                      bottom: 5,
                      top: 5,
                      child: Text(
                        '\$22,510.66',
                        style: TextStyle(color: Colors.green),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 5,
                      top: 5,
                      child: Text(
                        '0.284793',
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 30,
                child: Stack(
                  children: <Widget>[
                    SizedBox(
                      height: 30,
                      child: LinearProgressIndicator(
                        color: Colors.white,
                        backgroundColor: tGreen1Color,
                        value: 0.5, // Replace with the actual progress value
                      ),
                    ),
                    Positioned(
                      left: 10,
                      bottom: 5,
                      top: 5,
                      child: Text(
                        '\$22,510.66',
                        style: TextStyle(color: Colors.green),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Positioned(
                      right: 10,
                      bottom: 5,
                      top: 5,
                      child: Text(
                        '0.284793',
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
