import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int pageIndex;
  const CustomBottomNavigation({super.key, required this.pageIndex});

  void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home/0');
        break;
      case 1:
        context.go('/home/1');
        break;
      case 2:
        context.go('/home/2');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: pageIndex,
      onTap: (value) => onItemTapped(context, value),
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_max), label: 'Inicio'),
        BottomNavigationBarItem(icon: Icon(Icons.label_important_outline), label: 'Categories'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_outline), label: 'Davoritos'),
      ],
    );
  }
}
