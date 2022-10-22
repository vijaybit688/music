import 'dart:convert';

import 'package:connectivity/connectivity.dart';

import 'package:http/http.dart' as http;
import 'package:music/api.dart';

import '../functions/connection_checker.dart';
import '../models/track_list_model.dart';
import '../models/track_lyrics.dart';

class TrackLyricsService {
  Future<TrackLyricsModel> trackLyricsService({required String? trackID}) async {
    var response = await http.get(
        Uri.parse(API.TRACK_LYRICS_ENDPOINT + trackID! + "&" + API.API_KEY));

    final trackLyrics = TrackLyricsModel.fromJson(jsonDecode(response.body));
    return trackLyrics;
  }
}
