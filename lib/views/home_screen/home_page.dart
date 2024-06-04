import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/controllers/shopping_controller.dart';
import 'package:food_delivery/services/firestore_services.dart';
import 'package:food_delivery/views/home_screen/components/popular_food.dart';
import 'package:food_delivery/views/home_screen/components/recommend_food.dart';
import 'package:food_delivery/views/home_screen/components/slider.dart';
import 'package:food_delivery/views/home_screen/popular_food_details.dart';
import 'package:food_delivery/views/home_screen/shimmer%20effect/featured_food_shimmer.dart';
import 'package:food_delivery/views/home_screen/shimmer%20effect/popular_food_shimmer.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentDot = 0;
  var cartsController = Get.put(ShoppingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            // main Body here
            child: Column(
              children: [
                Dimension.heightSize(10).heightBox,
                // header ======================================================
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // text
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          ImgLogoPart1,
                          width: Dimension.widthSize(60),
                          height: Dimension.heightSize(50),
                          fit: BoxFit.cover,
                        ).box.color(Colors.black).make(),
                        Image.asset(
                          ImgLogoName,
                          width: Dimension.widthSize(110),
                          height: Dimension.heightSize(50),
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                    Icon(
                      Icons.search,
                      color: AppColors.whiteColor,
                      size: Dimension.widthSize(28),
                    )
                        .box
                        .size(Dimension.widthSize(40), Dimension.heightSize(40))
                        .roundedSM
                        .color(AppColors.mainColor)
                        .makeCentered()
                  ],
                )
                    .box
                    .padding(
                      EdgeInsets.only(
                        right: Dimension.widthSize(10),
                        left: Dimension.widthSize(3),
                      ),
                    )
                    .make(),
                Dimension.heightSize(10).heightBox,
                // slider ======================================================
                // featured foods
                FutureBuilder(
                    future: FirestoreServices.getFeaturedProducts(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        // shimmer effect until data not loaded properly
                        return featuredFoodShimmer();
                      } else {
                        // data
                        var featuredData = snapshot.data!.docs;

                        return Column(
                          children: [
                            VxSwiper.builder(
                                height: Dimension.swiperHeight,
                                enlargeCenterPage: true,
                                scrollPhysics: const BouncingScrollPhysics(),
                                enableInfiniteScroll: false,
                                itemCount: featuredData.length,
                                onPageChanged: (index) {
                                  setState(() {
                                    currentDot = index;
                                  });
                                },
                                itemBuilder: (context, index) {
                                  return customSlider(
                                    screen_width: context.screenWidth,
                                    foodImage: featuredData[index]["food_img"],
                                    foodName: featuredData[index]["name"],
                                    ratings: featuredData[index]["rating"],
                                    commentsCount: featuredData[index]
                                        ["comments"],
                                    desc: featuredData[index]["size"],
                                    location: featuredData[index]["location"],
                                    time: featuredData[index]["time"],
                                  )
                                      .box
                                      .margin(EdgeInsets.symmetric(
                                          horizontal: Dimension.widthSize(6),
                                          vertical: 2))
                                      .make()
                                      .onTap(() {
                                    // check food is in favourite or not
                                    cartsController
                                        .checkIfFav(featuredData[index]);

                                    Get.to(
                                      () => RecommendFoodDetails(
                                        featuredData[index]["food_img"],
                                        featuredData[index]["name"],
                                        featuredData[index]["rating"],
                                        featuredData[index]["comments"],
                                        featuredData[index]["size"],
                                        featuredData[index]["description"],
                                        featuredData[index]["location"],
                                        featuredData[index]["time"],
                                        featuredData[index]["price"],
                                        featuredData[index].id,
                                      ),
                                    );
                                  });
                                }),
                            DotsIndicator(
                              dotsCount: featuredData.length,
                              position: currentDot,
                              decorator: DotsDecorator(
                                activeColor: AppColors.mainColor,
                                color: AppColors.textColor,
                                size: Size.square(
                                    Dimension.widthSize(8).toDouble()),
                                activeSize: Size(Dimension.widthSize(16),
                                    Dimension.widthSize(8)),
                                activeShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        Dimension.widthSize(5).toDouble())),
                              ),
                            ),
                          ],
                        );
                      }
                    }),

                Dimension.heightSize(15).heightBox,
                // popular food pairing ========================================
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    boldText(
                        text: "Popular",
                        color: AppColors.mainBlackColor,
                        size: Dimension.widthSize(20)),
                    Dimension.widthSize(5).widthBox,
                    mediumText(
                            text: ".",
                            color: AppColors.textColor,
                            size: Dimension.widthSize(20))
                        .box
                        .margin(
                            EdgeInsets.only(bottom: Dimension.heightSize(3)))
                        .make(),
                    Dimension.widthSize(5).widthBox,
                    mediumText(
                            text: "Food pairing",
                            color: AppColors.textColor,
                            size: Dimension.widthSize(14))
                        .box
                        .margin(
                            EdgeInsets.only(bottom: Dimension.heightSize(3)))
                        .make(),
                  ],
                )
                    .box
                    .padding(EdgeInsets.symmetric(
                        horizontal: Dimension.widthSize(5)))
                    .make(),
                Dimension.heightSize(15).heightBox,
                FutureBuilder(
                  future: FirestoreServices.getPopularProducts(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      // shimmer effect until data not loaded
                      return popularFoodShimmer();
                    } else {
                      // data
                      var popularFoodData = snapshot.data!.docs;

                      return Column(
                        children: List.generate(
                          popularFoodData.length,
                          (index) {
                            return popularFoodPairing(
                                    img: popularFoodData[index]["food_img"],
                                    foodName: popularFoodData[index]["name"],
                                    foodIcon1Detail: popularFoodData[index]
                                        ["size"],
                                    foodIcon2Detail: popularFoodData[index]
                                        ["location"],
                                    foodIcon3Detail: popularFoodData[index]
                                        ["time"])
                                .onTap(
                              () {
                                // check food in in favourite or not before going to food details page
                                cartsController
                                    .checkIfFav(popularFoodData[index]);

                                Get.to(
                                  () => PopularFoodDetails(
                                    popularFoodData[index]["food_img"],
                                    popularFoodData[index]["name"],
                                    popularFoodData[index]["rating"],
                                    popularFoodData[index]["comments"],
                                    popularFoodData[index]["size"],
                                    popularFoodData[index]["location"],
                                    popularFoodData[index]["description"],
                                    popularFoodData[index]["time"],
                                    popularFoodData[index]["price"],
                                    popularFoodData[index].id,
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
                Dimension.heightSize(20).heightBox
              ],
            ),
          ),
        ),
      ),
    );
  }
}
