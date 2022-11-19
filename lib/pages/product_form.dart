import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shopping/components/drawer.dart';
import 'package:shopping/models/product.dart';
import 'package:shopping/models/products_list.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _imgUrlController = TextEditingController();
  final _imgUrlFocus = FocusNode();

  final _formKey = GlobalKey<FormState>();

  final _formDatas = Map<String, Object>();

  bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _imgUrlFocus.addListener(imgUpdate);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    if (_formDatas.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final prod = arg as Product;
        _formDatas['id'] = prod.id!;
        _formDatas['name'] = prod.name!;
        _formDatas['price'] = prod.price!;
        _formDatas['description'] = prod.description!;
        _formDatas['imageUrl'] = prod.imageUrl!;

        _imgUrlController.text = prod.imageUrl!;
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _imgUrlFocus.removeListener(imgUpdate);
    _imgUrlFocus.dispose();
  }

  void imgUpdate() {
    setState(() {});
  }

  bool imageUrlIsValide(String url) {
    bool isValideUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endWithFile =
        url.endsWith('.png') || url.endsWith('.jpg') || url.endsWith('.jpeg');

    return isValideUrl && endWithFile;
  }

  Future<void> submitForm() async {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<ProductsList>(
        context,
        listen: false,
      ).saveProduct(_formDatas);
      Navigator.of(context).pop();
    } catch (err) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text("Ops!"),
          content:
              Text("It looks like there was an error adding this product."),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("OK"),
            ),
          ],
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_formDatas.isEmpty ? 'New Product' : 'Edit Product'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _formDatas['name']?.toString(),
                      decoration: const InputDecoration(labelText: 'Name'),
                      textInputAction: TextInputAction.next,
                      onSaved: (name) => _formDatas['name'] = name ?? '',
                      validator: (nameParam) {
                        final name = nameParam ?? '';
                        if (name.trim().isEmpty) {
                          return 'Name must not be empty!';
                        }
                        if (name.trim().length < 2) {
                          return 'Name must be at least 3 letters!';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formDatas['price']?.toString(),
                      decoration: const InputDecoration(labelText: 'Price'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      onSaved: (price) {
                        _formDatas['price'] = double.parse(price ?? "0.0");
                      },
                      validator: (priceParam) {
                        final price = priceParam ?? '-1';

                        if (price.trim().isEmpty) {
                          return 'The product must have a price';
                        }
                        if (double.parse(price) <= 0) {
                          return 'Price cannot be 0';
                        }
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Image'),
                            textInputAction: TextInputAction.next,
                            focusNode: _imgUrlFocus,
                            keyboardType: TextInputType.url,
                            controller: _imgUrlController,
                            onSaved: (imageUrl) {
                              _formDatas['imageUrl'] = imageUrl ?? '';
                            },
                            validator: (urlParam) {
                              final url = urlParam ?? '';
                              if (!imageUrlIsValide(url)) {
                                return 'This is not a valid url, please check it again!';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          width: 100,
                          height: 100,
                          margin: const EdgeInsets.only(
                            top: 10,
                            left: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: _imgUrlController.text.isEmpty
                              ? const Icon(
                                  Icons.image_outlined,
                                  size: 50,
                                )
                              : Image.network(_imgUrlController.text),
                        )
                      ],
                    ),
                    TextFormField(
                      initialValue: _formDatas['description']?.toString(),
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      onSaved: (description) {
                        _formDatas['description'] = description ?? '';
                      },
                      validator: (descriptionParam) {
                        final description = descriptionParam ?? '';
                        if (description.trim().isEmpty) {
                          return 'Description must not be empty!';
                        }
                        if (description.trim().length < 2) {
                          return 'Description must be at least 3 letters!';
                        }
                        return null;
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 100,
                          height: 40,
                          margin: const EdgeInsets.all(15),
                          child: ElevatedButton(
                            onPressed: () => submitForm(),
                            child: const Text(
                              "Save",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
