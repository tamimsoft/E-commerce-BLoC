part of 'popular_product_bloc.dart';

enum Status { empty, loading, loaded, error }

class PopularProductState extends Equatable {
  final Status status;
  final String errorMsg;
  final List<ProductModel> productList;

  const PopularProductState({
    this.status = Status.empty,
    this.errorMsg = '',
    this.productList = const [],
  });
  PopularProductState copyWith({
    Status? status,
    String? errorMsg,
    List<ProductModel>? productList,
  }) {
    return PopularProductState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      productList: productList ?? this.productList,
    );
  }

  @override
  List<Object?> get props => [status, errorMsg, productList];
}
