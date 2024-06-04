import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/views/auth_screens/forgot_password.dart';
import 'package:food_delivery/views/auth_screens/signup_screen.dart';
import 'package:food_delivery/views/main_screen/main_page.dart';

class SignInOrLoginScreen extends StatelessWidget {
  const SignInOrLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // initializing AuthController
    var authController = Get.put(AuthController());
    // text fields controllers
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var forgotPasswordController = TextEditingController();

    return Scaffold(
      // resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          // physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(
              top: Dimension.heightSize(30),
              bottom: Dimension.heightSize(30),
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
                  controller: emailController,
                  hintText: "Email",
                  prefixIcon: const Icon(Icons.email),
                  keyboard: TextInputType.text,
                ),
                Dimension.heightSize(8).heightBox,
                // password text field
                inputField(
                  controller: passwordController,
                  hintText: "Password",
                  prefixIcon: const Icon(Icons.password_rounded),
                  isSecure: true,
                  keyboard: TextInputType.number,
                ),
                // forgot password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return forgotPassword(
                            controller: forgotPasswordController,
                            onPressed: () async {
                              if (forgotPasswordController.text.trim() != "") {
                                try {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (BuildContext context) {
                                      return loaderDialogbox(
                                          text: "Verifying...");
                                    },
                                  );
                                  await authController.forgotPassword(
                                    forgotPasswordController.text,
                                    context,
                                  );
                                  Navigator.of(context).pop();
                                } catch (e) {
                                  Navigator.of(context).pop();
                                  showToast(
                                    context: context,
                                    msg: e.toString(),
                                    seconds: 5000,
                                  );
                                }
                              } else {
                                showToast(
                                  context: context,
                                  msg: "Enter email to proceed!",
                                  seconds: 5000,
                                );
                              }
                            },
                          );
                        },
                      );
                    },
                    child: mediumText(
                      text: "Forgot Password?",
                    ),
                  ),
                ),
                // sign in button ==============================================
                authButton(
                  text: "Sign In",
                  onPress: () async {
                    if (emailController.text.trim() != "" &&
                        passwordController.text.trim() != "") {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return loaderDialogbox(text: "Verifying...");
                        },
                      );
                      try {
                        await authController
                            .emailLoginMethod(
                          context: context,
                          email: emailController.text,
                          password: passwordController.text,
                        )
                            .then((value) {
                          if (value != null) {
                            showToast(
                              context: context,
                              msg: "Signed In successfully",
                              seconds: 5000,
                            );
                            // Navigator.of(context).pop();
                            Get.offAll(() => const MainPage());
                          } else {
                            Navigator.of(context).pop();
                          }
                        });
                      } catch (e) {
                        Navigator.of(context).pop();
                        showToast(
                          context: context,
                          msg: e.toString(),
                          seconds: 5000,
                        );
                      }
                    } else {
                      showToast(
                        context: context,
                        msg: "Any field should not be blank!",
                        seconds: 5000,
                      );
                    }
                  },
                ),
                Dimension.heightSize(15).heightBox,
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    mediumText(
                      text: "Don't have an account?",
                      size: Dimension.widthSize(16),
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
                Dimension.heightSize(30).heightBox,
                regularText(
                  text: "Sign in using google",
                  color: AppColors.paraColor,
                ).box.makeCentered(),
                Dimension.heightSize(15).heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // google signup
                    socialIcon(ImgG).onTap(() async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return loaderDialogbox(
                            text: "Signing in with Google...",
                          );
                        },
                      );
                      try {
                        await authController.googleSignInMethod(context).then(
                          (value) {
                            showToast(
                              context: context,
                              msg: "Signed In successfully",
                              seconds: 5000,
                            );
                            Get.offAll(() => const MainPage());
                          },
                        );
                      } catch (e) {
                        auth.signOut();
                        Navigator.of(context).pop();
                        showToast(
                          context: context,
                          msg: e.toString(),
                          seconds: 5000,
                        );
                      }
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
