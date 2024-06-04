import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_delivery/common_widgets/common_widgets.dart';
import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/views/main_screen/main_page.dart';

class ShoppingController extends GetxController {
  // var quantity = 0.obs;
  var totalCartPrice = 0.obs;
  var isFav = false.obs;
  List<Map<String, dynamic>> orders = [];

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

  // delete cart ===============================================================
  deleteCart(docId) async {
    await firestore.collection(cartsCollection).doc(docId).delete();
  }

  // get all carts items of user for calculating total price ===================
  getTotalCartItemsPrice() async {
    // start from zero price always
    totalCartPrice.value = 0;
    // get all cart items of user
    var cartItems = await firestore
        .collection(cartsCollection)
        .where("added_by", isEqualTo: currentUser!.uid)
        .get();
    // run for loop to calculate price
    for (int i = 0; i < cartItems.docs.length; i++) {
      totalCartPrice.value += cartItems.docs[i]["totalPrice"] as int;
    }
  }

  // get cart ==================================================================
  getCart(uid) {
    return firestore
        .collection(cartsCollection)
        .where('added_by', isEqualTo: uid)
        .snapshots();
  }

  // check the product is in favourite or not===================================
  checkIfFav(data) async {
    if (data["wishlist"].contains(currentUser!.uid)) {
      isFav(true);
    } else {
      isFav(false);
    }
  }

  // get all favourites foods ==================================================
  getFavouritesFoods() {
    return firestore
        .collection(foodsCollection)
        .where("wishlist", arrayContains: currentUser!.uid)
        .snapshots();
  }

  // add to favourites =========================================================
  addToFavourite(docId, context) async {
    await firestore.collection(foodsCollection).doc(docId).set({
      'wishlist': FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(true);
    showToast(context: context, msg: "Added to Favourites!", seconds: 3000);
  }

  // remove to favourites ======================================================
  removeToFavourite(docId, context) async {
    await firestore.collection(foodsCollection).doc(docId).set({
      'wishlist': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(false);
    showToast(context: context, msg: "Remove from Favourites!", seconds: 3000);
  }

  // get all orders ============================================================
  getOrders() {
    return firestore
        .collection(ordersCollection)
        .where("order_by", isEqualTo: currentUser!.uid)
        // .orderBy("order_date", descending: true)
        .snapshots();
  }

  // clear cart ================================================================
  clearCart() async {
    // get all cart items of user
    var userCart = await firestore
        .collection(cartsCollection)
        .where('added_by', isEqualTo: currentUser!.uid)
        .get();
    if (userCart.docs.isNotEmpty) {
      var cartItems = userCart.docs;
      for (var cartItem in cartItems) {
        // Delete each cart item document
        await firestore.collection(cartsCollection).doc(cartItem.id).delete();
      }
    }
  }

  // place my order ============================================================
  placeOrder(context, username, number, address, city) async {
    totalCartPrice.value = 0;
    // get all cart items of user
    var userCart = await firestore
        .collection(cartsCollection)
        .where('added_by', isEqualTo: currentUser!.uid)
        .get();
    if (userCart.docs.isNotEmpty) {
      orders.clear();
      // add cart one by one in orders
      var cartItems = userCart.docs;
      for (int i = 0; i < cartItems.length; i++) {
        orders.add({
          "food_name": cartItems[i]["food_name"],
          "food_img": cartItems[i]["food_img"],
          "quantity": cartItems[i]["quantity"],
          "price": cartItems[i]["food_price"],
          "totalPrice": cartItems[i]["totalPrice"],
        });
        // also calculate price one by one
        totalCartPrice.value =
            totalCartPrice.value + cartItems[i]["totalPrice"] as int;
      }
      // now place order
      await firestore.collection(ordersCollection).doc().set({
        "order_number": "5990200311",
        "order_by": currentUser!.uid,
        "order_date": FieldValue.serverTimestamp(),
        "number": number,
        "username": username,
        "address": address,
        "city": city,
        "orders_list": orders,
        "totalPrice": totalCartPrice.value,
      });
      clearCart();
      Get.offAll(() => const MainPage());
      showToast(
          context: context, msg: "Order placed successfully", seconds: 3000);
    } else {
      showToast(context: context, msg: "Cart is empty", seconds: 5000);
    }
  }
}
