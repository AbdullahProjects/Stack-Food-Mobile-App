import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';

Widget countInfo({title, count}) {
  return Column(
    children: [
      blackText(
        text: count,
        size: Dimension.widthSize(18),
        color: AppColors.blackColor,
      ),
      Dimension.heightSize(5).heightBox,
      regularText(
        text: title,
        color: AppColors.blackColor,
        size: Dimension.widthSize(16),
      ),
      Dimension.heightSize(5).heightBox,
      // mediumText(
      //   text: "check >>",
      //   size: Dimension.widthSize(14),
      //   color: AppColors.mainColor,
      // ),
    ],
  )
      .box
      .padding(
        EdgeInsets.symmetric(
          horizontal: Dimension.widthSize(15),
          vertical: Dimension.heightSize(10),
        ),
      )
      .color(AppColors.whiteColor)
      .roundedSM
      .clip(Clip.antiAlias)
      .make();
}
