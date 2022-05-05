import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColorPickerFieldWidget extends FormField<Color> {
  ColorPickerFieldWidget(
      {Key? key,
      required BuildContext context,
      required FormFieldSetter<Color> onSaved,
      FormFieldValidator<Color>? validator,
      Color initialValue = Colors.red,
      bool autovalidate = false})
      : super(
            key: key,
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            builder: (FormFieldState<Color> state) {
              return Row(
                children: <Widget>[
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      primary: state.value,
                    ),
                    icon: Icon(Icons.palette, color: state.value),
                    label: const Text('Wybierz kolor'),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Select a color'),
                            content: SingleChildScrollView(
                              child: BlockPicker(
                                  pickerColor: state.value ?? Colors.red,
                                  onColorChanged: (value) => {
                                        state.didChange(value),
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop('dialog')
                                      }),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              );
            });
}

// class CounterFormField extends FormField<int> {
//   CounterFormField(
//       {required FormFieldSetter<int> onSaved,
//       required FormFieldValidator<int> validator,
//       int initialValue = 0,
//       bool autovalidate = false})
//       : super(
//             onSaved: onSaved,
//             validator: validator,
//             initialValue: initialValue,
//             builder: (FormFieldState<int> state) {
//               return Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   IconButton(
//                     icon: Icon(Icons.remove),
//                     onPressed: () {
//                       state.didChange(state.value - 1);
//                     },
//                   ),
//                   Text(state.value.toString()),
//                   IconButton(
//                     icon: Icon(Icons.add),
//                     onPressed: () {
//                       state.didChange(state.value + 1);
//                     },
//                   ),
//                 ],
//               );
//             });
// }
