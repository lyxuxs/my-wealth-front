import 'package:flutter/material.dart';
import 'package:my_wealth/src/constarits/colors.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustomerServiceScreen extends StatefulWidget {
  const CustomerServiceScreen({super.key});

  @override
  State<CustomerServiceScreen> createState() => _CustomerServiceScreenState();
}

class _CustomerServiceScreenState extends State<CustomerServiceScreen> {
  final controller = WebViewController()
  ..loadRequest(Uri.parse('https://tawk.to/chat/65fa8498a0c6737bd122b1fb/1hpd9btgs'));
  
  
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
          "Customer Support",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          child: WebViewWidget(controller: controller)),),
    );
  }
}