import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wpam_app/data/repositories/category_repository.dart';

import '../../../data/models/category.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryCubit(this.categoryRepository) : super(CategoryInitial());

  void fetchCategories() {
    categoryRepository
        .fetchCategories()
        .then((categories) => {emit(CategoryLoaded(categories))});
  }

  addCategory(Category category) {
    final currentState = state;
    if (currentState is CategoryLoaded) {
      final categories = currentState.categories;
      categories.add(category);
      emit(CategoryLoaded(categories));
    }
  }
}
