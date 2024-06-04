import 'package:food_delivery/consts/consts.dart';
import 'package:shimmer/shimmer.dart';

Widget popularFoodShimmer() {
  return Center(
    child: Shimmer.fromColors(
      baseColor: AppColors.textColor,
      highlightColor: const Color.fromARGB(255, 180, 177, 176),
      child: Column(
        children: List.generate(
          4,
          (index) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    left: Dimension.widthSize(5),
                  ),
                  width: Dimension.screenWidth / 3,
                  height: Dimension.heightSize(115),
                  decoration: BoxDecoration(
                    color: AppColors.textColor,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                Container(
                  width: Dimension.screenWidth - Dimension.screenWidth / 3 - 30,
                  height: Dimension.heightSize(80),
                  decoration: const BoxDecoration(
                    color: AppColors.textColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                ),
              ],
            ).box.height(Dimension.heightSize(120)).make();
          },
        ),
      ),
    ),
  );
}
