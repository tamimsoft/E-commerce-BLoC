part of 'slider_bloc.dart';

sealed class SliderEvent extends Equatable {
  const SliderEvent();

  @override
  List<Object?> get props => [];
}

class SliderEventLoadSlider extends SliderEvent {}
class SliderEventUpdateSliderIndex extends SliderEvent {
  final int newIndex;

  const SliderEventUpdateSliderIndex(this.newIndex);

  @override
  List<Object?> get props => [newIndex];
}