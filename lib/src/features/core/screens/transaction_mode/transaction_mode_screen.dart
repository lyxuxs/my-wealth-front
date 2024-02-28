import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_wealth/src/constarits/colors.dart';
import 'package:my_wealth/src/constarits/image_strings.dart';
import 'package:my_wealth/src/features/core/screens/transaction_mode/transaction_mode_details/recurring_trading.dart';

class TradingModeScreen extends StatefulWidget {
  const TradingModeScreen({super.key});

  @override
  State<TradingModeScreen> createState() => _TradingModeScreenState();
}

class _TradingModeScreenState extends State<TradingModeScreen> {
  bool light0 = false;
  bool light1 = false;

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: tLightBlueColor,
        elevation: 0,
        title: const Text(
          "Trading Mode",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecurringTrading()));
                },
                child: TradingModeWidget(
                  svgPath: transactionModeSvg,
                  isSwitchClickable: true,
                  title: 'Recurring Trading (RT)',
                  subtitle: 'Set a schedule for Autonomous\nto trade on your behalf',
                  switchValue: light0,
                  onSwitchChanged: (bool value) {
                    setState(() {
                      light0 = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 10,),
              TradingModeWidget(
                svgPath: poolIconSvg,
                isSwitchClickable: false,
                title: 'Stake to Pool (STP) - beta',
                subtitle: 'Stake to earn more profit\nfrom your trading',
                switchValue: light1,
                onSwitchChanged: (bool value) {
                  setState(() {
                    light1 = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TradingModeWidget extends StatefulWidget {
  final String svgPath;
  final String title;
  final String subtitle;
  final bool switchValue;
  final Function(bool) onSwitchChanged;
  final bool isSwitchClickable;

  TradingModeWidget({
    required this.svgPath,
    required this.title,
    required this.subtitle,
    required this.switchValue,
    required this.onSwitchChanged,
    required this.isSwitchClickable,
  });

  @override
  State<TradingModeWidget> createState() => _TradingModeWidgetState();
}

class _TradingModeWidgetState extends State<TradingModeWidget> {
   final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !widget.isSwitchClickable,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: tGrayColor),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 10, top: 15, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: tShadoColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: SvgPicture.asset(
                      widget.svgPath,
                      width: 30,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.subtitle,
                        style: TextStyle(color: tGrayColor, fontSize: 14),
                      ),
                    ],
                  )
                ],
              ),
              Switch(
                thumbIcon: thumbIcon,
                value: widget.switchValue,
                onChanged: widget.isSwitchClickable ? widget.onSwitchChanged : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
