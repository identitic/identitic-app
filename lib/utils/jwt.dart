import 'dart:convert';

class JWT {
  /// Decode Base64 String
  static String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += "==";
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Invalid Base64 String');
    }

    return utf8.decode(base64Url.decode(output));
  }

  /// Converts a JSON Web Token into a Dart Map
  static Map<String, dynamic> toMap(String jwt) {
    final List<String> parts = jwt.split('.');

    if (parts.length != 3) {
      throw FormatException('Invalid JSON Web Token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);

    if (payloadMap is! Map<String, Object>) {
      throw FormatException('Invalid JSON Web Token payload');
    }

    return payloadMap;
  }
}
