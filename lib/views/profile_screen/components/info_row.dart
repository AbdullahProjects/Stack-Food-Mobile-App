import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';

Widget infoRow({
  icon,
  iconColor,
  iconBackgroundColor,
  text,
  onPress,
  textColor = AppColors.mainBlackColor,
  isPhone = false,
  isPhoneVerified = false,
}) {
  return InkWell(
    onTap: onPress,
    child: Row(
      children: [
        appIcon(
          icon: icon,
          iconColor: iconColor,
          backgroundColor: iconBackgroundColor,
          iconSize: Dimension.widthSize(20),
        ),
        Dimension.widthSize(15).widthBox,
        Flexible(
          child: mediumText(
            text: text,
            size: Dimension.widthSize(17),
            color: textColor,
            isOverflow: true,
          ),
        ),
        if (isPhone) Spacer(),
        if (isPhone)
          isPhoneVerified
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        Icon(
                          Icons.check,
                          color: AppColors.whiteColor,
                          size: Dimension.widthSize(15),
                        )
                            .box
                            .color(AppColors.paraColor)
                            .padding(EdgeInsets.symmetric(
                                horizontal: Dimension.widthSize(7),
                                vertical: Dimension.heightSize(5)))
                            .roundedFull
                            .make(),
                        Dimension.heightSize(3).heightBox,
                        regularText(
                          text: "Verified",
                          color: Colors.green,
                          size: Dimension.widthSize(12),
                        )
                      ],
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      children: [
                        Icon(
                          Icons.close,
                          color: AppColors.whiteColor,
                          size: Dimension.widthSize(15),
                        )
                            .box
                            .color(AppColors.paraColor)
                            .padding(EdgeInsets.symmetric(
                                horizontal: Dimension.widthSize(7),
                                vertical: Dimension.heightSize(5)))
                            .roundedFull
                            .make(),
                        Dimension.heightSize(3).heightBox,
                        regularText(
                          text: "Not verified",
                          color: Colors.red,
                          size: Dimension.widthSize(12),
                        )
                      ],
                    ),
                  ],
                ),
      ],
    )
        .box
        .width(Dimension.screenWidth)
        .padding(EdgeInsets.symmetric(
            horizontal: Dimension.widthSize(20),
            vertical: Dimension.heightSize(10)))
        .color(AppColors.whiteColor)
        .margin(EdgeInsets.only(top: Dimension.heightSize(15)))
        .make(),
  );
}
