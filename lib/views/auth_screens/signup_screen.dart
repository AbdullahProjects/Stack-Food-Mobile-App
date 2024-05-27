import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/views/auth_screens/sign_in_or_login_screen.dart';
import 'package:food_delivery/views/home_screen/home_page.dart';
import 'package:food_delivery/views/main_screen/main_page.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
              children: [
                // logo ==========================================================
                // (Dimension.screenHeight * 0.04).heightBox,
                logoContainer(),
                Dimension.heightSize(20).heightBox,
                // input fields ==================================================
                // email text field
                inputField(
                  controller: null,
                  hintText: "Email",
                  prefixIcon: const Icon(Icons.email),
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
                Dimension.heightSize(8).heightBox,
                // phone text field
                inputField(
                  controller: null,
                  hintText: "Phone",
                  prefixIcon: const Icon(Icons.phone_android_outlined),
                  keyboard: TextInputType.phone,
                ),
                Dimension.heightSize(8).heightBox,
                // name text field
                inputField(
                  controller: null,
                  hintText: "Name",
                  prefixIcon: const Icon(Icons.person),
                  prefixIconColor: AppColors.textColor,
                  keyboard: TextInputType.name,
                ),
                Dimension.heightSize(20).heightBox,
                // signup button =================================================
                authButton(
                  text: "Sign Up",
                  onPress: () {
                    Get.to(() => const MainPage());
                    showToast(
                      context: context,
                      msg: "Signup Successfully",
                      seconds: 5000,
                    );
                  },
                ),
                Dimension.heightSize(15).heightBox,
                mediumText(
                  text: "Have an account?",
                  size: Dimension.widthSize(16),
                  color: AppColors.paraColor,
                ).onTap(() {
                  Get.to(() => const SignInOrLoginScreen());
                }),
                Dimension.heightSize(20).heightBox,
                regularText(
                  text: "Sign up using one of the following methods",
                  color: AppColors.paraColor,
                ),
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
