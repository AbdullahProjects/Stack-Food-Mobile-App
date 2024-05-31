import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/views/auth_screens/sign_in_or_login_screen.dart';
import 'package:food_delivery/views/auth_screens/signup_screen.dart';
import 'package:food_delivery/views/main_screen/main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Function to navigate to the SignUpScreen after a delay
  changeScreen() {
    Future.delayed(
      const Duration(seconds: 5),
      () {
        // if user already login then go to Home Screen, otherwise go to Login Screen
        auth.authStateChanges().listen((User? user) {
          if (user == null) {
            Get.to(() => const SignInOrLoginScreen());
          } else {
            Get.to(() => const MainPage());
          }
        });
        Get.to(() => const SignUpScreen());
      },
    );
  }

  @override
  void initState() {
    super.initState();
    changeScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Dimension.heightSize(20).heightBox,
            // logo image ======================================================
            logoContainer(),
            // best food logo ==================================================
            Image.asset(
              ImgLogoPart2,
              width: Dimension.screenWidth / 1.8,
            ),
            Dimension.heightSize(100).heightBox,
            // restaurant name logo ============================================
            Image.asset(
              ImgLogoName,
              width: Dimension.screenWidth / 1.6,
            ),
          ],
        ).box.size(Dimension.screenWidth, Dimension.screenHeight).make(),
      ),
    );
  }
}
