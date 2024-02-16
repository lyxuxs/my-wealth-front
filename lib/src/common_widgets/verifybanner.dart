import 'package:flutter/material.dart';
import 'package:my_wealth/src/features/authentication/screens/profile_verify_screen.dart/profile_verify_screen.dart';

class VerifyBanner extends StatelessWidget {
  const VerifyBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ProfileVerifyScreen()));
      },
      child: SizedBox(
        child: Column(
          children: [
            Container(
              height: 65,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.amber.shade700),
                color: Color.fromARGB(105, 237, 203, 144),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: Colors.amber.shade700,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: const Icon(
                        Icons.insert_drive_file_outlined,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Please verify your account to gain access to\ninvest, earn money and reffrals',
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 30,
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.amber.shade700),
                    left: BorderSide(color: Colors.amber.shade700),
                    right: BorderSide(color: Colors.amber.shade700)),
                color: const Color.fromARGB(105, 237, 203, 144),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
              child: const Padding(
                padding:
                    EdgeInsets.only(left: 10, right: 10, top: 3.0, bottom: 3.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Complete verification',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 12),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.chevron_right_rounded),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
