import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/controllers/profile_controller.dart';
import 'package:food_delivery/views/main_screen/main_page.dart';
import 'package:food_delivery/views/profile_screen/phone%20verification/phone_verification_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var profileController = Get.put(ProfileController());

  // @override
  // void initState() {
  //   super.initState();
  //   checkPhoneVerification();
  // }

  // var isPhoneVerified = false;

  // void checkPhoneVerification() async {
  //   bool isVerified = await profileController.isPhoneVerified(currentUser!.uid);
  //   if (isVerified) {
  //     setState(() {
  //       isPhoneVerified = true;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return
        // WillPopScope(
        //   onWillPop: () async {
        //     return false;
        //   },
        // child:
        Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.whiteColor,
          ),
          onPressed: () {
            // Get.delete<ProfileController>();
            Get.to(() => const MainPage());
          },
        ),
        backgroundColor: AppColors.mainColor,
        title: mediumText(
          text: "Settings",
          color: AppColors.whiteColor,
          size: Dimension.widthSize(20),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Dimension.widthSize(10),
          vertical: Dimension.heightSize(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // change theme ====================================================
            Card(
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimension.widthSize(10),
                  vertical: Dimension.heightSize(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    regularText(
                      text: "Change Theme",
                      color: AppColors.titleColor,
                      size: Dimension.widthSize(13),
                    ),
                    Dimension.heightSize(15).heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        mediumText(
                          text: "App Theme",
                          color: AppColors.mainBlackColor,
                          size: Dimension.widthSize(17),
                        ),
                        Obx(
                          () => Transform.scale(
                            scale: 0.8,
                            child: Switch(
                              value: profileController.isDarkTheme.value,
                              onChanged: (value) {
                                profileController.toggleTheme();
                              },
                              activeColor: AppColors.whiteColor,
                              activeTrackColor: AppColors.mainColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Dimension.heightSize(10).heightBox,
            // change language =================================================
            Card(
              elevation: 5,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimension.widthSize(10),
                  vertical: Dimension.heightSize(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    regularText(
                      text: "Phone Number Verification",
                      color: AppColors.titleColor,
                      size: Dimension.widthSize(13),
                    ),
                    Dimension.heightSize(15).heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        mediumText(
                          text: "Verify Phone Number",
                          color: AppColors.mainBlackColor,
                          size: Dimension.widthSize(17),
                        ),
                        elevatedButton(
                          text: profileController.isPhoneVerified.value
                              ? "Already Verified"
                              : "Verify it",
                          bgColor: profileController.isPhoneVerified.value
                              ? AppColors.titleColor
                              : AppColors.mainColor,
                          textColor: AppColors.whiteColor,
                          onPress: () async {
                            if (profileController.isPhoneVerified.value) {
                              showToast(
                                context: context,
                                msg: "Your phone number is already verified!",
                                seconds: 5000,
                              );
                            } else {
                              Get.to(() => const PhoneVerificationPage());
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      // ),
    );
  }
}
