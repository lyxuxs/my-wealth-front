// forex_market_data.dart

class ForexMarketData {
  final String currencyPair;
  final double highValue;
  final double lowValue;

  ForexMarketData({
    required this.currencyPair,
    required this.highValue,
    required this.lowValue,
  });
}

List<ForexMarketData> forexMarketDataList = [
  ForexMarketData(currencyPair: 'EUR/USD', highValue: 1.25, lowValue: 1.15456),
  ForexMarketData(currencyPair: 'GBP/USD', highValue: 1.4, lowValue: 1.3),
  ForexMarketData(currencyPair: 'USD/JPY', highValue: 110, lowValue: 105),
  ForexMarketData(currencyPair: 'AUD/USD', highValue: 0.78, lowValue: 0.72),
  ForexMarketData(currencyPair: 'USD/CAD', highValue: 1.28, lowValue: 1.22),
  ForexMarketData(currencyPair: 'USD/CHF', highValue: 0.95, lowValue: 0.88),
];