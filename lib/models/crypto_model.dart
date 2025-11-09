class Crypto {
  final String name;
  final String symbol;
  final double priceUsd;
  final double priceInr;
  final double changePercent24Hr;
  final List<PricePoint> priceHistory; // NEW - for charts

  Crypto({
    required this.name,
    required this.symbol,
    required this.priceUsd,
    required this.priceInr,
    required this.changePercent24Hr,
    this.priceHistory = const [], // Default empty
  });

  // Add fromJson method if you don't have it
  factory Crypto.fromJson(Map<String, dynamic> json) {
    return Crypto(
      name: json['name'] ?? 'Unknown',
      symbol: json['symbol'] ?? 'N/A',
      priceUsd: double.tryParse(json['priceUsd'] ?? '0') ?? 0,
      priceInr: double.tryParse(json['priceInr'] ?? '0') ?? 0,
      changePercent24Hr: double.tryParse(json['changePercent24Hr'] ?? '0') ?? 0,
      priceHistory: [], // You'll populate this from historical API
    );
  }
}

// NEW - Data model for chart points
class PricePoint {
  final DateTime time;
  final double price;

  PricePoint(this.time, this.price);
}
