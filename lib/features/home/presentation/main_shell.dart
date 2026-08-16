import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopora/features/home/presentation/home_screen.dart';
import 'package:shopora/features/categories/presentation/categories_screen.dart';
import 'package:shopora/features/wishlist/presentation/wishlist_screen.dart';
import 'package:shopora/features/cart/presentation/cart_screen.dart';
import 'package:shopora/features/profile/presentation/profile_screen.dart';
import 'package:shopora/shared/widgets/custom_bottom_nav_bar.dart';

class MainShell extends ConsumerStatefulWidget {
  final int initialIndex;
  const MainShell({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  ConsumerState<MainShell> createState() => _MainShellState();
}

class _MainShellState extends ConsumerState<MainShell> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  final List<Widget> _screens = const [
    HomeScreen(),
    CategoriesScreen(),
    WishlistScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
