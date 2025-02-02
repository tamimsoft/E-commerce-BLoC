import 'package:fakestore/app/config/dependency_injection.dart';
import 'package:fakestore/app/features/favorite/ui/bloc/favorite_bloc.dart';
import 'package:fakestore/app/features/product/ui/widgets/product_item.dart';
import 'package:fakestore/app/core/constants/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteListScreen extends StatelessWidget {
  const FavoriteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteBloc(getIt())..add(FavoriteEventLoadProduct()),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return PopScope(
      canPop: false,
      // onPopInvokedWithResult: (_, __) {
      // },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Favorite List'),
        ),
        body: BlocListener<FavoriteBloc, FavoriteState>(
          listener: (context, state) {
            // TODO: implement listener
            debugPrint('state1: ${state.status}');
          },
          child: BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
              debugPrint('state2: ${state.status}');
              if (state.status == Status.loading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state.status == Status.error) {
                return Center(child: Text(state.errorMsg));
              } else if (state.status == Status.empty) {
                return Center(
                    child: Image.asset(
                  ImagePath.noProductPng,
                  width: 150,
                ));
              } else if (state.status == Status.loaded) {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: 8,
                  ),
                  itemCount: state.favoriteList.length,
                  itemBuilder: (context, index) {
                    // return const FittedBox(child: SizedBox());
                    return FittedBox(child: ProductItem(product: state.favoriteList[index].product!));
                  },
                );
              }
              return SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
