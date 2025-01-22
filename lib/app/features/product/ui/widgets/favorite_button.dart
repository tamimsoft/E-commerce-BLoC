import 'package:ecommerce2/app/dependency_injection.dart';
import 'package:ecommerce2/app/features/favorite/ui/bloc/favorite_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key, required this.productId});

  final int productId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteBloc(getIt())..add(FavoriteEventLoadProduct()),
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return BlocBuilder<FavoriteBloc, FavoriteState>(
      builder: (context, state) {
        return InkWell(
          onTap: () {
            final bloc = context.read<FavoriteBloc>();
            final isFavorite = bloc.state.favoriteList.any((element) => element.productId == productId);

            if (isFavorite) {
              bloc.add(FavoriteEventRemoveFromFavoriteList(productId: productId));
            } else {
              bloc.add(FavoriteEventAddToFavoriteList(productId: productId));
            }
          },
          borderRadius: BorderRadius.circular(24),
          child: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.grey.shade300,
                width: 0.5,
              ),
            ),
            child: BlocBuilder<FavoriteBloc, FavoriteState>(
              builder: (context, state) {
                bool isFavorite = state.favoriteList.any((element) => element.productId == productId);

                return Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : null,
                  size: 20,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
