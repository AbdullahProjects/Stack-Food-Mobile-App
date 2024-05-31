import 'package:firebase_core/firebase_core.dart';
import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/controllers/profile_controller.dart';
import 'package:food_delivery/views/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyCaFGwaP6BrZTyqiWCLfmUUkdV9gauvytk",
      appId: "1:264032441620:android:f79dd522892a9959f15e01",
      messagingSenderId: "264032441620",
      projectId: "food-delivery-app-56b0e",
      storageBucket: "gs://food-delivery-app-56b0e.appspot.com",
    ),
  );
  runApp(MyApp());
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  final themeController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeController.isDarkTheme.value
            ? ThemeData.dark()
            : ThemeData.light(),
        title: 'Food Delivery App',
        home: const SplashScreen(),
      ),
    );
  }
}
