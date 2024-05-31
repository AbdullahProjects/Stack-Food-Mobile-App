// ignore_for_file: must_be_immutable
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/controllers/food_controller.dart';
import 'package:food_delivery/controllers/shopping_controller.dart';
import 'package:food_delivery/views/home_screen/components/handle_comments.dart';
import 'package:food_delivery/views/home_screen/components/home_page_food_row.dart';

class PopularFoodDetails extends StatelessWidget {
  String foodImage;
  String foodName;
  String rating;
  String comments;
  String desc;
  String location;
  String time;
  String foodDesc;
  String price;
  PopularFoodDetails(this.foodImage, this.foodName, this.rating, this.comments,
      this.desc, this.location, this.foodDesc, this.time, this.price,
      {super.key});

  @override
  Widget build(BuildContext context) {
    var foodController = Get.put(FoodController());
    var cartController = Get.put(ShoppingController());
    foodController.resetValues();

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        children: [
          // food image ========================================================
          Positioned(
            left: 0,
            top: 0,
            child: Image.network(
              foodImage,
              fit: BoxFit.cover,
            )
                .box
                .color(AppColors.textColor)
                .width(Dimension.screenWidth)
                .height(Dimension.screenHeight / 2.4)
                .make(),
          ),
          // icons over food image =============================================
          Positioned(
            top: Dimension.heightSize(40),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                appIcon(
                    icon: Icons.arrow_back_ios_new_outlined,
                    iconColor: AppColors.whiteColor,
                    iconSize: Dimension.widthSize(16),
                    onPressTask: () {
                      Get.back();
                    }),
                Column(
                  children: [
                    appIcon(
                        icon: Icons.shopping_cart,
                        iconColor: AppColors.whiteColor,
                        iconSize: Dimension.widthSize(20),
                        onPressTask: () {}),
                    Dimension.heightSize(10).heightBox,
                    appIcon(
                        icon: Icons.favorite,
                        iconColor: AppColors.whiteColor,
                        iconSize: Dimension.widthSize(20),
                        onPressTask: () {}),
                  ],
                ),
              ],
            )
                .box
                .width(Dimension.screenWidth)
                .padding(
                    EdgeInsets.symmetric(horizontal: Dimension.widthSize(14)))
                .make(),
          ),
          // food details ======================================================
          Positioned(
              left: 0,
              right: 0,
              top: Dimension.screenHeight / 2.4 - 20,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.only(
                  top: Dimension.heightSize(10),
                  left: Dimension.widthSize(20),
                  right: Dimension.widthSize(20),
                ),
                decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      Dimension.widthSize(20),
                    ),
                    topRight: Radius.circular(
                      Dimension.widthSize(20),
                    ),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // food name
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        mediumText(
                          text: "$foodName ",
                          isOverflow: true,
                          color: AppColors.titleColor,
                          size: Dimension.widthSize(20),
                        ),
                        AnimatedTextKit(
                          repeatForever: true,
                          pause: const Duration(milliseconds: 5000),
                          animatedTexts: [
                            TyperAnimatedText(
                              "Rs. $price",
                              textStyle: TextStyle(
                                fontFamily: robotoBlack,
                                color: AppColors.iconColor2,
                                fontSize: Dimension.widthSize(15),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    // food rating and comments count
                    Dimension.heightSize(5).heightBox,
                    Row(
                      children: [
                        VxRating(
                          maxRating: 5,
                          normalColor: AppColors.textColor,
                          selectionColor: AppColors.mainColor,
                          isSelectable: false,
                          value: double.parse(rating),
                          size: Dimension.widthSize(13),
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
                    // food detail paragraph
                    mediumText(
                        text: "Introduce",
                        color: AppColors.titleColor,
                        size: Dimension.widthSize(17)),
                    Dimension.heightSize(5).heightBox,
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: ExpandableTextWidget(text: "$foodDesc "),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
      // bottom part ===========================================================
      bottomNavigationBar: Container(
        height: Dimension.heightSize(120),
        padding: EdgeInsets.symmetric(
            horizontal: Dimension.widthSize(20),
            vertical: Dimension.heightSize(20)),
        decoration: BoxDecoration(
          color: AppColors.buttonBackgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimension.widthSize(30)),
            topRight: Radius.circular(Dimension.widthSize(30)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // plus or minus counts
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimension.widthSize(10),
                  vertical: Dimension.heightSize(15)),
              decoration: BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.circular(Dimension.widthSize(10))),
              child: Row(
                children: [
                  Icon(
                    Icons.remove,
                    color: AppColors.signColor,
                    size: Dimension.widthSize(20),
                  ).onTap(() {
                    foodController.decreaseQuantity();
                    foodController.calculateTotalPrice(int.parse(price));
                  }),
                  Dimension.widthSize(8).widthBox,
                  Obx(() => mediumText(
                      text: "${foodController.quantity.value}",
                      color: AppColors.blackColor,
                      size: Dimension.widthSize(17))),
                  Dimension.widthSize(8).widthBox,
                  Icon(
                    Icons.add,
                    color: AppColors.signColor,
                    size: Dimension.widthSize(20),
                  ).onTap(() {
                    foodController.addQuantity();
                    foodController.calculateTotalPrice(int.parse(price));
                  }),
                ],
              ),
            ),
            // add to cart
            Obx(
              () => Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: Dimension.widthSize(10),
                      vertical: Dimension.heightSize(15)),
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius:
                        BorderRadius.circular(Dimension.widthSize(10)),
                  ),
                  child: mediumText(
                    text: "${foodController.totalPrice.value} Rs. Add to Cart",
                    color: AppColors.whiteColor,
                    size: Dimension.widthSize(17),
                  )).onTap(() async {
                if (foodController.quantity.value > 0) {
                  try {
                    await cartController.addToCart(
                      uid: currentUser!.uid,
                      foodImg: foodImage,
                      foodName: foodName,
                      foodPrice: price,
                      qty: foodController.quantity.value,
                      totalPrice: foodController.totalPrice.value,
                    );
                    showToast(
                        context: context,
                        msg: "$foodName added to cart!",
                        seconds: 3000);
                  } catch (e) {
                    showToast(
                        context: context, msg: e.toString(), seconds: 5000);
                  }
                } else {
                  showToast(
                      context: context,
                      msg: "Minimum 1 quantity required to order food!",
                      seconds: 3000);
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
