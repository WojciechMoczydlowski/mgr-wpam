import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/models/category.dart';
import '../../data/repositories/category_repository.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryCubit(this.categoryRepository) : super(CategoryInitial());

  void fetchCategories() {
    categoryRepository
        .fetchCategories()
        .then((categories) => {emit(CategoryLoaded(categories))});
  }
}
