

import 'package:fakestore/app/core/constants/api_constants.dart';
import 'package:fakestore/app/core/services/network/api_client.dart';
import 'package:fakestore/app/features/home/data/models/slider_model.dart';

class SliderApiRepository {
  ApiClient apiClient;

  SliderApiRepository( this.apiClient);

  Future<List<SliderModel>> fetchSlideProductList() async {
    try {
      return apiClient.getRequest<List<SliderModel>>(
        endpoint: ApiConstants.productsSlider,
        fromJson: (json) => (json as List).map((i) => SliderModel.fromJson(i)).toList(),
      );
    } catch (e) {
      rethrow;
    }
  }
}
