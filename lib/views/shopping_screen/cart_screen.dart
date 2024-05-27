import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

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
                ListView.builder(
                  itemCount: 10,
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
                        text: "Food name",
                        size: Dimension.widthSize(16),
                        isOverflow: true,
                      ),
                      subtitle: const Text("Rs. 2000"),
                      leading: Image.asset(
                        ImgFood0,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.remove,
                            color: AppColors.signColor,
                            size: Dimension.widthSize(17),
                          ),
                          Dimension.widthSize(5).widthBox,
                          mediumText(
                              text: "2",
                              color: AppColors.blackColor,
                              size: Dimension.widthSize(17)),
                          Dimension.widthSize(5).widthBox,
                          Icon(
                            Icons.add,
                            color: AppColors.signColor,
                            size: Dimension.widthSize(17),
                          ),
                        ],
                      ),
                    );
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
                Container(
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
                    text: "Rs. 23000",
                    size: Dimension.widthSize(18),
                    color: AppColors.mainBlackColor,
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
                    text: "Check Out",
                    color: AppColors.whiteColor,
                    size: Dimension.widthSize(17),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
