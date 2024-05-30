import 'package:flutter/material.dart';

class cryptoCard extends StatelessWidget {
  String symbol;
  double current_price;

  cryptoCard({
    required this.symbol,
    required this.current_price,
  });

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
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Image.asset(
              //   image,
              //   height: 20,
              //   width: 20,
              //   fit: BoxFit.cover,
              // ),
              Text(
                symbol,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(formatNumber(current_price)
                ..toString()), // Show low value with 6 digits
            ],
          ),
        ),
        Container(
          height: 1.0,
          color: Color.fromARGB(255, 181, 181, 181).withOpacity(0.3),
        )
      ],
    );
  }
}
