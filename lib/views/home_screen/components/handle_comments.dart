String roundedComment({commentsCount}) {
  var commentInt = int.parse(commentsCount);
  String commentsShow = '';
  if (commentInt >= 10000000) {
    commentsShow = "Crossing 1 Crore";
  } else if (commentInt >= 1000000) {
    commentsShow =
        "${commentInt.toString().substring(0, 1)}${commentInt.toString().substring(1, 2)}Lac+";
  } else if (commentInt >= 100000) {
    commentsShow =
        "${commentInt.toString().substring(0, 1)}.${commentInt.toString().substring(1, 2)}Lac+";
  } else if (commentInt >= 10000) {
    commentsShow =
        "${commentInt.toString().substring(0, 1)}${commentInt.toString().substring(1, 2)}K+";
  } else if (commentInt >= 1000) {
    commentsShow = "${commentInt.toString().substring(0, 1)}K+";
  } else {
    commentsShow = "$commentInt ";
  }

  return "$commentsShow ";
}
