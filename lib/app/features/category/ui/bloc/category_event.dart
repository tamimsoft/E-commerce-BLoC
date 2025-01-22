part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object?> get props => [];
}

class CategoryEventLoadCategory extends CategoryEvent {}

class CategoryEventLoadCategoryProductList extends CategoryEvent {
  final int categoryId;

  const CategoryEventLoadCategoryProductList({required this.categoryId});

  @override
  List<Object?> get props => [categoryId];
}
