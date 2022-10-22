import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music/models/track_list_model.dart';
import 'package:music/ui/track_detail_screen.dart';

import '../block/covid-bloc.dart';
import 'package:bloc/bloc.dart';

class HomeScree extends StatefulWidget {
  const HomeScree({Key? key}) : super(key: key);

  @override
  State<HomeScree> createState() => _HomeScreeState();
}

class _HomeScreeState extends State<HomeScree> {
  final CovidBloc _covidBloc = CovidBloc();

  @override
  void initState() {
    _covidBloc.add(GetCovidList());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildListCovid();
  }

  Widget _buildListCovid() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _covidBloc,
        child: BlocListener<CovidBloc, CovidState>(
          listener: (context, state) {
            if (state is CovidError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<CovidBloc, CovidState>(
            builder: (context, state) {
              if (state is CovidInitial) {
                return _buildLoading();
              } else if (state is CovidLoading) {
                return _buildLoading();
              } else if (state is CovidLoaded) {
                return _buildCard(context, state.covidModel);
              } else if (state is CovidError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, TrackListModel model) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: model.message?.body?.trackList?.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: DEEP_PURPLE, borderRadius: BorderRadius.circular(10)),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 5,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TrackDetails(
                                    trackID: model.message?.body
                                        ?.trackList![index].track?.trackId
                                        .toString(),
                                  )));
                    },
                    child: ListTile(
                      title: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "${model.message?.body?.trackList![index].track?.trackName} ",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                "${model.message?.body?.trackList![index].track?.albumName} ",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              "${model.message?.body?.trackList![index].track?.artistName} ",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                      leading: Icon(
                        Icons.music_note_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
