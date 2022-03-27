import '../data_providers/category_api.dart';
import '../models/category.dart';

class CategoryRepository {
  final CategoryAPI api;

  CategoryRepository(this.api);

  Future<List<Category>> fetchCategories() async {
    try {
      final Map<String, dynamic> rawCategories =
          await api.featchRawCategories();

      final List<Category> categories = rawCategories['data'].map((value) {
        return Category.fromJson(value);
      });

      return categories;
    } catch (e) {
      return [];
    }
  }
}
