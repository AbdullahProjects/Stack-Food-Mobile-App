import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/controllers/food_controller.dart';
import 'package:food_delivery/views/home_screen/components/popular_food.dart';
import 'package:food_delivery/views/home_screen/popular_food_details.dart';

class SubCategoryPage extends StatelessWidget {
  final String title;
  const SubCategoryPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    var foodController = Get.put(FoodController());

    return Scaffold(
      appBar: AppBar(
        title: mediumText(
          text: title,
          color: AppColors.blackColor,
          size: Dimension.widthSize(18),
        ),
      ),
      body: Column(
        children: [
          // subcategory food horizontal scroller ==============================
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: List.generate(
                foodController.subcat.length,
                (index) {
                  return regularText(
                    text: "${foodController.subcat[index]}",
                    color: AppColors.blackColor,
                    size: Dimension.widthSize(16),
                  )
                      .box
                      .color(AppColors.yellowColor)
                      .padding(
                        EdgeInsets.symmetric(
                          horizontal: Dimension.widthSize(12),
                          vertical: Dimension.heightSize(10),
                        ),
                      )
                      .margin(
                        EdgeInsets.symmetric(
                          horizontal: Dimension.widthSize(5),
                        ),
                      )
                      .roundedSM
                      .make();
                },
              ),
            ),
          ),
          // food items ========================================================
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: Dimension.heightSize(25),
                left: Dimension.widthSize(8),
              ),
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return popularFoodPairing(
                    img: ImgFood12,
                    foodName: "Food Name",
                    foodIcon1Detail: "MD,SM",
                    foodIcon2Detail: "23km",
                    foodIcon3Detail: "34min",
                  ).onTap(
                    () {
                      Get.to(
                        () => PopularFoodDetails(
                          ImgFood13,
                          "Food Name",
                          "5",
                          "12000",
                          "desc",
                          "12km",
                          "Normal",
                          "23min",
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
