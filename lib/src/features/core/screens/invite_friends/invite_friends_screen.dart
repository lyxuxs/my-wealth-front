import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_wealth/src/common_widgets/custom_container_btn.dart';
import 'package:my_wealth/src/constarits/colors.dart';
import 'package:my_wealth/src/constarits/image_strings.dart';
import 'package:my_wealth/src/constarits/sizes.dart';
import 'package:my_wealth/src/features/core/screens/transaction/transaction_confirmationScreen.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:my_wealth/src/utils/storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_wealth/src/constarits/server.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InviteFrinedsScreen extends StatefulWidget {
  const InviteFrinedsScreen({super.key});

  @override
  State<InviteFrinedsScreen> createState() => _InviteFrinedsScreenState();
}

class _InviteFrinedsScreenState extends State<InviteFrinedsScreen> {
  late String email = "example@email.com";
  late String displayEmail;
  late int introLevelMemberCount;
  late int level1MemberCount;
  late int level2MemberCount;
  late int level3MemberCount;

  @override
  void initState() {
    super.initState();
    _fetchPackageData();
    _fetchMemberData();
    displayEmail = email.length > 25 ? email.substring(0, 22) + '...' : email;
  }

  List<String> items = [
    "Recommended Information",
    "Membership list",
    "Commission Records",
  ];
  List<dynamic> packageList = [
    {
      'packageID': 1,
      'packageName': 'Intro',
      'personalMaxFund': 50,
      'personalMinFund': 0,
      'rebateFee': 10
    },
    {
      'packageID': 2,
      'packageName': 'Level 1',
      'personalMaxFund': 199,
      'personalMinFund': 51,
      'rebateFee': 12
    },
    {
      'packageID': 3,
      'packageName': 'Level 2',
      'personalMaxFund': 500,
      'personalMinFund': 200,
      'rebateFee': 15
    },
    {
      'packageID': 4,
      'packageName': 'Level 3',
      'personalMaxFund': 999,
      'personalMinFund': 501,
      'rebateFee': 18
    }
  ];
  List<dynamic> memberList = [];
  Future<List?> _fetchPackageData() async {
    try {
      final responce = await http.get(
        Uri.parse(API_URL + 'get_packages'),
      );
      var responseBody = json.decode(responce.body);
      if (responseBody is List) {
        packageList = responseBody;
        setState(() {
          packageList = responseBody;
        });

        return packageList;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List?> _fetchMemberData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("111111111111111111111111111111");
    print("111111111111111111111111111111");
    print("111111111111111111111111111111");
    try {
      final levelCResponce = await http.get(Uri.parse(API_URL +
          'friendLevelC?friendUserID=' +
          jsonDecode(prefs.getString('userDetails').toString())["userID"]
              .toString()));

      var responseBody = json.decode(levelCResponce.body);
      print(responseBody);
      for (var member in responseBody) {
        print("222222222222222222222222222222222222222");
        print("222222222222222222222222222222222222222");
        print("222222222222222222222222222222222222222");
        print(member['userID']);

        final memberDetails = await http.get(Uri.parse(API_URL +
            'search_user_by_id?userID=' +
            member['userID'].toString()));
        final memberDetailsRes = json.decode(memberDetails.body);
        print("222222222222222222222222222222222222222");
        print("222222222222222222222222222222222222222");
        print("222222222222222222222222222222222222222");
        print(memberDetailsRes);
        var tempMember = {
          'refTreeID': member['refTreeID'],
          'userID': member['userID'],
          'friendUserID': member['friendUserID'],
          'isFriendAdmin': member['isFriendAdmin'],
          'packageID': memberDetailsRes['packageID'],
          'email': memberDetailsRes['email'],
          'profit': memberDetailsRes['profit'],
        };
        memberList.add(tempMember);
      }
      introLevelMemberCount = 0;
      level1MemberCount = 0;
      level2MemberCount = 0;
      level3MemberCount = 0;
      for (var memberData in memberList) {
        print("222222222222222222222222222222222222222");
        print("222222222222222222222222222222222222222");
        print("222222222222222222222222222222222222222");
        print(memberData['packageID']);
        if (memberData['packageID'] == 1) {
          print("333333333333333333333333333333333333333");
          setState(() {
            introLevelMemberCount = introLevelMemberCount + 1;
            print(introLevelMemberCount);
          });
        } else if (memberData['packageID'] == 2) {
          setState(() {
            level1MemberCount = level1MemberCount + 1;
            print(level1MemberCount);
          });
          
        } else if (memberData['packageID'] == 3) {
          setState(() {
            level2MemberCount = level2MemberCount + 1;
            print(level2MemberCount);
          });
        } else if (memberData['packageID'] == 4) {
          setState(() {
            level3MemberCount = level3MemberCount + 1;
            print(level3MemberCount);
          });
        }
      }

      if (mounted) {
        setState(() {
          memberList = memberList;
          introLevelMemberCount = introLevelMemberCount;
          level1MemberCount = level1MemberCount;
          level2MemberCount = level2MemberCount;
          level3MemberCount = level3MemberCount;
        });
      }

      print(memberList);
      return memberList;
    } catch (e) {
      print(e);
      return null;
    }
  }

  /*ListView(
      children: packageList.map((package) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(package['packageName'],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("- Personal funds arrive ${package['personalMaxFund']}USD"),
            Text("- Rebate fee: ${package['rebateFee']}% for Level"),
            Text(
                "- Monthly income is up to ${package['personalMaxFund'] * package['rebateFee'] / 100}  USD or more"),
            SizedBox(height: 20),
          ],
        );
      }).toList(),
    ),
    */

  List<Widget> screen = [
    SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Intro"),
                SizedBox(
                  height: 10,
                ),
                Text("- Personal funds arrive 50USD"),
                Text("- Rebate fee: 10% for Level"),
                Text("- Monthly income is up to 10 USD or more"),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Level 1 "),
                SizedBox(
                  height: 10,
                ),
                Text("- Personal funds arrive 199USD"),
                Text("- Rebate fee: 12% for Level"),
                Text("- Monthly income is up to 50 USD or more"),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Level 2"),
                SizedBox(
                  height: 10,
                ),
                Text("- Personal funds arrive 500USD"),
                Text("- Rebate fee: 15% for Level"),
                Text("- Monthly income is up to 200 USD or more"),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Level 3"),
                SizedBox(
                  height: 10,
                ),
                Text("- Personal funds arrive 999USD"),
                Text("- Rebate fee: 18% for Level"),
                Text("- Monthly income is up to 600 USD or more"),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            '*Inviting friends activity prohibits users from recommending themselves. If the malicious commission is found, our company has the right to remove the users authority to use the function and the commission.',
            style: TextStyle(color: tredColor),
          ),
        ],
      ),
    ),
    SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          "Intro Level Members:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: tDarkGrayColor),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                         "0",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: tDarkGrayColor),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Level 1 Members:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: tDarkGrayColor),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "0",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: tDarkGrayColor),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Level 2 Members:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: tDarkGrayColor),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "0",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: tDarkGrayColor),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Level 3 Members:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: tDarkGrayColor),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "0",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: tDarkGrayColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Account",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Profit",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('displayEmail'),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "100",
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('displayEmail'),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "100",
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    ),
    SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            child: Container(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Transfer Out",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 15),
                              ),
                              const Text(
                                "2024.02.14 22:00:00",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "",
                              ),
                              const Text(
                                "100 000.00",
                                style: TextStyle(
                                  color: tLightBlueColor,
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
            ),
          ),
        ],
      ),
    ),
  ];

  int current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: tLightBlueColor,
        elevation: 0,
        title: const Text(
          "Invite Friends",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                MyCommissionWidget(),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: SizedBox(
                    height: 60,
                    width: double.infinity,
                    child: ListView.builder(
                        itemCount: items.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: ((context, index) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                current = index;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.only(left: 15, right: 15),
                              height: 50,
                              decoration: BoxDecoration(
                                  color: current == index
                                      ? tShado1Color
                                      : tShado1Color.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(9),
                                  border: current == index
                                      ? Border.all(color: tDarkGrayColor)
                                      : null),
                              child: Center(
                                  child: Text(
                                items[index],
                                style: TextStyle(),
                              )),
                            ),
                          );
                        })),
                  ),
                ),

                /// Tab Bar View
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.only(bottom: 30),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (current == 0)
                        Column(
                          children: [
                            SizedBox(
                              height: 500,
                              child: ListView.builder(
                                itemCount: packageList.length,
                                scrollDirection: Axis.vertical,
                                itemBuilder: ((context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(packageList[index]['packageName'],
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(height: 10),
                                      Text(
                                          "- Personal funds arrive ${packageList[index]['personalMinFund']}USD"),
                                      Text(
                                          "- Rebate fee: ${packageList[index]['rebateFee']}% for Level"),
                                      Text(
                                          "- Monthly income is up to ${packageList[index]['personalMaxFund'] * packageList[index]['rebateFee'] / 100}  USD or more"),
                                      SizedBox(height: 20),
                                    ],
                                  );
                                }),
                              ),
                            ),
                            Text(
                              '*Inviting friends activity prohibits users from recommending themselves. If the malicious commission is found, our company has the right to remove the users authority to use the function and the commission.',
                              style: TextStyle(color: tredColor),
                            )
                          ],
                        )
                      else if (current == 1)
                        SizedBox(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Intro Level Members:",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: tDarkGrayColor),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              introLevelMemberCount.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: tDarkGrayColor),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Level 1 Members:",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: tDarkGrayColor),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              level1MemberCount.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: tDarkGrayColor),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Level 2 Members:",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: tDarkGrayColor),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              level2MemberCount.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: tDarkGrayColor),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Level 3 Members:",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: tDarkGrayColor),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              level3MemberCount.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: tDarkGrayColor),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Account",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Profit",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('displayEmail'),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "100",
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('displayEmail'),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "100",
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        )
                      else
                        screen[current]
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MyCommissionWidget extends StatelessWidget {
  const MyCommissionWidget({
    super.key,
  });

  Future<String?> _getMyDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userDetails').toString();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: _getMyDetails(),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('No data found'));
        } else {
          return Container(
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: tGrayColor),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('My Commission'),
                          Text(
                            jsonDecode('${snapshot.data}')["profit"].toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 25),
                          ),
                          Row(
                            children: [
                              Text(jsonDecode('${snapshot.data}')["profit"]
                                  .toString()),
                              Text(
                                'Today\'s Profit',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          )
                        ],
                      ),
                      Container(
                        height: 50.0,
                        width: 1,
                        color:
                            Color.fromARGB(255, 181, 181, 181).withOpacity(0.3),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'My sharing code',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          GestureDetector(
                            onTap: () async {
                              await Clipboard.setData(ClipboardData(
                                      text: jsonDecode(
                                          '${snapshot.data}')["myReferral"]))
                                  .then((_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            jsonDecode('${snapshot.data}')[
                                                    "myReferral"] +
                                                " copied to clipboard")));
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, top: 10, bottom: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(color: tShado1Color),
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(8),
                                  color: tShadoColor),
                              child: Text(
                                  jsonDecode('${snapshot.data}')["myReferral"]),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    TransactionConfirationScreen()),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 15, right: 15, top: 10, bottom: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.amber),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(9),
                              color: Colors.amber),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                withdrawSvg,
                                height: 20,
                                width: 20,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Transfer Out',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
