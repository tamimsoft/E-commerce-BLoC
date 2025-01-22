part of 'special_product_bloc.dart';

enum Status { empty, loading, loaded, error }

class SpecialProductState extends Equatable {
  final Status status;
  final String errorMsg;
  final List<ProductModel> productList;

  const SpecialProductState({
    this.status = Status.empty,
    this.errorMsg = '',
    this.productList = const [],
  });
  SpecialProductState copyWith({
    Status? status,
    String? errorMsg,
    List<ProductModel>? productList,
  }) {
    return SpecialProductState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      productList: productList ?? this.productList,
    );
  }

  @override
  List<Object?> get props => [status, errorMsg, productList];
}
