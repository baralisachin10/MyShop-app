import 'package:flutter/material.dart';

class EditProudctScreen extends StatefulWidget {
   static const routeName = '/edit-products';
  const EditProudctScreen({super.key});

  @override
  State<EditProudctScreen> createState() => _EditProudctScreenState();
}

class _EditProudctScreenState extends State<EditProudctScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
          child: ListView(
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Title'),
            textInputAction: TextInputAction.next,
          )
        ],
      )),
    );
  }
}
