part of 'favorite_bloc.dart';

enum Status { empty, loading, loaded, error }

class FavoriteState extends Equatable {
  final Status status;
  final String errorMsg;
  final List<FavoriteModel> favoriteList;

  const FavoriteState({
    this.status = Status.empty,
    this.errorMsg = '',
    this.favoriteList = const [],
  });

  FavoriteState copyWith({
    Status? status,
    String? errorMsg,
    List<FavoriteModel>? favoriteList,
  }) {
    return FavoriteState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      favoriteList: favoriteList ?? this.favoriteList,
    );
  }

  @override
  List<Object?> get props => [status, errorMsg, favoriteList];
}
