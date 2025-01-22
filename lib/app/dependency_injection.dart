import 'package:ecommerce2/app/database/app_database.dart';
import 'package:ecommerce2/app/features/auth/data/repository/auth_api_repository.dart';
import 'package:ecommerce2/app/features/auth/service/auth_service.dart';
import 'package:ecommerce2/app/features/cart/data/repository/cart_api_repository.dart';
import 'package:ecommerce2/app/features/cart/data/repository/cart_db_repository.dart';
import 'package:ecommerce2/app/features/cart/service/cart_service.dart';
import 'package:ecommerce2/app/features/category/data/repository/category_api_repository.dart';
import 'package:ecommerce2/app/features/category/data/repository/category_db_repository.dart';
import 'package:ecommerce2/app/features/category/service/category_service.dart';
import 'package:ecommerce2/app/features/favorite/data/repository/favorite_api_repository.dart';
import 'package:ecommerce2/app/features/favorite/data/repository/favorite_db_repository.dart';
import 'package:ecommerce2/app/features/favorite/service/favorite_service.dart';
import 'package:ecommerce2/app/features/home/data/repository/slider_api_repository.dart';
import 'package:ecommerce2/app/features/home/data/repository/slider_db_repository.dart';
import 'package:ecommerce2/app/features/home/services/slider_service.dart';
import 'package:ecommerce2/app/features/product/data/repository/product_api_repository.dart';
import 'package:ecommerce2/app/features/product/data/repository/product_db_repository.dart';
import 'package:ecommerce2/app/features/product/service/product_service.dart';
import 'package:ecommerce2/app/utils/network/api_client.dart';
import 'package:get_it/get_it.dart';


final getIt = GetIt.instance;

void configureDependencies() {
  // Register AppDatabase and ApiClient
  getIt.registerLazySingleton<AppDatabase>(() => AppDatabase());
  getIt.registerLazySingleton<ApiClient>(() => ApiClient());

  // Authentication
  getIt.registerLazySingleton<AuthApiRepository>(() => AuthApiRepository(getIt<ApiClient>()));
  getIt.registerLazySingleton<AuthService>(() => AuthService(getIt<AuthApiRepository>()));

  // Slider
  getIt.registerLazySingleton<SliderApiRepository>(() => SliderApiRepository(getIt<ApiClient>()));
  getIt.registerLazySingleton<SliderDBRepository>(() => SliderDBRepository(getIt<AppDatabase>()));
  getIt.registerLazySingleton<SliderService>(() => SliderService(
        getIt<SliderApiRepository>(),
        getIt<SliderDBRepository>(),
      ));

  // Category
  getIt.registerLazySingleton<CategoryDbRepository>(() => CategoryDbRepository(getIt<AppDatabase>()));
  getIt.registerLazySingleton<CategoryApiRepository>(() => CategoryApiRepository(getIt<ApiClient>()));
  getIt.registerLazySingleton<CategoryService>(() => CategoryService(
        getIt<CategoryDbRepository>(),
        getIt<CategoryApiRepository>(),
      ));

  // Product
  getIt.registerLazySingleton<ProductDbRepository>(() => ProductDbRepository(getIt<AppDatabase>()));
  getIt.registerLazySingleton<ProductApiRepository>(() => ProductApiRepository(getIt<ApiClient>()));
  getIt.registerLazySingleton<ProductService>(() => ProductService(
        getIt<ProductDbRepository>(),
        getIt<ProductApiRepository>(),
      ));

  // Cart
  getIt.registerLazySingleton<CartDbRepository>(() => CartDbRepository(getIt<AppDatabase>()));
  getIt.registerLazySingleton<CartApiRepository>(() => CartApiRepository(getIt<ApiClient>()));
  getIt.registerLazySingleton<CartService>(() => CartService(
        getIt<CartDbRepository>(),
        getIt<CartApiRepository>(),
      ));
  // Favorite
  getIt.registerLazySingleton<FavoriteDbRepository>(() => FavoriteDbRepository(getIt<AppDatabase>()));
  getIt.registerLazySingleton<FavoriteApiRepository>(() => FavoriteApiRepository(getIt<ApiClient>()));
  getIt.registerLazySingleton<FavoriteService>(() => FavoriteService(
        getIt<FavoriteDbRepository>(),
        getIt<FavoriteApiRepository>(),
      ));
}
