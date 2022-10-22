import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:music/colors.dart';
import 'package:music/models/track_detail_model.dart';
import 'package:music/models/track_list_model.dart';
import 'package:music/models/track_lyrics.dart';
import 'package:music/services/track_details_service.dart';
import 'package:music/services/track_list_service.dart';
import 'package:music/services/track_lyrics_service.dart';

class TrackDetails extends StatefulWidget {
  TrackDetails({Key? key, required this.trackID}) : super(key: key);
  final String? trackID;
  @override
  State<TrackDetails> createState() => _TrackDetailsState();
}

class _TrackDetailsState extends State<TrackDetails> {
  late TrackLyricsModel lyricsModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    lyrics();
  }

  lyrics() async {
    await TrackLyricsService()
        .trackLyricsService(trackID: widget.trackID)
        .then((value) => {lyricsModel = value});

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: TrackDetailsService.trackDetailService(trackID: widget.trackID),
        builder: (context, AsyncSnapshot<TrackDetailModel> snapshot) {
          return snapshot.data != null
              ? Scaffold(
                  backgroundColor: LIGHT_PURPLE,
                  appBar: AppBar(
                    backgroundColor: DEEP_PURPLE,
                    centerTitle: true,
                    title: const Text(
                      "Track Details",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(18.0),
                          child: Text("Title",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text(
                              snapshot.data?.message?.body?.track?.trackName
                                      .toString() ??
                                  "",
                              style: TextStyle(color: Colors.white)),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(18.0),
                          child: Text("Artist",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text(
                              snapshot.data?.message?.body?.track?.artistName
                                      .toString() ??
                                  "",
                              style: TextStyle(color: Colors.white)),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(18.0),
                          child: Text("Album Name",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text(
                              snapshot.data?.message?.body?.track?.albumName
                                      .toString() ??
                                  "",
                              style: TextStyle(color: Colors.white)),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(18.0),
                          child: Text("Rating",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text(
                              snapshot.data?.message?.body?.track?.trackRating
                                      .toString() ??
                                  "",
                              style: TextStyle(color: Colors.white)),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(18.0),
                          child: Text("Explicit",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text(
                              snapshot.data?.message?.body?.track?.explicit
                                      .toString() ??
                                  "",
                              style: TextStyle(color: Colors.white)),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(18.0),
                          child: Text("Lyrics",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18.0),
                          child: Text(
                              lyricsModel.message?.body?.lyrics?.lyricsBody ??
                                  " ",
                              style: TextStyle(color: Colors.white)),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            color: DEEP_PINK,
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            child: TextButton(
                                onPressed: () async {
                                  Box box = await Hive.openBox('bookMark');

                                  await box.put(
                                      snapshot
                                          .data?.message?.body?.track?.trackName
                                          .toString(),
                                      widget.trackID);
                                },
                                child: Text(
                                  "Save The Track",
                                  style: TextStyle(color: Colors.white),
                                )))
                      ],
                    ),
                  ))
              : Center(child: CircularProgressIndicator());
        });
    trackDetails() {}
  }
}
