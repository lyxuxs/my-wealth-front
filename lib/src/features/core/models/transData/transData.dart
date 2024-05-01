import 'dart:ffi';

class TransData {
  int transID;
  Double spot;
  Double funding;
  Double commission;
  String DateTime;
  int cusID;


  TransData({
    required this.transID,
    required this.spot,
    required this.funding,
    required this.commission,
    required this.DateTime,
    required this.cusID,
  });

  factory TransData.fromJson(Map<String, dynamic> json) {
    return TransData(
      transID: json['transID'],
      spot: json['spot'].toDouble(),
      funding: json['funding'].toDouble(),
      commission: json['commission'].toDouble(),
      DateTime: json['DateTime'],
      cusID: json['cusID'],
    );
  }
}

List<TransData> transList = [];
