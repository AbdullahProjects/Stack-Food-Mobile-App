import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';

Widget phoneNumberNotVerified(context) {
  return Dialog(
      child: Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            Icons.close,
            size: Dimension.widthSize(19),
            color: AppColors.titleColor,
          ).onTap(() {
            Navigator.of(context).pop();
          }),
        ],
      )
          .box
          .padding(
            EdgeInsets.only(right: Dimension.widthSize(8)),
          )
          .make(),
      Dimension.heightSize(5).heightBox,
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            size: Dimension.widthSize(20),
            color: AppColors.whiteColor,
          )
              .box
              .padding(
                EdgeInsets.all(
                  Dimension.widthSize(6),
                ),
              )
              .color(Colors.red)
              .roundedFull
              .make(),
          Dimension.widthSize(10).widthBox,
          mediumText(
            text: "Issue Occured?",
            size: Dimension.widthSize(16),
          ),
        ],
      ),
      Dimension.heightSize(20).heightBox,
      regularText(
        text:
            "Your phone number is not verified. Verify phone number for moving forward.",
        size: Dimension.widthSize(14),
      ),
      Dimension.heightSize(10).heightBox,
      regularText(
        text: "Go to Profile >Settings >Verify Phone Number.",
        size: Dimension.widthSize(14),
      ),
    ],
  )
          .box
          .height(Dimension.heightSize(230))
          .padding(
            EdgeInsets.only(
              left: Dimension.widthSize(15),
              right: Dimension.widthSize(10),
              top: Dimension.heightSize(10),
              bottom: Dimension.heightSize(10),
            ),
          )
          .make());
}
