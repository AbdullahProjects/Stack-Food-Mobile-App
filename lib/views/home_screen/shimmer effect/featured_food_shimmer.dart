import 'package:food_delivery/consts/consts.dart';
import 'package:shimmer/shimmer.dart';

Widget featuredFoodShimmer() {
  return Center(
    child: Shimmer.fromColors(
      baseColor: AppColors.textColor,
      highlightColor: const Color.fromARGB(255, 180, 177, 176),
      child: Container(
        width: Dimension.screenWidth / 1.2,
        height: Dimension.screenHeight * 0.3,
        decoration: const BoxDecoration(
          color: AppColors.textColor,
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
      ),
    ),
  );
}
