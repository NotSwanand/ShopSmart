import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 690));

    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      body: Stack(
        children: [
          /// 🖼️ **Background Image (Covers Full Screen)**
          Positioned.fill(
            child: Image.asset(
              'lib/images/start.png', // Make sure this path is correct
              fit: BoxFit.cover, // Covers the whole screen
            ),
          ),

          /// 🔽 **Curved White Section at Bottom**
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: CurveClipper(),
              child: Container(
                width: double.infinity,
                height: 300.h, // Reduced height for better balance
                color: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 80.h,),
                    Text(
                      "ShopSmart",
                      style: GoogleFonts.lobster(
                        fontSize: 44.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 0.h), // Adjusted spacing
                    Text(
                      "Scan. Shop. Go!",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.pacifico(
                        fontSize: 21.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      "Effortless Shopping at Your Fingertips!",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade700,
                      ),
                    ),
                    Spacer(), // Pushes button down
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/startpagecontroller');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: EdgeInsets.symmetric(
                          horizontal: 40.w,
                          vertical: 15.h,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                      ),
                      child: Text(
                        "Start Shopping",
                        style: GoogleFonts.poppins(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),

                    ),
                    SizedBox(height: 25.h), // Prevents button clipping
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ✅ **Fixed Curved Clipper**
class CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.3); // Lower curve start
    path.quadraticBezierTo(
      size.width / 2, size.height * 0.05, // Less steep curve
      size.width, size.height * 0.3,
    );
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
