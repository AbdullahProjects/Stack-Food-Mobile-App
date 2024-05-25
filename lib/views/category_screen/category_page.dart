import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/controllers/food_controller.dart';
import 'package:food_delivery/views/category_screen/components/animated_text_container.dart';
import 'package:food_delivery/views/category_screen/sub_category_page.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    var foodController = Get.put(FoodController());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              // animated text container =========================================
              const AnimatedTextContainer(),
              // categories ======================================================
              Container(
                margin: EdgeInsets.only(
                  top: Dimension.heightSize(10),
                  bottom: Dimension.heightSize(20),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: Dimension.widthSize(12),
                  vertical: Dimension.heightSize(12),
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 12,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: Dimension.heightSize(15),
                    crossAxisSpacing: Dimension.widthSize(8),
                    mainAxisExtent: Dimension.heightSize(170),
                  ),
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            // image icon
                            Image.asset(
                              foodCategoryImagesList[index],
                              fit: BoxFit.cover,
                            )
                                .box
                                .size(
                                  Dimension.widthSize(70),
                                  Dimension.heightSize(70),
                                )
                                .roundedFull
                                .color(AppColors.yellowColor)
                                .padding(
                                  EdgeInsets.symmetric(
                                    horizontal: Dimension.widthSize(15),
                                    vertical: Dimension.heightSize(15),
                                  ),
                                )
                                .make(),
                            Dimension.heightSize(10).heightBox,
                            // food name
                            Text(
                              foodCategoryNamesList[index],
                              style: TextStyle(
                                fontSize: Dimension.widthSize(14),
                                fontFamily: robotoRegular,
                                color: AppColors.mainBlackColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        // food items count
                        mediumText(
                          text: "12 foods",
                          size: Dimension.widthSize(10),
                          color: AppColors.mainColor,
                        )
                      ],
                    )
                        .box
                        .color(AppColors.whiteColor)
                        .shadowSm
                        .padding(
                          EdgeInsets.symmetric(
                            horizontal: Dimension.widthSize(10),
                            vertical: Dimension.heightSize(10),
                          ),
                        )
                        .roundedSM
                        .make()
                        .onTap(() {
                      // calling getSubcategories method so that subcat list will create
                      foodController
                          .getSubCategories(foodCategoryNamesList[index]);
                      // then shifting to the subcategory details page
                      Get.to(
                        () => SubCategoryPage(
                          title: foodCategoryNamesList[index],
                        ),
                      );
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
