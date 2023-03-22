import 'dart:convert';

import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Constants/error_handling.dart';
import '../../../Constants/global_variables.dart';
import '../../../Constants/utils.dart';
import 'package:http/http.dart' as http;

import '../../../Providers/user_provider.dart';

class HomeServices {
  Future<List<Product>> fetchCategoryProducts({
    required BuildContext context,
    required String category,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response response = await http.get(
        Uri.parse("$uri/api/products?category=$category"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "x-auth-token": userProvider.user.token,
        },
      );
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(response.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(response.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  Future<Product> fetchDealOfTheDay({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    Product product = Product(
      name: "",
      description: "",
      quantity: 0,
      images: [""],
      category: "",
      price: 0,
    );
    try {
      http.Response response = await http.get(
        Uri.parse("$uri/api/deal-of-the-day"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          "x-auth-token": userProvider.user.token,
        },
      );
      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: response,
        context: context,
        onSuccess: () {
          product = Product.fromJson(
            response.body,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return product;
  }
}
