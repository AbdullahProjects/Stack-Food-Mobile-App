import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: Dimension.heightSize(10),
        left: Dimension.widthSize(5),
        right: Dimension.widthSize(5),
        bottom: Dimension.heightSize(5),
      ),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
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
                  trailing: Icon(
                    Icons.favorite,
                    size: Dimension.widthSize(20),
                    color: AppColors.mainColor,
                  )
                      .box
                      .color(AppColors.whiteColor)
                      .size(Dimension.widthSize(35), Dimension.heightSize(35))
                      .roundedFull
                      .make(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
