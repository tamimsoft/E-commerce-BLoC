class ApiConstants {
  ApiConstants._();

  static const Duration receiveTimeout = Duration(seconds: 20);
  static const Duration connectionTimeout = Duration(seconds: 20);
  static const String _baseUrl = 'https://ecommerce-api.codesilicon.com/api';

  // Authorization
  static const String signUp = '$_baseUrl/auth/signup';
  static const String otpVerify = '$_baseUrl/auth/verify-otp';
  static const String login = '$_baseUrl/auth/login';
  static const String profile = '$_baseUrl/auth/profile';

  // Product
  static const productsSlider = '$_baseUrl/ListProductSlider';
  static const brandList = '$_baseUrl/BrandList';
  static const categoryList = '$_baseUrl/CategoryList';

  static String productListByRemark(String remark) => '$_baseUrl/ListProductByRemark/$remark';

  static String productListByBrand(int brandId) => '$_baseUrl/ListProductByBrand/$brandId';

  static String productListByCategory(int categoryId) => '$_baseUrl/ListProductByCategory/$categoryId';

  static String productDetailsById(int productId) => '$_baseUrl/ProductDetailsById/$productId';

  // Favorite List
  static const favoriteList = '$_baseUrl/ProductWishList';

  static String addToFavoriteList(int productId) => '$_baseUrl/CreateWishList/$productId';

  static String removeFromFavoriteList(int productId) => '$_baseUrl/RemoveWishList/$productId';

  // Cart List
  static const cartList = '$_baseUrl/CartList';

  static const String addToCartList = '$_baseUrl/CreateCartList';

  static String removeFromCartList(int productId) => '$_baseUrl/DeleteCartList/$productId';

  // Payment
  static const paymentSuccess = '$_baseUrl/PaymentSuccess';
  static const paymentCancel = '$_baseUrl/PaymentCancel';
  static const paymentFail = '$_baseUrl/PaymentFail';
  static const paymentIPN = '$_baseUrl/PaymentIPN';

  // Invoice
  static const invoiceList = '$_baseUrl/InvoiceList';
  static const createInvoice = '$_baseUrl/InvoiceCreate';
  static const invoiceProductList = '$_baseUrl/InvoiceProductList';

  // Review
  static String reviewListByProduct(int productId) => '$_baseUrl/ListReviewByProduct/$productId';
  static const createProductReview = '$_baseUrl/CreateProductReview';

  // Privacy policy
  static const policyByType = '$_baseUrl/PolicyByType';
}
