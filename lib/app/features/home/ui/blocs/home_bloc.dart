import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/slider_model.dart';
import '../../services/slider_service.dart';

part 'home_state.dart';

part 'home_event.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SliderService _sliderService;

  HomeBloc(this._sliderService) : super(HomeState()) {
    on<HomeEventLoadSlider>(_onLoadSlider);
  }

  Future<void> _onLoadSlider(HomeEventLoadSlider event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final sliders = await _sliderService.getSliders();
      if (sliders.isNotEmpty) {
        emit(state.copyWith(status: HomeStatus.loaded, sliderList: sliders));
      } else {
        emit(state.copyWith(status: HomeStatus.empty, sliderList: []));
      }
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.error, errorMessage: e.toString()));
    }
  }
}
