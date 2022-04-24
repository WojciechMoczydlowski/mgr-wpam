import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wpam_app/business_logic/cubit/add_tracking_item/add_tracking_item_cubit.dart';
import 'package:wpam_app/utils/get_color_from_hex.dart';

class TrackerTileWidget extends StatelessWidget {
  final String categoryId;
  final String name;
  final String color;

  const TrackerTileWidget(
      {Key? key,
      required this.name,
      required this.color,
      required this.categoryId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTrackingItemCubit, AddTrackingItemState>(
      builder: (context, state) {
        return TextButton(
            onPressed: () {
              BlocProvider.of<AddTrackingItemCubit>(context)
                  .addTrackingItem(categoryId, name, color);
            },
            child: Container(
              color: getColorFromHex(color),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [Text(name)],
              ),
            ));
      },
    );
  }
}
