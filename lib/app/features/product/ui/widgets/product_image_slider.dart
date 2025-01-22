import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce2/app/features/common/widgets/custom_network_image.dart';
import 'package:ecommerce2/app/features/common/widgets/shimmer_placeholder.dart';
import 'package:ecommerce2/app/features/product/ui/blocs/product_details_bloc/product_details_bloc.dart';
import 'package:ecommerce2/app/utils/constants/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

class ProductImageSlider extends StatefulWidget {
  const ProductImageSlider({super.key});

  @override
  State<ProductImageSlider> createState() => _ProductImageSliderState();
}

class _ProductImageSliderState extends State<ProductImageSlider> {
  final ValueNotifier<int> _notifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
      builder: (context, state) {
        if (state.status == Status.loading) {
          return const ShimmerPlaceholder(height: 250);
        } else if (state.status == Status.error) {
          return const Center(child: Text('Error'));
        } else if (state.status == Status.empty) {
          return const Center(child: Text('No data'));
        }
        return Stack(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 250.0,
                viewportFraction: 1.0,
                autoPlay: true,
                onPageChanged: (index, _) {
                  _notifier.value = index;
                },
              ),
              items: state.productDetails!.images.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      // width: MediaQuery.of(context).size.width,
                      // margin: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: const BoxDecoration(color: AppColors.greyLight
                          // Match the border radius of the TextFormField
                          ),
                      child: SizedBox(
                        width: double.infinity,
                        child: CustomNetworkImage(
                            imageUrl:
                                state.productDetails!.images[_notifier.value],
                            width: 200),
                        // child: Image.asset(ImagePath.shoePng, width: 200),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 8,
              child: ValueListenableBuilder(
                valueListenable: _notifier,
                builder: (context, value, w) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 8,
                    children: [
                      for (int i = 0;
                          i < state.productDetails!.images.length;
                          i++)
                        Container(
                          width: 13,
                          height: 13,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey.shade300),
                              color: i == value
                                  ? AppColors.primary
                                  : Colors.transparent),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
