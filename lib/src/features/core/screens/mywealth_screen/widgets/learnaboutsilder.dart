
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_wealth/src/constarits/image_strings.dart';
import 'package:url_launcher/url_launcher.dart';

class LearnAboutSilder extends StatelessWidget {
  const LearnAboutSilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Learn about investing'),
        SizedBox(
          height: 10,
        ),
        Container(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                InkWell(
                  onTap: () async {
                    final url = Uri.parse(
                        'https://chat.whatsapp.com/EL4hHWEZlgA6d8iKKbW2k4');
                    if (await canLaunch(url.toString())) {
                      await launch(
                        url.toString(),
                        forceSafariVC: true,
                        forceWebView: true,
                        enableJavaScript: true,
                      );
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Container(
                    height: 150,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color.fromARGB(255, 72, 146, 119),
                          Color.fromARGB(255, 103, 168, 148),
                          // Add more colors here if needed
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            wCommunitySvg,
                            width: 40,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Join to Whatsapp Community',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () async {
                    final url = Uri.parse(
                        'https://t.me/+ZSIsgih9zlJhNTg1');
                    if (await canLaunch(url.toString())) {
                      await launch(
                        url.toString(),
                        forceSafariVC: true,
                        forceWebView: true,
                        enableJavaScript: true,
                      );
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Container(
                    height: 150,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color.fromARGB(255, 79, 143, 170),
                          Color.fromARGB(255, 62, 159, 191),
                          // Add more colors here if needed
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            wCommunitySvg,
                            width: 40,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Join to Telegram Community',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () async {
                    final url = Uri.parse(
                        'https://www.youtube.com/channel/UCG1VyLZEfNXI-cSCG8kFCMA');
                    if (await canLaunch(url.toString())) {
                      await launch(
                        url.toString(),
                        forceSafariVC: true,
                        forceWebView: true,
                        enableJavaScript: true,
                      );
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Container(
                    height: 150,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          Color.fromARGB(255, 181, 84, 84),
                          Color.fromARGB(255, 187, 59, 59),
                          // Add more colors here if needed
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start,
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                        children: [
                          SvgPicture.asset(
                            youtubeiconSvg,
                            height: 60,
                            color: Colors.white,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Join to Youtube Community',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ],
    );
  }
}