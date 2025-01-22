part of 'product_details_bloc.dart';

enum Status { empty, loading, loadingAddToCartBtn, loaded, error }

class ProductDetailsState extends Equatable {
  final Status status;
  final String errorMsg;
  final String colorName;
  final String sizeName;

  final ProductDetailsModel? productDetails;

  const ProductDetailsState({
    this.status = Status.empty,
    this.errorMsg = '',
    this.productDetails,
    this.colorName = '',
    this.sizeName = '',
  });

  ProductDetailsState copyWith({
    Status? status,
    String? errorMsg,
    ProductDetailsModel? productDetails,
    String? colorName,
    String? sizeName,
  }) {
    return ProductDetailsState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      productDetails: productDetails ?? this.productDetails,
      colorName: colorName ?? this.colorName,
      sizeName: sizeName ?? this.sizeName,
    );
  }

  @override
  List<Object> get props => [status, errorMsg, colorName, sizeName];
}
