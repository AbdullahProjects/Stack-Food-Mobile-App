import 'package:food_delivery/consts/consts.dart';

class Dimension {
  // screen widths and height
  static double screenHeight = Get.context!.height;
  static double screenWidth = Get.context!.width;

  // constants==================================================================
  // for width
  static double widthSize(int num) {
    return screenWidth / (screenWidth / num);
  }
  // for height
  static double heightSize(int num) {
    return screenHeight / (screenHeight / num);
  }

  // home_page.dart ============================================================
  // slider
  static double swiperHeight = screenHeight / 2.46; 
  static double swiperImageHeight = screenHeight / 3.37; 
  static double swiperFoodInfoHeight = screenHeight / 6.4; 
  static double swiperStackHeight = screenHeight / 2.91;
}
