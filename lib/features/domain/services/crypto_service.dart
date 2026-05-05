import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class CryptoService {
  Stream<double> getBitcoinPrice() {
    final channel = WebSocketChannel.connect(
      Uri.parse('wss://stream.binance.com:9443/ws/btcusdt@trade'),
    );
    
    return channel.stream.map((event) {
      final data = jsonDecode(event);
      final priceString = data['p'];
      final price = double.tryParse(priceString.toString());

      if (price == null) {
        throw Exception("Gagal parse harga");
      }
      return price;
    });
  }
}
