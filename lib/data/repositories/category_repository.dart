import 'package:uuid/uuid.dart';

import '../data_providers/category_api.dart';
import '../models/category.dart';

class CategoryRepository {
  final CategoryAPI api;

  CategoryRepository(this.api);

  Future<List<Category>> fetchCategories() async {
    try {
      final rawCategories = await api.featchRawCategories();

      List<Category> categories =
          List<Category>.from(rawCategories['data'].map((value) {
        return Category(
            id: value['id'], name: value['name'], color: value['color']);
      }));

      return categories;
    } catch (e) {
      return [];
    }
  }

  Future<Category> addCategory(String name, String color) async {
    try {
      const uuid = Uuid();

      List<Category> categories = await fetchCategories();
      Category newCategory = Category(id: uuid.v1(), color: color, name: name);

      categories.add(newCategory);

      Map<String, Object?> categoriesMap = Map<String, Object?>.from(
          {"data": categories.map((c) => c.toJson()).toList()});

      await api.saveCategories(categoriesMap);
      return newCategory;
    } catch (e) {
      rethrow;
    }
  }
}
