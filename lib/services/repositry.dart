import 'dart:convert';

import 'package:connectivity/connectivity.dart';

import 'package:http/http.dart' as http;
import 'package:music/api.dart';

import '../functions/connection_checker.dart';
import '../models/track_detail_model.dart';
import '../models/track_list_model.dart';
import '../models/track_lyrics.dart';

class APIProvider {
  Future<dynamic> trackDetailService({required String trackID}) async {
    var connectivityResult =
        await Connection.sharedInstance.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      var response = await http.get(
          Uri.parse(API.TRACK_DETAIL_ENDPOINT + trackID + "&" + API.API_KEY));
      if (response.statusCode == 200) {
        final trackList = TrackDetailModel.fromJson(jsonDecode(response.body));
        return trackList;
      } else if (response.statusCode == 401) {
        return response.statusCode;
      } else if (response.statusCode == 422) {
        return response.statusCode;
      } else {
        return response.statusCode;
      }
    }
  }

  Future<dynamic> trackListService() async {
    var connectivityResult =
        await Connection.sharedInstance.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      var response =
          await http.get(Uri.parse(API.TRACK_LIST_ENDPOINT + API.API_KEY));
      if (response.statusCode == 200) {
        final trackList = TrackListModel.fromJson(jsonDecode(response.body));
        return trackList;
      } else if (response.statusCode == 401) {
        return response.statusCode;
      } else if (response.statusCode == 422) {
        return response.statusCode;
      } else {
        return response.statusCode;
      }
    }
  }

  Future<dynamic> trackLyricsService({required String trackID}) async {
    var connectivityResult =
        await Connection.sharedInstance.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      var response = await http.get(
          Uri.parse(API.TRACK_LYRICS_ENDPOINT + trackID + "&" + API.API_KEY));
      if (response.statusCode == 200) {
        final trackLyrics =
            TrackLyricsModel.fromJson(jsonDecode(response.body));
        return trackLyrics;
      } else if (response.statusCode == 401) {
        return response.statusCode;
      } else if (response.statusCode == 422) {
        return response.statusCode;
      } else {
        return response.statusCode;
      }
    }
  }
}
