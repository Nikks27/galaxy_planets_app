import 'dart:math';
import 'dart:ui';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../../provider/solar_provider.dart';
import 'details_page.dart';
import 'favourite_screen.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _rotationController;
  late final Animation<double> _rotationAnimation;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    // Initialize the Tween for rotation
    _rotationAnimation =
        Tween<double>(begin: 0, end: 2 * pi).animate(_rotationController);
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  final List<Widget> _pages = [
    const HomePage(),
    const FavouriteScreen(),
    const DetailsScreen(), // Placeholder for other screens
    const FavouriteScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final providerTrue = Provider.of<SolarProvider>(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF00172D), Color(0xFF03203C)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/night.jpg'),
          ),
        ),
        child: Column(
          children: [
            // Profile and Coins Section
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "EXPLORE SYSTEM",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            "Karim Space",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Container(
                  //   padding:
                  //       const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  //   decoration: BoxDecoration(
                  //     color: Colors.black.withOpacity(0.3),
                  //     borderRadius: BorderRadius.circular(20),
                  //   ),
                  //   child: Row(
                  //     children: [
                  //       Icon(Icons.star, color: Colors.yellow, size: 18),
                  //       SizedBox(width: 4),
                  //       Text(
                  //         "12334",
                  //         style: TextStyle(
                  //             color: Colors.white, fontWeight: FontWeight.bold),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  height: 56,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    // Transparent color effect
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        Icons.search,
                        color: Color(0xffB8B8B8),
                        size: 25,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Search for planets and stars',
                        style: TextStyle(
                          color: const Color(0xffB8B8B8),
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Swiper(
                itemCount: providerTrue.solarList.length,
                itemBuilder: (context, index) {
                  // Retrieve the primary color for the current planet
                  // final planetColor = providerTrue.getPlanetColor(index);

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 300,
                        width: 250,
                        decoration: BoxDecoration(
                          color: Colors.white, // Default card background color
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              // Shadow color
                              blurRadius: 20,
                              // Blur radius for shadow
                              spreadRadius: 5,
                              // Spread radius for shadow
                              offset: const Offset(0, 10), // Shadow position
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 90),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                providerTrue.solarList[index].name,
                                style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color:
                                  Colors.black, // Text color matches the planet color
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                'Solar System',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color:
                                  Colors.black26, // Text color matches the planet color
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: TextButton(
                                onPressed: () {
                                  providerTrue.changePlanteIndex(index);
                                  Navigator.of(context).push(PageTransition(
                                    duration: const Duration(milliseconds: 500),
                                    child: const DetailsScreen(),
                                    type: PageTransitionType.fade,
                                  ));
                                },
                                child: Text(
                                  "Know More ->",
                                  style: TextStyle(
                                    color: Colors.black,
                                    // Text color matches the planet color
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        child: Container(
                          height: 230,
                          width: 230,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage(
                                  providerTrue.solarList[index].image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
                itemWidth: MediaQuery.of(context).size.width * 0.8,
                // Set the item width
                itemHeight: MediaQuery.of(context).size.height * 0.6,
                // Set the item height
                layout: SwiperLayout
                    .TINDER, // Use the TINDER layout for a card-like effect
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25.0,left: 15,right: 15,top: 40),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5), // Transparent black\
                        borderRadius: BorderRadius.circular(50)
                    ),
                    child: BottomNavigationBar(
                      currentIndex: _selectedIndex,
                      onTap: (index) {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      // Transparent background
                      elevation: 0,
                      // Removes shadow
                      selectedItemColor: Colors.orange,
                      unselectedItemColor: Colors.grey,
                      items: const [
                        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                        BottomNavigationBarItem(
                            icon: Icon(Icons.favorite), label: 'Favorites'),
                        BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Info'),
                        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // Animated Bottom Navigation Bar
    );
  }
}

int _currentIndex = 0;