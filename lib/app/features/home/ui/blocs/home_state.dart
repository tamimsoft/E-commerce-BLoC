part of 'home_bloc.dart';

enum HomeStatus { empty, loading, loaded, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<SliderModel> sliderList;
  final String errorMessage;

  const HomeState({
    this.status = HomeStatus.empty,
    this.sliderList = const [],
    this.errorMessage = '',
  });

  HomeState copyWith({
    HomeStatus? status,
    List<SliderModel>? sliderList,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      sliderList: sliderList ?? this.sliderList,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, sliderList, errorMessage];
}
