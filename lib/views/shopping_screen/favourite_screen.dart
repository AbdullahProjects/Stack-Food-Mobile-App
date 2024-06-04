import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/controllers/shopping_controller.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var favouriteController = Get.put(ShoppingController());

    return Padding(
      padding: EdgeInsets.only(
        top: Dimension.heightSize(10),
        left: Dimension.widthSize(1),
        right: Dimension.widthSize(1),
        bottom: Dimension.heightSize(5),
      ),
      child: Column(
        children: [
          StreamBuilder(
            stream: favouriteController.getFavouritesFoods(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center();
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: mediumText(
                    text: "Favourite is Empty!",
                    size: Dimension.widthSize(16),
                    color: AppColors.textColor,
                  )
                      .box
                      .margin(
                        EdgeInsets.only(top: Dimension.heightSize(50)),
                      )
                      .make(),
                );
              } else {
                var favouriteData = snapshot.data!.docs;

                return Expanded(
                  child: ListView.builder(
                    itemCount: favouriteData.length,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        subtitleTextStyle: TextStyle(
                          color: AppColors.iconColor2,
                          fontSize: Dimension.widthSize(16),
                          fontWeight: FontWeight.w700,
                        ),
                        title: mediumText(
                          text: favouriteData[index]["name"],
                          size: Dimension.widthSize(16),
                          isOverflow: true,
                        ),
                        subtitle: mediumText(
                          text: "Rs. ${favouriteData[index]["price"]}",
                          size: Dimension.widthSize(16),
                          color: AppColors.iconColor2,
                        ),
                        leading: SizedBox(
                          width: Dimension.widthSize(75),
                          height: Dimension.heightSize(60),
                          child: Image.network(
                            "${favouriteData[index]["food_img"]}",
                            fit: BoxFit.cover,
                          ),
                        ).box.color(AppColors.whiteColor).shadowMd.make(),
                        trailing: Icon(
                          Icons.favorite,
                          size: Dimension.widthSize(20),
                          color: AppColors.mainColor,
                        )
                            .box
                            .color(AppColors.whiteColor)
                            .size(Dimension.widthSize(35),
                                Dimension.heightSize(35))
                            .roundedFull
                            .make()
                            .onTap(() async {
                          favouriteController.removeToFavourite(
                              favouriteData[index].id, context);
                        }),
                      );
                    },
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
