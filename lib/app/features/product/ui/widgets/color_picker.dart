import 'package:fakestore/app/common/widgets/shimmer_placeholder.dart';
import 'package:fakestore/app/features/product/ui/blocs/product_details_bloc/product_details_bloc.dart';
import 'package:fakestore/app/utils/helper/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ColorPicker extends StatelessWidget {
  const ColorPicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Color',
            style: textTheme.titleMedium,
            textAlign: TextAlign.start,
          ),
          BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
            builder: (context, state) {
              if (state.status == Status.loaded) {
                return Row(spacing: 8, children: buildColorList(context, state));
              }
              return Row(spacing: 8, children: buildColorsPlaceholder);
            },
          ),
        ],
      ),
    );
  }

  List<Widget> get buildColorsPlaceholder {
    return List.generate(
        4,
        (index) => ShimmerPlaceholder(
              borderRadius: BorderRadius.circular(50),
              width: 32,
              height: 32,
            ));
  }

  List<Widget> buildColorList(BuildContext context, ProductDetailsState state) {
    return state.productDetails!.colors.map((colorName) {
      String firstColor = state.productDetails!.colors.first;
      return _buildColorItem(
        color: getColorFromName(colorName),
        onTap: () {
          context.read<ProductDetailsBloc>().add(ProductDetailsEventSelectColor(selectedColor: colorName));
        },
        isSelected: state.colorName.isNotEmpty ? state.colorName == colorName : firstColor == colorName,
      );
    }).toList();
  }

  Widget _buildColorItem({Color? color, required VoidCallback onTap, required bool isSelected}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        height: 32,
        width: 32,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey),
          color: color,
        ),
        child: isSelected
            ? Icon(
                Icons.check,
                color: color == Colors.white ? Colors.black : Colors.white,
                size: 18,
              )
            : null,
      ),
    );
  }
}
