import 'package:extended_tabs/extended_tabs.dart';
import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/common_widgets/text_styles.dart';
import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/views/shopping_screen/cart_screen.dart';
import 'package:food_delivery/views/shopping_screen/favourite_screen.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: mediumText(
          text: "My Favourites & Cart",
          color: AppColors.whiteColor,
          size: Dimension.widthSize(20),
        ),
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // tabs titles =======================================================
          SizedBox(
            height: Dimension.heightSize(45),
            child: ExtendedTabBar(
              controller: _tabController,
              indicatorColor: AppColors.mainColor,
              labelColor: AppColors.mainColor,
              unselectedLabelColor: AppColors.titleColor,
              labelStyle: TextStyle(
                fontFamily: robotoMedium,
                fontSize: Dimension.widthSize(13),
              ),
              unselectedLabelStyle: TextStyle(
                fontFamily: robotoMedium,
                fontSize: Dimension.widthSize(12),
              ),
              tabs: const [
                Tab(
                  text: "Your Cart",
                ),
                Tab(
                  text: "Your Favourites",
                ),
              ],
            ),
          ),
          // tabs content ======================================================
          Expanded(
            child: ExtendedTabBarView(
              controller: _tabController,
              children: const [
                CartScreen(),
                FavouriteScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
