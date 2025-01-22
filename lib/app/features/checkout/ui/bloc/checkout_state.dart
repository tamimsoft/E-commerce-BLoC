part of 'checkout_bloc.dart';

enum Status { empty, loading, loaded, error, success }

class CheckoutState extends Equatable {

  final Status status;
  final String errorMsg;
  final List<ProductModel> productList;

  const CheckoutState({
    this.status = Status.empty,
    this.errorMsg = '',
    this.productList = const [],
  });

  CheckoutState copyWith({
    Status? status,
    String? errorMsg,
    List<ProductModel>? productList,
  }) {
    return CheckoutState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      productList: productList ?? this.productList,
    );
  }

  @override
  List<Object?> get props => [status, errorMsg, productList];
}
