import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/views/shopping_screen/components/order_personal_info_card.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatelessWidget {
  final data;
  const OrderDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: mediumText(
          text: "Order Details",
          color: AppColors.mainBlackColor,
          size: Dimension.widthSize(20),
        ),
        centerTitle: true,
        // backgroundColor: AppColors.mainColor,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // personal information of user ======================================
            boldText(
              text: "Personal Info",
              size: Dimension.widthSize(15),
            ),
            Dimension.heightSize(10).heightBox,
            Card(
              elevation: 5,
              child: Column(
                children: [
                  orderPersonalInfoCard("Name :", data["username"]),
                  orderPersonalInfoCard("Phone Number :", data["number"]),
                  orderPersonalInfoCard("Address :", data["address"]),
                  orderPersonalInfoCard("City :", data["city"]),
                ],
              ),
            ),
            // order details =========================================================
            Dimension.heightSize(20).heightBox,
            boldText(
              text: "Ordered Food Items",
              size: Dimension.widthSize(15),
            ),
            Dimension.heightSize(10).heightBox,
            Card(
              elevation: 5,
              child: Column(
                children: List.generate(data["orders_list"].length, (index) {
                  return ListTile(
                    title: mediumText(
                      text: data["orders_list"][index]["food_name"],
                      size: Dimension.widthSize(16),
                      isOverflow: true,
                    ),
                    subtitle: Row(
                      children: [
                        mediumText(
                          text: "(Rs. ${data["orders_list"][index]["price"]}",
                          isOverflow: true,
                          color: AppColors.titleColor,
                        ),
                        mediumText(
                          text: " x ",
                          isOverflow: true,
                          color: AppColors.titleColor,
                        ),
                        mediumText(
                          text: "${data["orders_list"][index]["quantity"]})",
                          isOverflow: true,
                          color: AppColors.titleColor,
                        ),
                        mediumText(
                          text:
                              " Rs. ${data["orders_list"][index]["totalPrice"]}",
                          isOverflow: true,
                          color: AppColors.iconColor2,
                        ),
                      ],
                    ),
                    leading: SizedBox(
                      width: Dimension.widthSize(75),
                      height: Dimension.heightSize(60),
                      child: Image.network(
                        data["orders_list"][index]["food_img"],
                        fit: BoxFit.cover,
                      ),
                    ).box.color(AppColors.whiteColor).shadowMd.make(),
                  );
                }),
              )
                  .box
                  .padding(
                    EdgeInsets.symmetric(vertical: Dimension.heightSize(10)),
                  )
                  .make(),
            ),
          ],
        )
            .box
            .padding(
              EdgeInsets.symmetric(
                horizontal: Dimension.widthSize(10),
                vertical: Dimension.heightSize(10),
              ),
            )
            .make(),
      ),
      bottomNavigationBar: Container(
        height: Dimension.heightSize(80),
        padding: EdgeInsets.symmetric(
            horizontal: Dimension.widthSize(20),
            vertical: Dimension.heightSize(10)),
        decoration: BoxDecoration(
          color: AppColors.mainColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimension.widthSize(20)),
            topRight: Radius.circular(Dimension.widthSize(20)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimension.widthSize(10),
                vertical: Dimension.heightSize(10),
              ),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(
                  Dimension.widthSize(10),
                ),
              ),
              child: mediumText(
                text: "T.Order.Rs ${data["totalPrice"]}/_",
                size: Dimension.widthSize(17),
                color: AppColors.mainBlackColor,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimension.widthSize(10),
                vertical: Dimension.heightSize(12),
              ),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(
                  Dimension.widthSize(10),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.date_range,
                    size: Dimension.widthSize(18),
                  ),
                  regularText(
                    text: intl.DateFormat().add_yMd().format(
                          (data['order_date'] as Timestamp).toDate(),
                        ),
                    size: Dimension.widthSize(14),
                    isOverflow: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
