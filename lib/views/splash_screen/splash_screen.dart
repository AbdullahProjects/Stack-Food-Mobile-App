import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/views/auth_screens/sign_in_or_login_screen.dart';
import 'package:food_delivery/views/auth_screens/signup_screen.dart';
import 'package:food_delivery/views/main_screen/main_page.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // late RiveAnimationController riveController;
  // Function to navigate to the SignUpScreen after a delay
  changeScreen() {
    Future.delayed(
      const Duration(seconds: 8),
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
    // riveController = SimpleAnimation("rive_loader_animation");
    changeScreen();
  }

  // @override
  // void dispose() {
  //   riveController.dispose();
  //   super.dispose();
  // }

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
            // rive animation ==================================================
            SizedBox(
              height: Dimension.heightSize(300),
              child: const RiveAnimation.asset(
                'assets/rive/rive_loader_animation.riv',
                // controllers: [riveController],
              ),
            ),
          ],
        ).box.size(Dimension.screenWidth, Dimension.screenHeight).make(),
      ),
    );
  }
}
