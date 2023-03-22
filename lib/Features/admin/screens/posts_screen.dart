import 'package:amazon_clone/Features/admin/screens/add_product_screen.dart';
import 'package:amazon_clone/Features/admin/services/admin_services.dart';
import 'package:flutter/material.dart';

import '../../../common/Widgets/loader.dart';
import '../../../models/product.dart';
import '../../account/widgets/single_product.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  final AdminServices _adminSerives = AdminServices();
  List<Product>? _productList = [];
  @override
  void initState() {
    fetchAllProducts();
    super.initState();
  }

  fetchAllProducts() async {
    _productList = await _adminSerives.fetchAllProducts(context);
    setState(() {});
  }

  void deleteProduct(Product product, int index) {
    _adminSerives.deleteProduct(
      context: context,
      product: product,
      onSuccess: () {
        _productList!.removeAt(index);
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _productList == null
        ? const Loader()
        : Scaffold(
            body: GridView.builder(
              itemCount: _productList!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                final productData = _productList![index];
                return Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 140,
                        child: SingleProduct(
                          image: productData.images[0],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Text(
                              productData.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              deleteProduct(productData, index);
                            },
                            icon: const Icon(
                              Icons.delete_outline,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AddProductScreen.routeName,
                );
              },
              tooltip: "Add a Product",
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
