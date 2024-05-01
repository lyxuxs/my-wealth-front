// import 'dart:ffi';

class ForexMarketData {
  String image;
  String symbol;
  double current_price;

  ForexMarketData({
    required this.image,
    required this.symbol,
    required this.current_price,
  });

  factory ForexMarketData.fromJson(Map<String, dynamic> json) {
    return ForexMarketData(
      image: json['image'],
      symbol: json['symbol'],
      current_price: json['current_price'].toDouble(),
    );
  }
}

List<ForexMarketData> coinList = [];
