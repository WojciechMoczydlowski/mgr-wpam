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
}
