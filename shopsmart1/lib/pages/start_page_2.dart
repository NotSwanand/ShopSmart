import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart'; // Import ScreenUtil

class StartPage2 extends StatelessWidget {
  const StartPage2({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil in the build method
    ScreenUtil.init(context, designSize: const Size(360, 690)); // Base design size

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 80.h), // Adjust padding
            child: Column(
              children: [
                Text(
                  "ShopSmart",
                  style: GoogleFonts.lobster(
                    fontSize: 44.sp, // Adjust font size using ScreenUtil
                    fontWeight: FontWeight.bold,
                    color: Colors.green.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 2.h), // Adjust size
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
          SizedBox(height: 20.h), // Add some space before the image
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Image.asset(
                'lib/images/start2.png',
                fit: BoxFit.cover,
                height: 300.h, // Dynamically adjust height
              ),
            ),
          ),
          SizedBox(height: 5.h),
          Padding(
            padding: EdgeInsets.only(bottom: 50.h, left: 30.w, right: 30.w), // Adjust padding
            child: Column(
              children: [
                Text(
                  "Scan your products before putting them into the cart",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.prozaLibre(
                    fontSize: 22.sp, // Adjust font size
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
