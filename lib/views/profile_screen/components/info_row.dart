import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';

Widget infoRow({icon, iconColor, iconBackgroundColor, text}) {
  return Row(
    children: [
      appIcon(
        icon: icon,
        iconColor: iconColor,
        backgroundColor: iconBackgroundColor,
        iconSize: Dimension.widthSize(20),
      ),
      Dimension.widthSize(15).widthBox,
      mediumText(
        text: text,
        size: Dimension.widthSize(17),
        color: AppColors.mainBlackColor,
        isOverflow: true,
      )
    ],
  )
      .box
      .padding(EdgeInsets.symmetric(
          horizontal: Dimension.widthSize(20),
          vertical: Dimension.heightSize(10)))
      .color(AppColors.whiteColor)
      .margin(EdgeInsets.only(top: Dimension.heightSize(15)))
      .make();
}
