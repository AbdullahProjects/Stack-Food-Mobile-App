import 'package:food_delivery/consts/consts.dart';

class FirestoreServices extends GetxController {
  // get users data
  static getUser(uid) {
    return firestore
        .collection(usersCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

  // get featured products
  static getFeaturedProducts() {
    return firestore
        .collection(foodsCollection)
        .where("is_featured", isEqualTo: true)
        .get();
  }

  // get popular products
  static getPopularProducts() {
    return firestore
        .collection(foodsCollection)
        .where("is_popular", isEqualTo: true)
        .get();
  }

  
}
