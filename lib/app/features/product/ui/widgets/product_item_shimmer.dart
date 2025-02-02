import 'package:flutter/material.dart';

import '../../../../common/widgets/shimmer_placeholder.dart';

class ProductItemShimmer extends StatelessWidget {
  const ProductItemShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 128,
      child: Card(
        color: Colors.white,
        child: Column(
          spacing: 2,
          children: [
            const ShimmerPlaceholder(
              height: 86,
              width: double.infinity,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            ),
            ShimmerPlaceholder(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              borderRadius: BorderRadius.circular(4),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 2,
                children: [
                  Expanded(
                    child: ShimmerPlaceholder(
                      height: 22,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  ShimmerPlaceholder(
                    width: 22,
                    height: 22,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  ShimmerPlaceholder(
                    width: 22,
                    height: 22,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
