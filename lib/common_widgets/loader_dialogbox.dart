import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';

Widget loaderDialogbox({
  text,
  textColor = AppColors.mainBlackColor,
  loaderColor = AppColors.mainColor,
  bgColor = AppColors.whiteColor,
}) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        mediumText(
          text: text,
          color: textColor,
          size: Dimension.widthSize(16),
        ),
        Dimension.heightSize(20).heightBox,
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(loaderColor),
        ),
      ],
    )
        .box
        .height(Dimension.heightSize(130))
        .padding(const EdgeInsets.all(12))
        .color(bgColor)
        .make(),
  );
}
