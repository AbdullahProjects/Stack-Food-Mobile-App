import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';

class AnimatedTextContainer extends StatelessWidget {
  const AnimatedTextContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // color: Colors.blue,
      width: Dimension.screenWidth,
      height: Dimension.screenHeight * 0.2,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: Dimension.heightSize(20)),
            child: mediumText(
              text: "Our Mission",
              color: AppColors.mainColor,
              size: Dimension.widthSize(16),
            ),
          ),
          DefaultTextStyle(
            style: TextStyle(
                color: AppColors.blackColor,
                fontSize: Dimension.widthSize(22),
                fontFamily: robotoBold),
            child: AnimatedTextKit(
              repeatForever: true,
              pause: const Duration(milliseconds: 1000),
              animatedTexts: [
                RotateAnimatedText("Customer Satisfaction"),
                RotateAnimatedText("Consistent Food Quality"),
                RotateAnimatedText("Community Connection"),
                RotateAnimatedText("Warm Atmosphere"),
                RotateAnimatedText("Health and Safety"),
                RotateAnimatedText("Diverse Menu Options"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
