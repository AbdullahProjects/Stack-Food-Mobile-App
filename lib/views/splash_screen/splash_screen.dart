import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/views/auth_screens/signup_screen.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  changeScreen() {
    Future.delayed(
      const Duration(seconds: 8),
      () {
        Get.to(() => const SignUpScreen());
      },
    );
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
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
            // rive animation ==================================================
            SizedBox(
              height: Dimension.heightSize(300),
              child: const RiveAnimation.asset(
                'assets/rive/rive_loader_animation.riv',
              ),
            ),
          ],
        )
            .box
            .size(Dimension.screenWidth, Dimension.screenHeight)
            .make(),
      ),
    );
  }
}
