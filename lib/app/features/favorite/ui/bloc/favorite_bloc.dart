import 'package:fakestore/app/features/favorite/data/model/favorite_model.dart';
import 'package:fakestore/app/features/favorite/service/favorite_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorite_event.dart';

part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteService _favoriteService;
  List<FavoriteModel> tempFavoriteList = [];

  FavoriteBloc(this._favoriteService) : super(FavoriteState()) {
    on<FavoriteEventLoadProduct>(_init);
    on<FavoriteEventAddToFavoriteList>(_onTapAddToFavoriteList);
    on<FavoriteEventRemoveFromFavoriteList>(_onTapRemoveFromFavoriteList);
  }

  Future<void> _init(FavoriteEventLoadProduct event, Emitter<FavoriteState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      tempFavoriteList = await _favoriteService.getFavoriteProducts();
      if (tempFavoriteList.isNotEmpty) {
        emit(state.copyWith(favoriteList: tempFavoriteList));
        emit(state.copyWith(status: Status.loaded));
      } else {
        emit(state.copyWith(status: Status.empty));
      }
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }

  Future<void> _onTapAddToFavoriteList(FavoriteEventAddToFavoriteList event, Emitter<FavoriteState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      await _favoriteService.addToFavorite(productId: event.productId);
      tempFavoriteList.add(FavoriteModel(productId: event.productId));
      emit(state.copyWith(favoriteList: tempFavoriteList));
      emit(state.copyWith(status: Status.loaded));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }

  Future<void> _onTapRemoveFromFavoriteList(
      FavoriteEventRemoveFromFavoriteList event, Emitter<FavoriteState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      await _favoriteService.removeFromFavorite(productId: event.productId);
      tempFavoriteList.removeWhere((element) => element.productId == event.productId);
      emit(state.copyWith(favoriteList: tempFavoriteList));
      emit(state.copyWith(status: Status.loaded));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }
}
