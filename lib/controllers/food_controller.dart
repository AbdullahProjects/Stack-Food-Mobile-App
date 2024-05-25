import 'package:flutter/services.dart';
import 'package:food_delivery/consts/consts.dart';
import 'package:food_delivery/models/models.dart';

class FoodController extends GetxController {
  var subcat = [];
  // var quantity = 0.obs;
  // var totalPrice = 0.obs;

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

  // calculateTotalPrice(price) {
  //   totalPrice.value = price * quantity.value;
  // }
}
