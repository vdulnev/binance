import 'package:binance_f/core/security/crypto_utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('hmacSha256Sign', () {
    test('produces correct HMAC-SHA256 signature', () {
      // Test vector from Binance API docs
      final signature = hmacSha256Sign(
        data:
            'symbol=LTCBTC&side=BUY&type=LIMIT&timeInForce=GTC'
            '&quantity=1&price=0.1&recvWindow=5000'
            '&timestamp=1499827319559',
        secret:
            'NhqPtmdSJYdKjVHjA7PZj4Mge3R5YNiP1e3UZjInClVN65XAbvqqM6A7H5fATj0j',
      );
      expect(
        signature,
        'c8db56825ae71d6d79447849e617115f4a920fa2acdcab2b053c4b2838bd6b71',
      );
    });

    test('different data produces different signatures', () {
      const secret = 'test-secret';
      final sig1 = hmacSha256Sign(data: 'data1', secret: secret);
      final sig2 = hmacSha256Sign(data: 'data2', secret: secret);
      expect(sig1, isNot(equals(sig2)));
    });

    test('empty data produces valid signature', () {
      final signature = hmacSha256Sign(data: '', secret: 'secret');
      expect(signature, isNotEmpty);
      expect(signature.length, 64); // SHA-256 hex = 64 chars
    });
  });
}
