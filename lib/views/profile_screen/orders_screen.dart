import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.mainColor,
        title: mediumText(
          text: "My Orders",
          color: AppColors.whiteColor,
          size: Dimension.widthSize(20),
        ),
        centerTitle: true,
      ),
    );
  }
}
