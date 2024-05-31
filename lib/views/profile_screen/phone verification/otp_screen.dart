import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/controllers/profile_controller.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // otp text field controller
    var otpController = TextEditingController();
    // initializing profile controller
    var profileController = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: AppColors.whiteColor,
          ),
          onPressed: () {
            // Get.delete<ProfileController>();
            Get.back();
          },
        ),
        backgroundColor: AppColors.mainColor,
        title: mediumText(
          text: "Code Verification",
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
            text: "OTP Code",
            size: Dimension.widthSize(18),
            color: AppColors.mainBlackColor,
          ),
          Dimension.heightSize(20).heightBox,
          inputField(
            controller: otpController,
            hintText: "Enter OTP Code",
            keyboard: TextInputType.number,
            prefixIcon: const Icon(
              Icons.phone_forwarded_outlined,
            ),
          ),
          Dimension.heightSize(40).heightBox,
          Obx(
            () => profileController.isLoading.value
                ? const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(AppColors.mainColor),
                    ),
                  )
                : elevatedButton(
                    text: "Verify OTP Code",
                    textSize: Dimension.widthSize(16),
                    onPress: () async {
                      // showDialog(
                      //   context: context,
                      //   barrierDismissible: false,
                      //   builder: (BuildContext context) {
                      //     return loaderDialogbox(
                      //       text: "Verifying OTP Code...",
                      //     );
                      //   },
                      // );
                      try {
                        profileController.isLoading(true);
                        await profileController
                            .verifyOtpCode(otpController.text);
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
