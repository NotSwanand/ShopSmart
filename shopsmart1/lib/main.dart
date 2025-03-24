import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shopsmart1/pages/register.dart';
import 'package:shopsmart1/pages/forgot_password.dart';
import 'package:shopsmart1/pages/login_page.dart';
import 'package:shopsmart1/pages/home_page.dart';
import 'package:shopsmart1/pages/profile.dart';
import 'package:shopsmart1/pages/store_map.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shopsmart1/pages/cart_page.dart';
import 'package:shopsmart1/pages/auth_check.dart';
import 'package:shopsmart1/pages/start_page.dart';
import 'package:shopsmart1/pages/start_page_2.dart';
import 'package:shopsmart1/pages/start_page_3.dart';
import 'package:shopsmart1/pages/start_page_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  const MyApp({super.key, required this.prefs});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(  // ✅ Ensure ScreenUtil is initialized
      designSize: const Size(360, 690), // Adjust according to your design
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: AuthCheck(prefs: prefs), // ✅ Pass prefs correctly
          routes: {
            '/startpage': (context) => const StartPage(),
            '/startpage2': (context) => const StartPage2(),
            '/startpage3': (context) => const StartPage3(),
            '/startpagecontroller': (context) => StartPageController(),
            '/register': (context) => RegisterPage(),
            '/forgot_password': (context) => ForgotPasswordPage(),
            '/loginpage': (context) => LoginPage(),
            '/homepage': (context) => HomePage(),
            '/mappage': (context) => StoreMapPage(),
            '/profilepage': (context) => ProfilePage(),
            '/cartpage': (context) => const CartPage(), // No scannedProducts
            '/authcheck': (context) => AuthCheck(prefs: prefs), // ✅ Fixed: Pass prefs here
          },
        );
      },
    );
  }
}
