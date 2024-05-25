import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/views/main_screen/main_page.dart';
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
        Get.to(const MainPage());
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
            // logo image ======================================================
            Image.asset(
              ImgLogoPart1,
              fit: BoxFit.cover,
            )
                .box
                .size(
                  Dimension.widthSize(200),
                  Dimension.heightSize(200),
                )
                .make(),
            // rive animation ==================================================
            Container(
              // color: Colors.blue,
              // width: Dimension.widthSize(400),
              height: Dimension.heightSize(300),
              child: const RiveAnimation.asset(
                'assets/rive/rive_loader_animation.riv',
              ),
            ),
          ],
        )
            .box
            // .color(Colors.blue)
            .size(Dimension.screenWidth, Dimension.screenHeight)
            .make(),
      ),
    );
  }
}
