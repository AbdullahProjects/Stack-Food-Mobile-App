import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/controllers/shopping_controller.dart';
import 'package:food_delivery/views/shopping_screen/order_details.dart';
import 'package:intl/intl.dart' as intl;

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var ordersController = Get.put(ShoppingController());

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      child: StreamBuilder(
        stream: ordersController.getOrders(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center();
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: mediumText(
                text: "No order!",
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
            var orderData = snapshot.data!.docs;

            return Column(
              children: List.generate(
                orderData.length,
                (index) {
                  return Card(
                    child: ListTile(
                      leading: Container(
                        width: Dimension.widthSize(15),
                        height: Dimension.heightSize(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.5),
                          color: AppColors.iconColor2,
                        ),
                      ),
                      title: mediumText(
                        text: "Order Code: ${orderData[index]["order_number"]}",
                        size: Dimension.widthSize(16),
                        isOverflow: true,
                      ),
                      subtitle: Row(
                        children: [
                          Icon(
                            Icons.date_range,
                            size: Dimension.widthSize(18),
                          ),
                          regularText(
                            text: intl.DateFormat().add_yMd().format(
                                  (orderData[index]['order_date'] as Timestamp)
                                      .toDate(),
                                ),
                            size: Dimension.widthSize(14),
                            isOverflow: true,
                          ),
                        ],
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: Dimension.widthSize(18),
                        color: AppColors.iconColor2,
                      ),
                    ),
                  ).onTap(
                    () {
                      Get.to(
                        () => OrderDetails(
                          data: orderData[index],
                        ),
                      );
                    },
                  );
                },
              ),
            )
                .box
                .padding(
                  EdgeInsets.symmetric(
                    horizontal: Dimension.widthSize(5),
                    vertical: Dimension.heightSize(10),
                  ),
                )
                .make();
          }
        },
      ),
    );
  }
}
