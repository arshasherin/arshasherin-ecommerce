import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/Screens.dart/dashboard_first_screen.dart';
import 'package:ecommerce/Screens.dart/honevm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dashboard_second_screen.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  int _selectedIndex = 0;
  TextEditingController SearchController = TextEditingController();
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<String> imageList = ['assets/eImage1.jpg', 'assets/eImage5.jpg', 'assets/eImage3.jpg', 'assets/eImage4.jpg', 'assets/eImage5.jpg'];

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeDashboardVm>(builder: (context, vm, child) {
      return Scaffold(
        body: SafeArea(
          child: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  const DashBoardFirstScreen(),
                  const SizedBox(height: 8),
                  Container(
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: SearchController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Search',
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontWeight: FontWeight.normal,
                          fontSize: 15,
                        ),
                        suffixIcon: const Icon(Icons.search, color: Colors.grey),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 15.0,
                          horizontal: 20.0,
                        ),
                      ),
                      onSubmitted: (value) {
                        vm.getProduct(category: "", query: value);
                        vm.refresh();
                      },
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 150,
                    width: double.infinity,
                    child: CarouselSlider(
                      items: imageList
                          .map((item) => Container(
                                margin: const EdgeInsets.all(5.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  image: DecorationImage(
                                    image: AssetImage(item),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ))
                          .toList(),
                      options: CarouselOptions(
                        height: 150,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Expanded(child: DashboardSecondScreen()),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_shopping_cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.grey,
        ),
      );
    });
  }
}
