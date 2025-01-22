part of 'slider_bloc.dart';

enum SliderStatus { empty, loading, loaded, error }

class SliderState extends Equatable {
  final SliderStatus status;
  final List<SliderModel> sliderList;
  final int sliderIndex;
  final String errorMessage;

  const SliderState({
    this.status = SliderStatus.empty,
    this.sliderList = const [],
    this.sliderIndex = 0,
    this.errorMessage = '',
  });

  SliderState copyWith({
    SliderStatus? status,
    List<SliderModel>? sliderList,
    int? sliderIndex,
    String? errorMessage,
  }) {
    return SliderState(
      status: status ?? this.status,
      sliderList: sliderList ?? this.sliderList,
      sliderIndex: sliderIndex ?? this.sliderIndex,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, sliderList, sliderIndex, errorMessage];
}
