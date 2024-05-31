import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/controllers/profile_controller.dart';
import 'package:food_delivery/views/profile_screen/phone%20verification/otp_screen.dart';

class PhoneVerificationPage extends StatelessWidget {
  const PhoneVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // phone number text field controller
    var phoneController = TextEditingController();
    // initializing profile controller
    var profileController = Get.put(ProfileController());

    phoneController.text = profileController.phoneNumber.value;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.whiteColor,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: AppColors.mainColor,
        title: mediumText(
          text: "Phone Verification",
          color: AppColors.whiteColor,
          size: Dimension.widthSize(20),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Dimension.heightSize(50).heightBox,
          mediumText(
            text: "Verify Phone Number",
            size: Dimension.widthSize(18),
            color: AppColors.mainBlackColor,
          ),
          Dimension.heightSize(20).heightBox,
          inputField(
            controller: phoneController,
            hintText: "Enter Phone Number",
            keyboard: TextInputType.number,
            prefixIcon: const Icon(
              Icons.phone_forwarded_outlined,
            ),
          ),
          Dimension.heightSize(10).heightBox,
          Padding(
            padding: EdgeInsets.only(right: Dimension.widthSize(5)),
            child: Align(
              alignment: Alignment.centerRight,
              child: regularText(
                text: "Go to OTP screen",
                size: Dimension.widthSize(14),
                color: AppColors.titleColor,
              ).onTap(() {
                Get.to(() => const OtpScreen());
              }),
            ),
          ),
          Dimension.heightSize(20).heightBox,
          Obx(
            () => profileController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(AppColors.mainColor),
                    ),
                  )
                : elevatedButton(
                    text: "Verify Phone Number",
                    textSize: Dimension.widthSize(16),
                    onPress: () async {
                      // showDialog(
                      //   context: context,
                      //   barrierDismissible: false,
                      //   builder: (BuildContext context) {
                      //     return loaderDialogbox(
                      //       text: "Loading...",
                      //     );
                      //   },
                      // );
                      try {
                        profileController.isLoading(true);
                        await profileController
                            .verifyPhoneNumber(phoneController.text);
                        profileController.isLoading(false);
                      } catch (e) {
                        profileController.isLoading(false);
                        showToast(msg: e.toString(), seconds: 5000);
                      }
                      // Navigator.of(context).pop();
                    },
                  ),
          ),
        ],
      )
          .box
          .width(Dimension.screenWidth)
          .padding(EdgeInsets.symmetric(horizontal: Dimension.widthSize(15)))
          .make(),
    );
  }
}
