import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/views/auth_screens/signup_screen.dart';
import 'package:food_delivery/views/home_screen/home_page.dart';
import 'package:food_delivery/views/main_screen/main_page.dart';

class SignInOrLoginScreen extends StatelessWidget {
  const SignInOrLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(
              top: Dimension.heightSize(30),
              bottom: Dimension.heightSize(80),
              left: Dimension.widthSize(20),
              right: Dimension.widthSize(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // logo ========================================================
                logoContainer(),
                // hello text ==================================================
                Dimension.heightSize(5).heightBox,
                blackText(
                  text: "Hello",
                  color: AppColors.blackColor,
                  size: Dimension.widthSize(50),
                ),
                regularText(
                  text: "Sign in to your account",
                  color: AppColors.paraColor,
                ),
                // input fields ================================================
                Dimension.heightSize(15).heightBox,
                // phone text field
                inputField(
                  controller: null,
                  hintText: "Phone",
                  prefixIcon: const Icon(Icons.phone_android_outlined),
                  keyboard: TextInputType.phone,
                ),
                Dimension.heightSize(8).heightBox,
                // password text field
                inputField(
                  controller: null,
                  hintText: "Password",
                  prefixIcon: const Icon(Icons.password_rounded),
                  isSecure: true,
                  keyboard: TextInputType.number,
                ),
                Dimension.heightSize(20).heightBox,
                // sign in button ==============================================
                authButton(
                  text: "Sign In",
                  onPress: () {
                    Get.to(() => const MainPage());
                    showToast(
                      context: context,
                      msg: "Sign In Successfully",
                      seconds: 5000,
                    );
                  },
                ),
                Dimension.heightSize(15).heightBox,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    mediumText(
                      text: "Don't have an account?",
                      size: Dimension.widthSize(18),
                      color: AppColors.paraColor,
                    ),
                    Dimension.widthSize(5).widthBox,
                    boldText(
                      text: "Create",
                      color: AppColors.titleColor,
                      size: Dimension.widthSize(18),
                    ).onTap(
                      () {
                        Get.to(() => const SignUpScreen());
                      },
                    ),
                  ],
                ).box.makeCentered(),
                Dimension.heightSize(20).heightBox,
                regularText(
                  text: "Sign in using one of the following methods",
                  color: AppColors.paraColor,
                ).box.makeCentered(),
                Dimension.heightSize(15).heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google signup
                    socialIcon(ImgG).onTap(() {
                      showToast(
                        context: context,
                        msg: "Google",
                      );
                    }),
                    Dimension.widthSize(10).widthBox,
                    // twitter signup
                    socialIcon(ImgT).onTap(() {
                      showToast(
                        context: context,
                        msg: "Twitter",
                      );
                    }),
                    Dimension.widthSize(10).widthBox,
                    // facebook signup
                    socialIcon(ImgF).onTap(() {
                      showToast(
                        context: context,
                        msg: "Facebook",
                      );
                    }),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
