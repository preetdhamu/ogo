import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ogo/core/constants/api_endpoints.dart';

class AuthAPI {
  static Map userdetails = {};

  static Future<bool> authorizeWithBackend(String idToken) async {
    print("Length of token is : ${idToken.length}");
    final response = await http.post(
      Uri.parse(OAppEndPoints.authorizeUser),
      // Uri.parse('http://127.0.0.1:8000/api/authorize-user/'),
      // Uri.parse("http://172.20.10.5:8000/api/authorize-user/"),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $idToken',
      },
    );

    if (response.statusCode == 200) {
      // Parse response if needed, for example checking a specific field
      userdetails = jsonDecode(response.body);

      // Assuming the backend returns a success field for authorization
      return userdetails['success'] == "true";
    } else {
      // Handle other status codes as an authorization failure
      return false;
    }
  }
}
