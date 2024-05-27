import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';

Widget authButton(
    {text,
    textColor = AppColors.whiteColor,
    backgroundColor = AppColors.mainColor,
    onPress}) {
  return ElevatedButton(
    onPressed: onPress,
    style: ElevatedButton.styleFrom(
      backgroundColor: backgroundColor,
      padding: EdgeInsets.symmetric(
        vertical: Dimension.heightSize(10),
        horizontal: Dimension.widthSize(20),
      ),
    ),
    child: mediumText(
      text: text,
      color: textColor,
      size: Dimension.widthSize(20),
    ),
  ).box.makeCentered();
}
