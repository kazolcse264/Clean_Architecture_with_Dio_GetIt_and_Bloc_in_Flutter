import 'dart:convert';

import '../../data/models/user_model.dart';


// Function to decode the JWT token
UserModel? decodeToken(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('Invalid token format');
  }

  // Decode the Base64Url encoded payload
  final payload = _decodeBase64(parts[1]);

  // Convert the decoded payload to a Map
  final Map<String, dynamic> payloadMap = json.decode(payload);

  // Return a UserModel if email and userId exist
  if (payloadMap.containsKey('user') && payloadMap.containsKey('sub')) {
    return UserModel(
      userId: payloadMap['sub'].toString(), // Assuming 'sub' is userId
      email: payloadMap['user'] as String,
    );
  }

  return null;
}

String _decodeBase64(String str) {
  String output = str.replaceAll('-', '+').replaceAll('_', '/');

  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!');
  }

  return utf8.decode(base64Url.decode(output));
}