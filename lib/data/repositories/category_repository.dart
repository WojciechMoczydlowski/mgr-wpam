import 'package:uuid/uuid.dart';
import 'package:wpam_app/business_logic/cubit/category/category_cubit.dart';

import '../data_providers/category_api.dart';
import '../models/category.dart';

class CategoryRepository {
  final CategoryAPI api;

  CategoryRepository(this.api);

  Future<List<Category>> fetchCategories() async {
    try {
      final rawCategories = await api.fetchRawCategories();

      List<Category> categories =
          List<Category>.from(rawCategories['data'].map((value) {
        return Category(
            id: value['id'],
            name: value['name'],
            color: value['color'],
            hidden: value['hidden']);
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
      Category newCategory =
          Category(id: uuid.v1(), color: color, name: name, hidden: false);

      categories.add(newCategory);

      final rawCategories = _prepareCategoriesForApi(categories);

      await api.saveCategories(rawCategories);
      return newCategory;
    } catch (e) {
      rethrow;
    }
  }

  Future<Category> toggleIsCategoryHidden(String id, bool hidden) async {
    try {
      List<Category> categories = await fetchCategories();

      int index = categories.indexWhere((category) => category.id == id);

      categories[index].hidden = hidden;

      final rawCategories = _prepareCategoriesForApi(categories);

      await api.saveCategories(rawCategories);

      return categories[index];
    } catch (e) {
      rethrow;
    }
  }

  Map<String, Object?> _prepareCategoriesForApi(List<Category> categories) {
    return Map<String, Object?>.from(
        {"data": categories.map((c) => c.toJson()).toList()});
  }

  void emit(CategoryLoaded categoryLoaded) {}
}
