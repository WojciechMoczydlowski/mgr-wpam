import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wpam_app/business_logic/cubit/add_category/add_category_cubit.dart';

class AddCategoryForm extends StatefulWidget {
  const AddCategoryForm({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return AddCategoryFormState();
  }
}

class AddCategoryFormState extends State<AddCategoryForm> {
  String _name = '';
  String _color = '';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildNameField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Name'),
      // validator: commonValidation,
      onSaved: (String? value) {
        if (value != null) {
          _name = value;
        }
      },
    );
  }

  Widget _buildColorField() {
    return TextFormField(
      decoration: const InputDecoration(labelText: 'Color'),
      // validator: commonValidation,
      onSaved: (String? value) {
        if (value != null) {
          _color = value;
        }
      },
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () => {
              if (_formKey.currentState?.validate() == true)
                {
                  _formKey.currentState?.save(),
                  BlocProvider.of<AddCategoryCubit>(context)
                      .addCategory(_name, _color)
                }
            },
        child: Center(child: BlocBuilder<AddCategoryCubit, AddCategoryState>(
          builder: ((context, state) {
            if (state is AddCategoryLoading) {
              return const CircularProgressIndicator();
            }

            return const Text("Dodaj kategorię");
          }),
        )));
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildNameField(),
            _buildColorField(),
            const SizedBox(height: 100),
            _buildSubmitButton(context)
          ]),
    );
  }
}

String commonValidation(String? value) {
  if (value == null || value.isEmpty) {
    return 'Pole jest wymagane';
  }
  return '';
}
