import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';

Widget foodRow({text, iconColor, icon, iconSize=18, textSize=14}) {
  return Row(
    children: [
      Icon(
        icon,
        color: iconColor,
        size: Dimension.widthSize(iconSize),
      ),
      Dimension.widthSize(2).widthBox,
      mediumText(
          text: "$text",
          color: AppColors.signColor,
          size: Dimension.widthSize(textSize)),
    ],
  );
}