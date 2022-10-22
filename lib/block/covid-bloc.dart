import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:music/models/track_list_model.dart';

import '../services/repositry.dart';

part 'covid-event.dart';
part 'covid-state.dart';

class CovidBloc extends Bloc<CovidEvent, CovidState> {
  CovidBloc() : super(CovidInitial()) {
    final APIProvider _apiRepository = APIProvider();

    on<GetCovidList>((event, emit) async {
      emit(CovidLoading());
      final mList = await _apiRepository.trackListService();
      emit(CovidLoaded(mList));
      if (mList.error != null) {
        emit(CovidError(mList.error));
      }
    });
  }
}
