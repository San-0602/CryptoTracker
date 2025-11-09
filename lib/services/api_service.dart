import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/crypto_model.dart';

class ApiService {
  static Future<List<Crypto>> fetchCryptoData() async {
    final url = Uri.parse(
      'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin,ethereum,cardano,ripple,solana,polkadot,dogecoin,matic-network&vs_currencies=inr,usd&include_24hr_change=true',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;

      List<Crypto> cryptos = [];

      data.forEach((key, value) {
        final crypto = Crypto(
          name: _formatName(key),
          symbol: key.toUpperCase(),
          priceUsd: (value['usd'] as num?)?.toDouble() ?? 0.0,
          priceInr: (value['inr'] as num?)?.toDouble() ?? 0.0,
          changePercent24Hr:
              (value['usd_24h_change'] as num?)?.toDouble() ?? 0.0,
        );
        cryptos.add(crypto);
      });

      return cryptos;
    } else {
      throw Exception('Failed to load crypto data: ${response.statusCode}');
    }
  }

  static String _formatName(String name) {
    // Convert "matic-network" to "Matic Network", "bitcoin" to "Bitcoin"
    return name
        .split('-')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }
}
