import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/controllers/main_page_controller.dart';
import 'package:food_delivery/views/shopping_screen/shopping.dart';
import 'package:food_delivery/views/category_screen/category_page.dart';
import 'package:food_delivery/views/home_screen/home_page.dart';
import 'package:food_delivery/views/profile_screen/profile_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    // initializing MainPageController
    var mainPageController = Get.put(MainPageController());
    // screens
    var screens = [
      const HomePage(),
      const CategoryPage(),
      const CartPage(),
      const ProfilePage()
    ];
    // nav bar items
    var navBarItems = [
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            size: 24,
          ),
          label: 'Home'),
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.restaurant_menu,
            size: 24,
          ),
          label: 'Menu'),
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.shopping_cart,
            size: 24,
          ),
          label: 'Shopping'),
      const BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
            size: 24,
          ),
          label: 'Profile'),
    ];

    return Scaffold(
      // body content
      body: Column(
        children: [
          Obx(
            () => Expanded(
                child:
                    screens.elementAt(mainPageController.currentIndex.value)),
          )
        ],
      ),
      // bottom bar
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: mainPageController.currentIndex.value,
          selectedItemColor: AppColors.mainColor,
          elevation: 7.0,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.whiteColor,
          items: navBarItems,
          onTap: (value) {
            mainPageController.currentIndex.value = value;
          },
        ),
      ),
    );
  }
}
