part of 'favorite_bloc.dart';

sealed class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object?> get props => [];
}

class FavoriteEventLoadProduct extends FavoriteEvent {}

class FavoriteEventAddToFavoriteList extends FavoriteEvent {
  final int productId;

  const FavoriteEventAddToFavoriteList({required this.productId});

  @override
  List<Object?> get props => [productId];
}
class FavoriteEventRemoveFromFavoriteList extends FavoriteEvent {
  final int productId;

  const FavoriteEventRemoveFromFavoriteList({required this.productId});

  @override
  List<Object?> get props => [productId];
}
