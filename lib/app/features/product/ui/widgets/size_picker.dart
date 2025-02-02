import 'package:fakestore/app/common/widgets/shimmer_placeholder.dart';
import 'package:fakestore/app/features/product/ui/blocs/product_details_bloc/product_details_bloc.dart';
import 'package:fakestore/app/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SizePicker extends StatelessWidget {
  const SizePicker({
    super.key,
    required this.onChange,
  });

  final Function(String) onChange;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Size',
            style: textTheme.titleMedium,
            textAlign: TextAlign.start,
          ),
          BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
            builder: (context, state) {
              if (state.status == Status.loaded) {
                return Row(spacing: 8, children: buildSizeList(context, state));
              }
              return Row(spacing: 8, children: buildSizesPlaceholder);
            },
          ),
        ],
      ),
    );
  }

  List<Widget> get buildSizesPlaceholder {
    return List.generate(
        4,
        (index) => ShimmerPlaceholder(
              borderRadius: BorderRadius.circular(50),
              width: 32,
              height: 32,
            ));
  }

  List<Widget> buildSizeList(BuildContext context, ProductDetailsState state) {
    return state.productDetails!.sizes.map((sizeName) {
      final firstSizeName = state.productDetails!.sizes.first;
      return _buildSizeItem(
        size: sizeName,
        onTap: () => onChange(sizeName),
        isSelected: state.sizeName.isNotEmpty ? state.sizeName == sizeName : firstSizeName == sizeName,
      );
    }).toList();
  }

  Widget _buildSizeItem({required String size, required VoidCallback onTap, bool isSelected = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(4),
        height: 32,
        width: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.grey),
          color: isSelected ? AppColors.primary : null,
        ),
        child: FittedBox(
          child: Text(
            size,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.w600 : null,
              color: isSelected ? Colors.white : null,
            ),
          ),
        ),
      ),
    );
  }
}
