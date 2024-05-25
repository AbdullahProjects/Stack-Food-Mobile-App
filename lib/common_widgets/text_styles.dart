import 'package:food_delivery/consts/consts.dart';

Widget blackText(
    {text = "Text",
    color = Colors.black,
    size = 14.0,
    bool isOverflow = false,
    maxLines = 1}) {
  if (isOverflow == true) {
    return "$text"
        .text
        .fontFamily(robotoBlack)
        .color(color)
        .size(size)
        .overflow(TextOverflow.ellipsis)
        .maxLines(maxLines)
        .make();
  } else {
    return "$text".text.fontFamily(robotoBlack).color(color).size(size).make();
  }
}

Widget boldText(
    {text = "Text",
    color = Colors.black,
    size = 14.0,
    bool isOverflow = false,
    maxLines = 1}) {
  if (isOverflow == true) {
    return "$text"
        .text
        .fontFamily(robotoBold)
        .color(color)
        .size(size)
        .overflow(TextOverflow.ellipsis)
        .maxLines(maxLines)
        .make();
  } else {
    return "$text".text.fontFamily(robotoBold).color(color).size(size).make();
  }
}

Widget mediumText(
    {text = "Text",
    color = Colors.black,
    size = 14.0,
    bool isOverflow = false,
    maxLines = 1}) {
  if (isOverflow == true) {
    return "$text"
        .text
        .fontFamily(robotoMedium)
        .color(color)
        .size(size)
        .overflow(TextOverflow.ellipsis)
        .maxLines(maxLines)
        .make();
  } else {
    return "$text".text.fontFamily(robotoMedium).color(color).size(size).make();
  }
}

Widget regularText(
    {text = "Text",
    color = Colors.black,
    size = 14.0,
    bool isOverflow = false,
    maxLines = 1}) {
  if (isOverflow == true) {
    return "$text"
        .text
        .fontFamily(robotoRegular)
        .color(color)
        .size(size)
        .overflow(TextOverflow.ellipsis)
        .maxLines(maxLines)
        .make();
  } else {
    return "$text"
        .text
        .fontFamily(robotoRegular)
        .color(color)
        .size(size)
        .make();
  }
}
