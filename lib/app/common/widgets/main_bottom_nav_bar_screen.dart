import 'package:fakestore/app/features/cart/ui/screens/cart_list_screen.dart';
import 'package:fakestore/app/features/category/ui/screens/category_screen.dart';
import 'package:fakestore/app/common/bloc/main_bloc.dart';
import 'package:fakestore/app/features/favorite/ui/screens/favorite_list_screen.dart';
import 'package:fakestore/app/features/home/ui/screens/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter/material.dart';

class MainBottomNavBarScreen extends StatelessWidget {
  MainBottomNavBarScreen({super.key});

  final List<Widget> pages = [
    const HomeScreen(),
    const CategoryScreen(),
    const CartListScreen(),
    const FavoriteListScreen(),
  ];

  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainBloc(),
      child: Scaffold(
        body: BlocBuilder<MainBloc, MainState>(builder: (context, state) {
          return PageView(
            controller: _pageController,
            onPageChanged: (index) {
              context.read<MainBloc>().add(MainEventChangeIndex(index: index));
            },
            children: pages,
          );
        }),
        bottomNavigationBar: _buildBottomNavigationBar(),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BlocBuilder<MainBloc, MainState>(
      buildWhen: (context, state) => true,
      builder: (context, state) {
        return NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          selectedIndex: state.currentIndex,
          onDestinationSelected: (index) {
            context.read<MainBloc>().add(MainEventChangeIndex(index: index));
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.category_outlined), // Different icon for clarity
              label: 'Category',
            ),
            NavigationDestination(
              icon: Icon(Icons.shopping_basket_outlined),
              // Different icon for clarity
              label: 'Cart',
            ),
            NavigationDestination(
              icon: Icon(Icons.favorite_border), // Different icon for clarity
              label: 'Favorite',
            ),
          ],
        );
      },
    );
  }
}
