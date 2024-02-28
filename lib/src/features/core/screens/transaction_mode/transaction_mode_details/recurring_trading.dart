import 'package:flutter/material.dart';
import 'package:my_wealth/src/constarits/colors.dart';

class RecurringTrading extends StatelessWidget {
  const RecurringTrading({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String timeZoneName = now.timeZoneName;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: tLightBlueColor,
        elevation: 0,
        title: const Text(
          "Recurring Trading",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Setup Recurring Trading (RT) Account"),
              SizedBox(height: 5,),
              Container(
                height: 1.0,
                color: Color.fromARGB(255, 181, 181, 181).withOpacity(0.3),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Timezone offset", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                  Text('$timeZoneName', style: TextStyle(color: Colors.black),),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
