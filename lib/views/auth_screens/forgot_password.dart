import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';

Widget forgotPassword({controller, onPressed}) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            appIcon(
              icon: Icons.close,
              iconColor: AppColors.blackColor,
              iconSize: Dimension.widthSize(18),
              backgroundColor: AppColors.buttonBackgroundColor,
              onPressTask: () {
                Get.back();
              },
            )
          ],
        ),
        mediumText(
          text: "Reset Password",
          size: Dimension.widthSize(16),
          color: AppColors.blackColor,
        ),
        Dimension.heightSize(20).heightBox,
        inputField(
          controller: controller,
          hintText: "Enter Email",
          keyboard: TextInputType.text,
          prefixIcon: const Icon(Icons.email_rounded),
          prefixIconColor: AppColors.mainColor,
        ),
        Dimension.heightSize(10).heightBox,
        authButton(
          text: "Send",
          textColor: AppColors.whiteColor,
          backgroundColor: AppColors.mainColor,
          onPress: onPressed,
        )
      ],
    )
        .box
        .height(Dimension.heightSize(240))
        // .width(Dimension.screenWidth - 20)
        .padding(
          EdgeInsets.symmetric(
            vertical: Dimension.heightSize(10),
            horizontal: Dimension.widthSize(15),
          ),
        )
        .color(AppColors.whiteColor)
        .make(),
  );
}
