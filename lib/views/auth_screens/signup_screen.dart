import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/controllers/auth_controller.dart';
import 'package:food_delivery/views/auth_screens/sign_in_or_login_screen.dart';
import 'package:food_delivery/views/main_screen/main_page.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // initialize AuthController
    var authController = Get.put(AuthController());
    // text fields controllers
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var phoneController = TextEditingController();
    var nameController = TextEditingController();

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
                // logo ========================================================
                logoContainer(),
                Dimension.heightSize(20).heightBox,
                // input fields ================================================
                // email text field
                inputField(
                  controller: emailController,
                  hintText: "Email",
                  prefixIcon: const Icon(Icons.email),
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
                Dimension.heightSize(8).heightBox,
                // phone text field
                inputField(
                  controller: phoneController,
                  hintText: "Phone",
                  prefixIcon: const Icon(Icons.phone_android_outlined),
                  keyboard: TextInputType.phone,
                ),
                Dimension.heightSize(8).heightBox,
                // name text field
                inputField(
                  controller: nameController,
                  hintText: "Name",
                  prefixIcon: const Icon(Icons.person),
                  prefixIconColor: AppColors.textColor,
                  keyboard: TextInputType.name,
                ),
                Dimension.heightSize(20).heightBox,
                // signup button ===============================================
                authButton(
                  text: "Sign Up",
                  onPress: () async {
                    if (emailController.text.trim() != "" &&
                        passwordController.text.trim() != "" &&
                        phoneController.text.trim() != "" &&
                        nameController.text.trim() != "") {
                      if (passwordController.text.trim().length >= 6) {
                        if (phoneController.text.trim().length == 11) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return loaderDialogbox(
                                text: "Creating new account...",
                              );
                            },
                          );
                          try {
                            await authController
                                .emailSignupMethod(
                              context: context,
                              email: emailController.text,
                              password: passwordController.text,
                            )
                                .then(
                              (value) {
                                return authController.storeUserData(
                                  email: emailController.text,
                                  name: nameController.text,
                                  phoneNumber: phoneController.text,
                                );
                              },
                            ).then(
                              (value) {
                                showToast(
                                  context: context,
                                  msg: "Signed Up successfully",
                                  seconds: 5000,
                                );
                                // Navigator.of(context).pop();
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
                        } else {
                          showToast(
                            context: context,
                            msg: "Plz enter valid phone number!",
                            seconds: 5000,
                          );
                        }
                      } else {
                        showToast(
                          context: context,
                          msg: "Min password length should be 6!",
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
                mediumText(
                  text: "Have an account?",
                  size: Dimension.widthSize(16),
                  color: AppColors.paraColor,
                ).onTap(() {
                  Get.to(() => const SignInOrLoginScreen());
                }),
                Dimension.heightSize(30).heightBox,
                regularText(
                  text: "Sign up using google",
                  color: AppColors.paraColor,
                ),
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
                            text: "Signing up with Google...",
                          );
                        },
                      );
                      try {
                        await authController
                            .googleSignInMethod(context)
                            .then((value) {
                          if (value != null) {
                            showToast(
                              context: context,
                              msg: "Sign Up successfully",
                              seconds: 5000,
                            );
                            Get.offAll(() => const MainPage());
                          } else {
                            Navigator.of(context).pop();
                          }
                        });
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
