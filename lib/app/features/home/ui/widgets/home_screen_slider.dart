import 'package:carousel_slider/carousel_slider.dart';
import 'package:fakestore/app/config/dependency_injection.dart';
import 'package:fakestore/app/common/widgets/widgets.dart';
import 'package:fakestore/app/features/home/data/models/slider_model.dart';
import 'package:fakestore/app/features/home/ui/blocs/slider/slider_bloc.dart';
import 'package:fakestore/app/features/home/ui/widgets/slider_item.dart';
import 'package:fakestore/app/core/constants/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:flutter/material.dart';

class HomeScreenSlider extends StatelessWidget {
  const HomeScreenSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SliderBloc(getIt())..add(SliderEventLoadSlider()),
      child: Builder(builder: (context) => _buildContent(context)),
    );
  }

  Widget _buildContent(BuildContext context) {
    return BlocBuilder<SliderBloc, SliderState>(
      builder: (context, state) {
        if (state.status == SliderStatus.loading) {
          return _buildSliderShimmerList;
        } else if (state.status == SliderStatus.error) {
          return const Text('Failed to load sliders');
        } else if (state.status == SliderStatus.loaded) {
          return _buildSliderList(state.sliderList);
        } else if (state.status == SliderStatus.empty) {
          return const Text('No sliders found');
        }
        return Text('Something went wrong');
      },
    );
  }

  Widget get _buildSliderShimmerList {
    return Column(
      spacing: 8,
      children: [
        const SizedBox(
          height: 160,
          child: ShimmerPlaceholder(margin: EdgeInsets.symmetric(horizontal: 16)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            for (int i = 0; i < 3; i++)
              const ShimmerPlaceholder(
                width: 13,
                height: 13,
              ),
          ],
        )
      ],
    );
  }

  Widget _buildSliderList(List<SliderModel> sliderList) {
    return Column(
      spacing: 8,
      children: [
        BlocBuilder<SliderBloc, SliderState>(
          builder: (context, state) {
            return CarouselSlider(
              options: CarouselOptions(
                height: 160.0,
                viewportFraction: 1.0,
                autoPlay: true,
                onPageChanged: (index, _) {
                  context.read<SliderBloc>().add(SliderEventUpdateSliderIndex(index));
                },
              ),
              items: state.sliderList.map((item) {
                SliderModel slider = item;
                return Builder(
                  builder: (BuildContext context) {
                    return SliderItem(slider: slider);
                  },
                );
              }).toList(),
            );
          },
        ),
        BlocBuilder<SliderBloc, SliderState>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                state.sliderList.length,
                (index) => Container(
                  width: 13,
                  height: 13,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300),
                    color: index == state.sliderIndex ? AppColors.primary : Colors.transparent,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
