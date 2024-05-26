import 'package:food_delivery/consts/consts.dart';

Widget socialIcon(img) {
  return Image.asset(
    img,
    fit: BoxFit.cover,
  )
      .box
      .size(Dimension.widthSize(50), Dimension.heightSize(40))
      .roundedFull
      .clip(Clip.antiAlias)
      .make();
}
