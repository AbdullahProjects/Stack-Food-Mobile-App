import 'package:food_delivery/consts/consts.dart';

Widget logoContainer() {
  return Image.asset(
    ImgLogoPart1,
    fit: BoxFit.cover,
  )
      .box
      .size(
        Dimension.widthSize(150),
        Dimension.heightSize(150),
      )
      .makeCentered();
}
