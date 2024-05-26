import 'package:food_delivery/consts/consts.dart';

void showToast(
    {context,
    msg,
    seconds = 3000,
    textColor = AppColors.whiteColor,
    backgroundColor = AppColors.iconColor2}) {
  VxToast.show(context,
      msg: msg,
      showTime: seconds,
      textColor: textColor,
      bgColor: backgroundColor);
}
