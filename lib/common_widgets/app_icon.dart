import 'package:food_delivery/consts/consts.dart';

Widget appIcon({icon, iconColor, backgroundColor, iconSize, onPressTask}) {
  return Center(
    child: Icon(
      icon,
      color: iconColor,
      size: iconSize,
    )
        .box
        .size(Dimension.widthSize(40), Dimension.heightSize(40))
        .roundedFull
        .color(AppColors.mainColor)
        .make()
        .onTap(onPressTask),
  );
}
