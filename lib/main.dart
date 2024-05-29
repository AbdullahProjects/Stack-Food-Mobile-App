import 'package:firebase_core/firebase_core.dart';
import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/views/splash_screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyCaFGwaP6BrZTyqiWCLfmUUkdV9gauvytk",
        appId: "1:264032441620:android:f79dd522892a9959f15e01",
        messagingSenderId: "264032441620",
        projectId: "food-delivery-app-56b0e",
        storageBucket: "gs://food-delivery-app-56b0e.appspot.com"),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Delivery App',
      home: SplashScreen(),
    );
  }
}
