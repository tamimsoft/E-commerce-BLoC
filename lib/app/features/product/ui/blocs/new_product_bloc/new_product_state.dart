part of 'new_product_bloc.dart';

enum Status { empty, loading, loaded, error }

class NewProductState extends Equatable {
  final Status status;
  final String errorMsg;
  final List<ProductModel> productList;

  const NewProductState({
    this.status = Status.empty,
    this.errorMsg = '',
    this.productList = const [],
  });
  NewProductState copyWith({
    Status? status,
    String? errorMsg,
    List<ProductModel>? productList,
  }) {
    return NewProductState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      productList: productList ?? this.productList,
    );
  }

  @override
  List<Object?> get props => [status, errorMsg, productList];
}
