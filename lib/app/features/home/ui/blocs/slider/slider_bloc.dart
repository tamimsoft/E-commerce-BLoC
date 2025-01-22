import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/slider_model.dart';
import '../../../services/slider_service.dart';

part 'slider_event.dart';

part 'slider_state.dart';

class SliderBloc extends Bloc<SliderEvent, SliderState> {
  final SliderService _sliderService;

  SliderBloc(this._sliderService) : super(SliderState()) {
    on<SliderEventLoadSlider>(_onLoadSlider);
    on<SliderEventUpdateSliderIndex>(_onUpdateSliderIndex);
  }

  Future<void> _onLoadSlider(SliderEventLoadSlider event, Emitter<SliderState> emit) async {
    emit(state.copyWith(status: SliderStatus.loading));
    try {
      final sliders = await _sliderService.getSliders();
      if (sliders.isNotEmpty) {
        emit(state.copyWith(status: SliderStatus.loaded, sliderList: sliders));
      } else {
        emit(state.copyWith(status: SliderStatus.empty, sliderList: []));
      }
    } catch (e) {
      emit(state.copyWith(status: SliderStatus.error, errorMessage: e.toString()));
    }
  }

  void _onUpdateSliderIndex(SliderEventUpdateSliderIndex event, Emitter<SliderState> emit) {
    emit(state.copyWith(sliderIndex: event.newIndex));
  }
}
