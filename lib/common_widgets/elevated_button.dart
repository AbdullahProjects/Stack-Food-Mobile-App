import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';

Widget elevatedButton({
  text = "Button",
  textColor = AppColors.whiteColor,
  bgColor = AppColors.mainColor,
  textSize,
  onPress,
}) {
  return ElevatedButton(
    onPressed: onPress,
    style: ElevatedButton.styleFrom(
      backgroundColor: bgColor,
      elevation: 5,
      padding: EdgeInsets.symmetric(
        vertical: Dimension.heightSize(10),
        horizontal: Dimension.widthSize(15),
      ),
    ),
    child: mediumText(
      text: text,
      color: textColor,
      size: textSize,
    ),
  );
}
