import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:ogo/core/constants/api_endpoints.dart';
import 'package:ogo/core/constants/app_contants.dart';
import 'package:ogo/features/tv/models/now_playing_in_tv.dart';

class AuthAPITv {
  
  static Future<Map<String, dynamic>> getAllNowPlayingTv(int pageNumber) async {
    final response = await http.get(
      Uri.parse('${OAppEndPoints.nowPlayingTv}?page=$pageNumber'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${OAppConstants.tvdbKey}',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      NowPlayingTv nowPlayingtv = NowPlayingTv.fromJson(data);

      return {
        "success": true,
        "res": nowPlayingtv,
      };
    }else{
      return {
        "success":false,
        "res":response.body,
      };
    }
  }
}
