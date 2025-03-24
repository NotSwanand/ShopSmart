import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart'; // Import Lottie
import 'cart_page.dart'; // Import your cart page
import 'profile.dart';// Import your profile page
import 'package:shopsmart1/pages/store_map.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});


  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();


  String getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good Morning! ☀️";
    } else if (hour < 18) {
      return "Good Afternoon! 🌤️";
    } else {
      return "Good Evening! 🌙";
    }
  }

  // In home_page.dart
  final List<Widget> _pages = [
    const HomeScreen(),
    const CartPage(), // No scannedProducts param
    const ProfilePage(),
  ];



  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (context, child) => Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: Material(
          elevation: 12, // Creates a floating effect
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)), // Softens edges
          child: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: _selectedIndex,
            height: 55,
            backgroundColor: Color(0xFFA7E92F),
            color: Color(0xFF22A74F),
            buttonBackgroundColor: Color(0xFF4DAF7C),
            animationCurve: Curves.fastOutSlowIn,
            animationDuration: Duration(milliseconds: 600),
            items: const [
              Padding(
                padding: EdgeInsets.only(top: 8), // Adjust the icon's vertical alignment
                child: Icon(Icons.home_filled, size: 35, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Icon(Icons.shopping_cart_outlined, size: 35, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Icon(Icons.person, size: 35, color: Colors.white),
              ),
            ],
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }


}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  final List<Map<String, dynamic>> categories = const [
    {"discount": "UP TO 50% OFF", "title": "Audio & Watches", "lottie": "lib/images/headphones.json"},
    {"discount": "UP TO 40% OFF", "title": "Kitchen Appliances", "lottie": "lib/images/fridge.json"},
    {"discount": "UP TO 30% OFF", "title": "Grocery", "lottie": "lib/images/grocery.json"},
    {"discount": "UP TO 45% OFF", "title": "Lighting", "lottie": "lib/images/bulb.json"},
    {"discount": "UP TO 35% OFF", "title": "Tech Accessories", "lottie": "lib/images/mouse2.json"},
    {"discount": "UP TO 40% OFF", "title": "Charging", "lottie": "lib/images/charger.json"},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    HomePageState().getGreeting(),
                    style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 4.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    "🔥 Best Deals for You!", // Updated heading
                    style: GoogleFonts.notoSerif(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    "  Explore the latest discounts and offers", // Updated subheading
                    style: GoogleFonts.poppins(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],

                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: const Divider(),
                ),
                SizedBox(height: 12.h),

                // Categories Grid
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: Wrap(
                        spacing: 12.w, // Adjusted to match the second snippet
                        runSpacing: 12.h,
                        alignment: WrapAlignment.center,
                        children: categories.map((category) {
                          return Container(
                            width: (MediaQuery.of(context).size.width / 2) - 24.w,
                            constraints: BoxConstraints(minHeight: 130.h), // Adjusted for uniformity
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16.r),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(51, 158, 158, 158), // Equivalent to grey.withOpacity(0.2)
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(16.w), // Adjusted to match second snippet
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  category["discount"]!,
                                  style: GoogleFonts.poppins(
                                    color: Colors.deepOrangeAccent,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 8.h),
                                SizedBox(
                                  width: 60.w, // Adjusted size
                                  height: 60.h, // Adjusted size
                                  child: Lottie.asset(
                                    category["lottie"]!,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  category["title"]!,
                                  style: GoogleFonts.poppins(
                                    color: Colors.grey[800],
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),

          // Positioned Floating Map Button (Top-Right Corner)
          Positioned(
            top: 6.h, // Adjust as needed
            right: 24.w, // Ensures it sticks to the top-right
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StoreMapPage()),
                );
              },
              child: SizedBox(
                width: 40.w, // Adjust size as needed
                height: 40.h,
                child: Lottie.asset("lib/images/map.json"),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
