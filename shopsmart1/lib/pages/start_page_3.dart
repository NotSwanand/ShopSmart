import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart'; // Import ScreenUtil

class StartPage3 extends StatelessWidget {
  const StartPage3({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil in the build method
    ScreenUtil.init(context, designSize: const Size(360, 690)); // Base design size

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 80.h), // Adjust top padding using ScreenUtil
            child: Column(
              children: [
                Text(
                  "ShopSmart",
                  style: GoogleFonts.lobster(
                    fontSize: 36.sp, // Adjust font size
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h), // Adjust height using ScreenUtil
                Text(
                  "Scan. Shop. Go!",
                  style: GoogleFonts.pacifico(
                    fontSize: 24.sp, // Adjust font size
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h), // Space before the image
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.only(top: 10.h), // Adjust padding using ScreenUtil
                child: Image.asset(
                  'lib/images/start3.png',
                  fit: BoxFit.cover,
                  height: 300.h, // Dynamically adjust image height using ScreenUtil
                ),
              ),
            ),
          ),
          SizedBox(height: 5.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w), // Adjust padding using ScreenUtil
            child: Column(
              children: [
                Text(
                  "Pay for the products before heading towards exit",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.prozaLibre(
                    fontSize: 22.sp, // Adjust font size
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 20.h), // Add space between text and button
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/authcheck');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(20.w), // Adjust button padding
                    backgroundColor: Colors.green.shade700,
                    shape: const CircleBorder(),
                  ),
                  child: Icon(
                    Icons.arrow_forward, // The right-pointing arrow icon
                    size: 30.sp, // Adjust icon size using ScreenUtil
                    color: Colors.white, // Set the color of the arrow
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h), // Add space at the bottom to avoid overflow
        ],
      ),
    );
  }
}