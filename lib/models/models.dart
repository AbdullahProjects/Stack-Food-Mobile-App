import 'dart:convert';

CategoryModel categoryModelFromJson(String str) {
  return CategoryModel.fromJson(json.decode(str));
}

class CategoryModel {
  List<Categories>? categories;

  CategoryModel({this.categories});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
  }
  // not need to convert again dart data to JSON

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   if (this.categories != null) {
  //     data['categories'] = this.categories!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}

class Categories {
  String? name;
  List<String>? subCategories;

  Categories({this.name, this.subCategories});

  Categories.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    subCategories = json['sub_categories'].cast<String>();
  }

  // not need to convert again dart data to JSON

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['name'] = this.name;
  //   data['sub_categories'] = this.subCategories;
  //   return data;
  // }
}
