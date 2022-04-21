part of 'add_category_cubit.dart';

@immutable
abstract class AddCategoryState {}

class AddCategoryInitial extends AddCategoryState {}

class AddCategoryError extends AddCategoryState {
  final String error;

  AddCategoryError(this.error);
}

class AddCategoryLoading extends AddCategoryState {}

class CategoryAdded extends AddCategoryState {}
