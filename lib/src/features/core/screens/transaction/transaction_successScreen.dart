import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_wealth/src/constarits/colors.dart';
import 'package:my_wealth/src/constarits/image_strings.dart';
import 'package:my_wealth/src/constarits/text_strings.dart';

class TransactionSuccessScreen extends StatefulWidget {
  const TransactionSuccessScreen({super.key});

  @override
  State<TransactionSuccessScreen> createState() => _TransactionSuccessScreenState();
}

class _TransactionSuccessScreenState extends State<TransactionSuccessScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 2000), // Set the duration of the animation
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    _animationController.forward().then((_) {
      _animationController.stop();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tLightBlueColor,
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 120, left: 20, right: 20, bottom: 20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Lottie.asset(
                //   successAnimation,
                //   width: 130,
                //   controller: _animation,
                // ),
              ],
            ),
          ),
          Text('Transaction Successful',
              style: TextStyle(
                  letterSpacing: -1,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: tWhiteColor)),
          SizedBox(height: 8),
          Text(
            'Your order will be exected,\nwith in few seconds.',
            style: TextStyle(
                fontSize: 15,
                color: tWhiteColor.withOpacity(0.6),
                letterSpacing: 0),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 50),
          Container(
            padding: EdgeInsets.all(20),
            width: 300,
            decoration: BoxDecoration(
              color: tWhiteColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      'Total USD',
                      style: TextStyle(
                          fontSize: 13,
                          color: tWhiteColor.withOpacity(0.6),
                          letterSpacing: 0),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      '\$100.00',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: tWhiteColor,
                          letterSpacing: 0),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Recive',
                      style: TextStyle(
                          fontSize: 13,
                          color: tWhiteColor.withOpacity(0.6),
                          letterSpacing: 0),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      '\$99.80',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: tWhiteColor,
                          letterSpacing: 0),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
                child: SizedBox(
                  width: double.infinity,
                  height: 49,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all(tWhiteColor),
                      textStyle: MaterialStateProperty.all(
                        const TextStyle(color: Colors.white),
                      ),
                      minimumSize: MaterialStateProperty.all(
                        Size(MediaQuery.of(context).size.width / 2.5, 50),
                      ),
                    ),
                    child: const Text(
                      "Done",
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
