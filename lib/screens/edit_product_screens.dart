import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/product.dart';
import '../provider/product_provider.dart';

class EditProudctScreen extends StatefulWidget {
  static const routeName = '/edit-products';
  const EditProudctScreen({super.key});

  @override
  State<EditProudctScreen> createState() => _EditProudctScreenState();
}

class _EditProudctScreenState extends State<EditProudctScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct = Product(
    id: '',
    title: '',
    price: 0,
    imageUrl: '',
    description: '',
  );
  var _initProduct = {
    'title': '',
    'price': '',
    'imageUrl': '',
    'description': '',
  };

  var isInit = true;

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    if (isInit) {
      final productId = ModalRoute.of(context)!.settings.arguments;
      // ignore: unnecessary_null_comparison
      if (productId != '') {
        _editedProduct = Provider.of<Products>(context, listen: false)
            .findById(productId as String);
        _initProduct = {
          'title': _editedProduct.title,
          'price': _editedProduct.price.toString(),
          'description': _editedProduct.description,
          'imageUrl': '',
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }
    isInit = false;
    super.didChangeDependencies();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      if ((!_imageUrlController.text.startsWith('http') ||
              !_imageUrlController.text.startsWith('https')) ||
          (!_imageUrlController.text.endsWith('png') ||
              !_imageUrlController.text.endsWith('jpg') ||
              !_imageUrlController.text.endsWith('jpeg'))) {
        return;
      }
      setState(() {});
    }
  }

  void _saveForm() {
    final isValid = _form.currentState!.validate();

    if (!isValid) {
      return;
    }
    _form.currentState!.save();

    // ignore: unnecessary_null_comparison
    if (_editedProduct.id != null) {
      Provider.of<Products>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    } else {
      Provider.of<Products>(context, listen: false).addProduct(_editedProduct);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Products'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _form,
            child: ListView(
              children: [
                TextFormField(
                  initialValue: _initProduct['title'],
                  decoration: const InputDecoration(labelText: 'Title'),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_priceFocusNode);
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter the title';
                    }
                    return null;
                  },
                  onSaved: (value) => Product(
                    id: _editedProduct.id,
                    title: value.toString(),
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                    description: _editedProduct.description,
                    isFavourite: _editedProduct.isFavourite,
                  ),
                ),
                TextFormField(
                  initialValue: _initProduct['price'],
                  decoration: const InputDecoration(labelText: 'Price'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  focusNode: _priceFocusNode,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_descriptionFocusNode);
                  },
                  onSaved: (value) => Product(
                    id: _editedProduct.id,
                    title: _editedProduct.title,
                    price: double.parse(value!),
                    imageUrl: _editedProduct.imageUrl,
                    description: _editedProduct.description,
                    isFavourite: _editedProduct.isFavourite,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'please enter the price';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Please Enter the valid number';
                    }
                    if (double.parse(value) <= 0) {
                      return 'Please Enter a number greater than 0';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  initialValue: _initProduct['description'],
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  focusNode: _descriptionFocusNode,
                  onSaved: (value) => Product(
                    id: _editedProduct.id,
                    title: _editedProduct.title,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                    description: value!,
                    isFavourite: _editedProduct.isFavourite,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please Enter the Description';
                    }
                    if (value.length < 10) {
                      return 'please enter more than 10 characters';
                    }
                    return null;
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      margin: const EdgeInsets.only(
                        top: 15,
                        right: 10,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                      ),
                      child: _imageUrlController.text.isEmpty
                          ? const Text('Enter the url')
                          : FittedBox(
                              child: Image.network(
                                _imageUrlController.text,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                    Expanded(
                      child: TextFormField(
                        // initialValue: _initProduct['imageUrl'],
                        decoration:
                            const InputDecoration(labelText: 'ImageUrl'),
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.done,
                        controller: _imageUrlController,
                        focusNode: _imageUrlFocusNode,
                        onEditingComplete: () {
                          setState(() {});
                        },
                        onFieldSubmitted: (_) {
                          _saveForm();
                        },
                        onSaved: (value) => Product(
                          id: _editedProduct.id,
                          title: _editedProduct.title,
                          price: _editedProduct.price,
                          imageUrl: value!,
                          description: _editedProduct.description,
                          isFavourite: _editedProduct.isFavourite,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter the url';
                          }
                          if (!value.startsWith('http') ||
                              !value.startsWith('https')) {
                            return 'Please enter the valid URL';
                          }
                          if (!value.endsWith('.png') &&
                              !value.endsWith('.jpg') &&
                              !value.endsWith('.jpeg')) {
                            return 'please enter the valid url';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                )
              ],
            )),
      ),
    );
  }
}
