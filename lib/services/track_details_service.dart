import 'dart:convert';

import 'package:connectivity/connectivity.dart';

import 'package:http/http.dart' as http;
import 'package:music/api.dart';

import '../functions/connection_checker.dart';
import '../models/track_detail_model.dart';
import '../models/track_list_model.dart';

class TrackDetailsService {
  static Future<TrackDetailModel> trackDetailService(
      {required String? trackID}) async {
    var response = await http.get(
        Uri.parse(API.TRACK_DETAIL_ENDPOINT + trackID! + "&" + API.API_KEY));

    final trackList = TrackDetailModel.fromJson(jsonDecode(response.body));
    return trackList;
  }
}
