import 'dart:convert';

import 'package:crypto/crypto.dart';

String hmacSha256Sign({required String data, required String secret}) {
  final key = utf8.encode(secret);
  final bytes = utf8.encode(data);
  final hmac = Hmac(sha256, key);
  final digest = hmac.convert(bytes);
  return digest.toString();
}
