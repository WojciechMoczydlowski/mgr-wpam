import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:wpam_app/business_logic/cubit/category/category_cubit.dart';
import 'package:wpam_app/data/repositories/category_repository.dart';

part 'add_category_state.dart';

class AddCategoryCubit extends Cubit<AddCategoryState> {
  final CategoryRepository categoryRepository;
  final CategoryCubit categoryCubit;

  AddCategoryCubit(this.categoryRepository, this.categoryCubit)
      : super(AddCategoryInitial());

  addCategory(String name, String color) {
    emit(AddCategoryLoading());

    categoryRepository.addCategory(name, color).then((category) {
      categoryCubit.addCategory(category);
      emit(CategoryAdded());
    });
  }
}
