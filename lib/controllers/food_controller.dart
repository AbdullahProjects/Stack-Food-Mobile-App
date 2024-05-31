import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/models/models.dart';

class FoodController extends GetxController {
  var subcat = [];
  var quantity = 0.obs;
  var totalPrice = 0.obs;

  // get subcategories of food =================================================
  getSubCategories(title) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var categories = decoded.categories ?? [];
    var category = categories.firstWhere(
      (element) => element.name == title,
      orElse: () => Categories(),
    );

    if (category.subCategories != null) {
      subcat.addAll(category.subCategories!);
    }
  }

  // increase quantity =========================================================
  addQuantity() {
    quantity.value++;
  }

  // decrease quantitiy ========================================================
  decreaseQuantity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  // calculate food total price ================================================
  calculateTotalPrice(price) {
    totalPrice.value = price * quantity.value;
  }

  resetValues() {
    quantity.value = 0;
    totalPrice.value = 0;
  }

  // get products according to category
  Stream<QuerySnapshot> getCategoryProducts(category) {
    return firestore
        .collection(foodsCollection)
        .where("category", isEqualTo: category)
        .snapshots();
  }

  // get products according to category
  Stream<QuerySnapshot> getSubCategoryProducts(category, title) {
    return firestore
        .collection(foodsCollection)
        .where("category", isEqualTo: category)
        .where("subcategory", isEqualTo: title)
        .snapshots();
  }

  // get subcategory products
}
