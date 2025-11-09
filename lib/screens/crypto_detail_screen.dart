import 'package:flutter/material.dart';
import '../models/crypto_model.dart';
import '../widgets/price_chart.dart';

class CryptoDetailScreen extends StatelessWidget {
  final Crypto crypto;

  const CryptoDetailScreen({super.key, required this.crypto});

  // Generate sample historical data (replace with real API later)
  List<PricePoint> _generateSampleData() {
    final List<PricePoint> data = [];
    final basePrice = crypto.priceUsd;
    final now = DateTime.now();

    // Generate 24 hours of data
    for (int i = 0; i < 24; i++) {
      final time = now.subtract(Duration(hours: 24 - i));
      // Simulate price fluctuations
      final fluctuation = (i % 5 == 0) ? 0.02 : -0.01;
      final price = basePrice * (1 + fluctuation * (i / 24));
      data.add(PricePoint(time, price));
    }

    return data;
  }

  @override
  Widget build(BuildContext context) {
    final priceHistory = _generateSampleData();
    final isPositive = crypto.changePercent24Hr >= 0;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          '${crypto.name} DETAILS',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Price Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                gradient: LinearGradient(
                  colors: [Color(0xFF1A1A1A), Color(0xFF0F0F0F)],
                ),
                boxShadow: [
                  BoxShadow(
                    color: (isPositive ? Colors.greenAccent : Colors.redAccent)
                        // ignore: deprecated_member_use
                        .withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    crypto.name.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '\$${crypto.priceUsd.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    '₹${crypto.priceInr.toStringAsFixed(2)}',
                    style: TextStyle(
                      // ignore: deprecated_member_use
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isPositive
                          // ignore: deprecated_member_use
                          ? Colors.green.withOpacity(0.2)
                          // ignore: deprecated_member_use
                          : Colors.red.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isPositive
                            ? Colors.greenAccent
                            : Colors.redAccent,
                      ),
                    ),
                    child: Text(
                      '${isPositive ? '+' : ''}${crypto.changePercent24Hr.toStringAsFixed(2)}%',
                      style: TextStyle(
                        color: isPositive
                            ? Colors.greenAccent
                            : Colors.redAccent,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Price Chart
            Text(
              '24H PRICE CHART',
              style: TextStyle(
                // ignore: deprecated_member_use
                color: Colors.white.withOpacity(0.8),
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            PriceChart(priceData: priceHistory, isPositive: isPositive),

            const SizedBox(height: 24),

            // Additional Stats
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.5),
                // ignore: deprecated_member_use
                border: Border.all(color: Colors.white.withOpacity(0.1)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'MARKET STATS',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildStatRow('Symbol', crypto.symbol.toUpperCase()),
                  _buildStatRow(
                    '24H Change',
                    '${crypto.changePercent24Hr.toStringAsFixed(2)}%',
                  ),
                  _buildStatRow(
                    'USD Price',
                    '\$${crypto.priceUsd.toStringAsFixed(2)}',
                  ),
                  _buildStatRow(
                    'INR Price',
                    '₹${crypto.priceInr.toStringAsFixed(2)}',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              // ignore: deprecated_member_use
              color: Colors.white.withOpacity(0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
