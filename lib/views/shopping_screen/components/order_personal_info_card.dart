import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';

Widget orderPersonalInfoCard(leading, trailing) {
  return Row(
    children: [
      mediumText(
        text: leading,
        size: Dimension.widthSize(16),
        color: AppColors.mainBlackColor,
      ),
      Dimension.widthSize(10).widthBox,
      regularText(
        text: trailing,
        color: AppColors.titleColor,
        isOverflow: true,
      )
    ],
  )
      .box
      .padding(
        EdgeInsets.symmetric(
          horizontal: Dimension.widthSize(10),
          vertical: Dimension.heightSize(12),
        ),
      )
      .make();
}
