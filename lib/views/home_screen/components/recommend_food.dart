import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/views/home_screen/components/handle_comments.dart';
import 'package:food_delivery/views/home_screen/components/home_page_food_row.dart';

class RecommendFoodDetails extends StatelessWidget {
  String foodImage;
  String foodName;
  String rating;
  String comments;
  String desc;
  String location;
  String time;
  String foodDesc;
  RecommendFoodDetails(this.foodImage, this.foodName, this.rating,
      this.comments, this.desc, this.foodDesc, this.location, this.time,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: Dimension.screenHeight / 2.4,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                appIcon(
                    icon: Icons.close,
                    iconColor: AppColors.whiteColor,
                    iconSize: Dimension.widthSize(18),
                    onPressTask: () {
                      Get.back();
                    }),
                appIcon(
                    icon: Icons.shopping_cart,
                    iconColor: AppColors.whiteColor,
                    iconSize: Dimension.widthSize(20),
                    onPressTask: () {}),
              ],
            )
                .box
                .width(Dimension.screenWidth)
                .padding(
                    EdgeInsets.symmetric(horizontal: Dimension.widthSize(14)))
                .make(),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                foodImage,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(Dimension.heightSize(50)),
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(
                    top: Dimension.heightSize(10),
                    bottom: Dimension.heightSize(10)),
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimension.widthSize(20)),
                      topRight: Radius.circular(Dimension.widthSize(20)),
                    )),
                child: Center(
                  child: mediumText(
                      text: "$foodName ",
                      size: Dimension.widthSize(20),
                      isOverflow: true),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: Dimension.widthSize(20),
                    right: Dimension.widthSize(20)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        VxRating(
                          maxRating: 5,
                          normalColor: AppColors.textColor,
                          selectionColor: AppColors.mainColor,
                          isSelectable: false,
                          // value: double.parse(rating),
                          value: 3.0,
                          size: Dimension.widthSize(13), //13
                          onRatingUpdate: (value) {},
                        ),
                        Dimension.widthSize(5).widthBox,
                        blackText(
                            text: "$rating ",
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
                              text: roundedComment(commentsCount: comments),
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
                            text: "$desc "),
                        foodRow(
                            icon: Icons.location_on,
                            iconColor: AppColors.mainColor,
                            text: "$location "),
                        foodRow(
                            icon: Icons.access_time,
                            iconColor: AppColors.iconColor2,
                            text: "$time ")
                      ],
                    ),
                    Dimension.heightSize(10).heightBox,
                    ExpandableTextWidget(text: "$foodDesc "),
                  ],
                ),
              )
            ],
          ))
        ],
      ),
      bottomNavigationBar: Container(
        height: Dimension.heightSize(130),
        padding: EdgeInsets.symmetric(
            horizontal: Dimension.widthSize(20),
            vertical: Dimension.heightSize(10)),
        decoration: BoxDecoration(
          color: AppColors.buttonBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimension.widthSize(30)),
            topRight: Radius.circular(Dimension.widthSize(30)),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                appIcon(
                    icon: Icons.remove,
                    backgroundColor: AppColors.mainColor,
                    iconColor: AppColors.whiteColor,
                    iconSize: Dimension.widthSize(16)),
                Dimension.widthSize(10).widthBox,
                mediumText(
                    text: "Rs. 120 x 0",
                    color: AppColors.blackColor,
                    size: Dimension.widthSize(17)),
                Dimension.widthSize(10).widthBox,
                appIcon(
                    icon: Icons.add,
                    backgroundColor: AppColors.mainColor,
                    iconColor: AppColors.whiteColor,
                    iconSize: Dimension.widthSize(16))
              ],
            ).box.make(),
            Dimension.heightSize(10).heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // plus or minus counts ============================================
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimension.widthSize(15),
                      vertical: Dimension.heightSize(15)),
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius:
                          BorderRadius.circular(Dimension.widthSize(15))),
                  child: Row(
                    children: [
                      Icon(
                        Icons.favorite,
                        color: AppColors.mainColor,
                        size: Dimension.widthSize(20),
                      ),
                    ],
                  ),
                ),
                // add to cart =====================================================
                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimension.widthSize(15),
                      vertical: Dimension.heightSize(15)),
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius:
                        BorderRadius.circular(Dimension.widthSize(15)),
                  ),
                  child: mediumText(
                      text: "340 Rs. Add to Cart",
                      color: AppColors.whiteColor,
                      size: Dimension.widthSize(17)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
