import 'package:food_delivery/consts/consts.dart';

class ShoppingController extends GetxController {
  // var quantity = 0.obs;
  // var totalPrice = 0.obs;
  // add to cart ===============================================================
  addToCart({uid, foodName, foodImg, foodPrice, qty, totalPrice}) async {
    await firestore.collection(cartsCollection).doc().set({
      'added_by': uid,
      'food_name': foodName,
      'food_img': foodImg,
      'food_price': foodPrice,
      'quantity': qty,
      'totalPrice': totalPrice,
    });
  }

  // get cart ==================================================================
  getCart(uid) {
    return firestore
        .collection(cartsCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }
}
