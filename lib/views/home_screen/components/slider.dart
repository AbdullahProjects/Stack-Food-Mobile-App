import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/views/home_screen/components/handle_comments.dart';
import 'package:food_delivery/views/home_screen/components/home_page_food_row.dart';

Widget customSlider(
    // ignore: non_constant_identifier_names
    {screen_width,
    foodImage,
    foodName,
    ratings,
    commentsCount,
    desc,
    location,
    time}) {
  return SingleChildScrollView(
    scrollDirection: Axis.vertical,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            // Food Image
            Image.network(
              foodImage,
              fit: BoxFit.cover,
            )
                .box
                .width(screen_width / 1.3)
                .height(Dimension.swiperImageHeight) //190
                .roundedLg
                .shadowSm
                .clip(Clip.antiAlias)
                .make(),
            // Food Information; name, rating, etc
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // food name
                    mediumText(
                        text: "$foodName",
                        isOverflow: true,
                        color: AppColors.titleColor,
                        size: Dimension.widthSize(20)), // 20
                    // food rating and comments count
                    Dimension.heightSize(10).widthBox,
                    Row(
                      children: [
                        VxRating(
                          maxRating: 5,
                          normalColor: AppColors.textColor,
                          selectionColor: AppColors.mainColor,
                          isSelectable: false,
                          value: double.parse(ratings),
                          size: Dimension.widthSize(13), //13
                          onRatingUpdate: (value) {},
                        ),
                        Dimension.widthSize(5).widthBox,
                        blackText(
                            text: "$ratings",
                            color: AppColors.mainColor,
                            size: Dimension.widthSize(14)),
                        Dimension.widthSize(10).widthBox,
                        Row(
                          children: [
                            Icon(
                              Icons.comment,
                              color: AppColors.textColor,
                              size: Dimension.widthSize(18),
                            ),
                            Dimension.widthSize(5).widthBox,
                            mediumText(
                              text:
                                  roundedComment(commentsCount: commentsCount),
                              color: AppColors.signColor,
                              size: Dimension.widthSize(14),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Dimension.heightSize(10).heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        foodRow(
                            icon: Icons.circle,
                            iconColor: AppColors.iconColor1,
                            text: "$desc"),
                        foodRow(
                            icon: Icons.location_on,
                            iconColor: AppColors.mainColor,
                            text: "$location"),
                        foodRow(
                            icon: Icons.access_time,
                            iconColor: AppColors.iconColor2,
                            text: "$time")
                      ],
                    )
                  ],
                )
                    .box
                    .width(screen_width / 1.5)
                    .height(Dimension.swiperFoodInfoHeight) //100
                    .color(AppColors.whiteColor)
                    .padding(EdgeInsets.symmetric(
                        horizontal: Dimension.widthSize(10),
                        vertical: Dimension.heightSize(10)))
                    .roundedSM
                    .shadowMd
                    .make(),
              ),
            )
          ],
        ).box.height(Dimension.swiperStackHeight).make(), //220
      ],
    ),
  );
}
