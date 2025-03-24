import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shopsmart1/pages/start_page_2.dart';  // Import your StartPage2
import 'package:shopsmart1/pages/start_page_3.dart';  // Import your StartPage3
import 'package:flutter_screenutil/flutter_screenutil.dart'; // Import ScreenUtil

class StartPageController extends StatelessWidget {
  final PageController _controller = PageController();

  StartPageController({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil in the build method
    ScreenUtil.init(context, designSize: const Size(360, 690)); // Base design size

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Center the children
        children: [
          Expanded( // Use Expanded to fill the available space
            child: PageView(
              controller: _controller,
              children: const [
                StartPage2(),
                StartPage3(),
              ],
            ),
          ),
          // Adjusted padding for better visibility of the indicator
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h), // Use ScreenUtil for vertical padding
            child: SmoothPageIndicator(
              controller: _controller,
              count: 2,
              effect: const JumpingDotEffect(
                activeDotColor: Colors.green,
                dotHeight: 13,
                dotWidth: 13,
                spacing: 16,
                verticalOffset: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
