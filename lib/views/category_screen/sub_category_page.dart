import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/controllers/food_controller.dart';
import 'package:food_delivery/views/home_screen/components/popular_food.dart';
import 'package:food_delivery/views/home_screen/popular_food_details.dart';

class SubCategoryPage extends StatefulWidget {
  final String title;
  const SubCategoryPage({super.key, required this.title});

  @override
  State<SubCategoryPage> createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  var foodController = Get.put(FoodController());
  dynamic foodState;
  // switching subcategories
  dynamic subCategory = "All";

  switchSubCategory(foodSubcategory) {
    if (foodSubcategory == "All") {
      foodState = foodController.getCategoryProducts(widget.title);
    } else {
      foodState =
          foodController.getSubCategoryProducts(widget.title, foodSubcategory);
    }
  }

  @override
  void initState() {
    super.initState();
    // set default function to foodState of All subcategories
    foodState = foodController.getCategoryProducts(widget.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: mediumText(
          text: widget.title,
          color: AppColors.blackColor,
          size: Dimension.widthSize(18),
        ),
      ),
      body: Column(
        children: [
          // subcategory food horizontal scroller ==============================
          Dimension.heightSize(10).heightBox,
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: Row(
              children: List.generate(
                foodController.subcat.length,
                (index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        subCategory = foodController.subcat[index];
                        switchSubCategory(subCategory);
                      });
                    },
                    child: regularText(
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
                        .make(),
                  );
                },
              ),
            ),
          ),
          // food items ========================================================
          StreamBuilder(
            stream: foodState == ""
                ? foodController.getCategoryProducts(widget.title)
                : foodState,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center();
              } else if (snapshot.data!.docs.isEmpty) {
                return Expanded(
                  child: Center(
                    child: mediumText(
                      text: "No Foods availabe for this category",
                      size: Dimension.widthSize(16),
                      color: AppColors.textColor,
                    ),
                  ),
                );
              } else {
                var foodData = snapshot.data!.docs;

                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: Dimension.heightSize(25),
                      left: Dimension.widthSize(8),
                    ),
                    child: ListView.builder(
                      itemCount: foodData.length,
                      itemBuilder: (context, index) {
                        return popularFoodPairing(
                          img: foodData[index]["food_img"],
                          foodName: foodData[index]["name"],
                          foodIcon1Detail: foodData[index]["size"],
                          foodIcon2Detail: foodData[index]["location"],
                          foodIcon3Detail: foodData[index]["time"],
                        ).onTap(
                          () {
                            Get.to(
                              () => PopularFoodDetails(
                                foodData[index]["food_img"],
                                foodData[index]["name"],
                                foodData[index]["rating"],
                                foodData[index]["comments"],
                                foodData[index]["size"],
                                foodData[index]["location"],
                                foodData[index]["description"],
                                foodData[index]["time"],
                                foodData[index]["price"],
                                foodData[index].id,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                );
              }
            },
          ),
          // Expanded(
          //   child: Padding(
          //     padding: EdgeInsets.only(
          //       top: Dimension.heightSize(25),
          //       left: Dimension.widthSize(8),
          //     ),
          //     child: ListView.builder(
          //       itemCount: 10,
          //       itemBuilder: (context, index) {
          //         return popularFoodPairing(
          //           img: ImgFood12,
          //           foodName: "Food Name",
          //           foodIcon1Detail: "MD,SM",
          //           foodIcon2Detail: "23km",
          //           foodIcon3Detail: "34min",
          //         ).onTap(
          //           () {
          //             Get.to(
          //               () => PopularFoodDetails(ImgFood13, "Food Name", "5",
          //                   "12000", "desc", "12km", "Normal", "23min", "1200"),
          //             );
          //           },
          //         );
          //       },
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
