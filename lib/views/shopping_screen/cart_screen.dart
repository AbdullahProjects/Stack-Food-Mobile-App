// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/controllers/shopping_controller.dart';
import 'package:food_delivery/views/shopping_screen/enter_info_for_order.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  var cartController = Get.put(ShoppingController());

  @override
  void initState() {
    super.initState();
    cartController.getTotalCartItemsPrice();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: Dimension.heightSize(10),
            left: Dimension.widthSize(3),
            right: Dimension.widthSize(3),
            bottom: Dimension.heightSize(100),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                StreamBuilder(
                  stream: cartController.getCart(currentUser!.uid),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const Center();
                    } else if (snapshot.data!.docs.isEmpty) {
                      return Center(
                        child: mediumText(
                          text: "Cart is Empty!",
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
                      var cartData = snapshot.data!.docs;

                      return ListView.builder(
                        itemCount: cartData.length,
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
                              text: "${cartData[index]["food_name"]}",
                              size: Dimension.widthSize(16),
                              isOverflow: true,
                            ),
                            subtitle: Row(
                              children: [
                                mediumText(
                                  text:
                                      "( Rs. ${cartData[index]["food_price"]}",
                                  isOverflow: true,
                                  color: AppColors.titleColor,
                                ),
                                mediumText(
                                  text: " x ",
                                  isOverflow: true,
                                  color: AppColors.titleColor,
                                ),
                                mediumText(
                                  text: "${cartData[index]["quantity"]}) ",
                                  isOverflow: true,
                                  color: AppColors.titleColor,
                                ),
                                mediumText(
                                  text: " Rs. ${cartData[index]["totalPrice"]}",
                                  isOverflow: true,
                                  color: AppColors.iconColor2,
                                ),
                              ],
                            ),
                            leading: SizedBox(
                              width: Dimension.widthSize(75),
                              height: Dimension.heightSize(60),
                              child: Image.network(
                                "${cartData[index]["food_img"]}",
                                fit: BoxFit.cover,
                              ),
                            ).box.color(AppColors.whiteColor).shadowMd.make(),
                            trailing: Icon(
                              Icons.delete,
                              color: AppColors.signColor,
                              size: Dimension.widthSize(18),
                            ).onTap(
                              () async {
                                try {
                                  await cartController
                                      .deleteCart(cartData[index].id);
                                  setState(
                                    () {
                                      cartController.getTotalCartItemsPrice();
                                    },
                                  );
                                  showToast(
                                    context: context,
                                    msg:
                                        "${cartData[index]["food_name"]} deleted from cart!",
                                  );
                                  // await cartController.getTotalCartItemsPrice();
                                } catch (e) {
                                  showToast(
                                    context: context,
                                    msg: e.toString(),
                                  );
                                }
                              },
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: Dimension.heightSize(80),
            padding: EdgeInsets.symmetric(
              horizontal: Dimension.widthSize(20),
              vertical: Dimension.heightSize(10),
            ),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 235, 233, 231),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(
                  Dimension.widthSize(30),
                ),
                topRight: Radius.circular(
                  Dimension.widthSize(30),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // plus or minus counts ============================================
                Obx(
                  () => Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimension.widthSize(14),
                      vertical: Dimension.heightSize(10),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(
                        Dimension.widthSize(10),
                      ),
                    ),
                    child: mediumText(
                      text: "T.Rs. ${cartController.totalCartPrice.value}/_",
                      size: Dimension.widthSize(17),
                      color: AppColors.mainBlackColor,
                    ),
                  ),
                ),
                // add to cart =====================================================
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimension.widthSize(14),
                    vertical: Dimension.heightSize(10),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.mainColor,
                    borderRadius: BorderRadius.circular(
                      Dimension.widthSize(10),
                    ),
                  ),
                  child: mediumText(
                    text: "Order Now",
                    color: AppColors.whiteColor,
                    size: Dimension.widthSize(17),
                  ).onTap((){
                    Get.to(() => const EnterInfoForOrder());
                  }),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
