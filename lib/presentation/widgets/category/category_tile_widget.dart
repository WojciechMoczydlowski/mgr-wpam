import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wpam_app/business_logic/cubit/category/category_cubit.dart';
import 'package:wpam_app/utils/get_color_from_hex.dart';

class CategoryTileWidget extends StatelessWidget {
  final String id;
  final String name;
  final String color;
  final bool hidden;

  const CategoryTileWidget(
      {Key? key,
      required this.id,
      required this.name,
      required this.color,
      required this.hidden})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        BlocProvider.of<CategoryCubit>(context)
            .toggleIsCategoryHidden(id, !hidden);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(name, style: TextStyle(color: getColorFromHex(color))),
            Icon(
              hidden ? Icons.visibility_off : Icons.visibility,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
