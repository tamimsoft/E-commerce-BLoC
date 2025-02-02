import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../common/widgets/shimmer_placeholder.dart';
import '../../data/models/slider_model.dart';

class SliderItem extends StatelessWidget {
  const SliderItem({
    super.key,
    required this.slider,
  });

  final SliderModel slider;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return CachedNetworkImage(
      imageUrl: slider.image.toString(),
      imageBuilder: (context, imageProvider) => Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(horizontal: 16.0),
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover, // Fit the image as needed
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 200,
              child: Text(
                slider.title.toString(),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: textTheme.titleMedium!.copyWith(color: AppColors.primary),
              ),
            ),
            SizedBox(
              width: 112,
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Buy Now',
                  style: textTheme.labelMedium!.copyWith(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
      placeholder: (context, url) => const ShimmerPlaceholder(margin: EdgeInsets.symmetric(horizontal: 16)),
      errorWidget: (context, url, error) => const Center(
        child: Icon(Icons.error), // Show error icon if loading fails
      ),
    );
  }
}
