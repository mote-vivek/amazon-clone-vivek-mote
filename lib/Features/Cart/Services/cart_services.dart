import 'dart:convert';

import 'package:amazon_clone/Constants/error_handling.dart';
import 'package:amazon_clone/Constants/global_variables.dart';
import 'package:amazon_clone/Constants/utils.dart';
import 'package:amazon_clone/Providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../models/product.dart';
import 'package:http/http.dart' as http;

import '../../../models/user.dart';

class CartServices {
  void removeFromCart({
    required BuildContext context,
    required Product product,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.delete(
        Uri.parse("$uri/api/delete-from-cart/${product.id}"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      // ignore: use_build_context_synchronously
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          User user =
              userProvider.user.copyWith(cart: jsonDecode(res.body)["cart"]);
          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
