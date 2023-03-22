import 'package:amazon_clone/Features/account/widgets/single_product.dart';
import 'package:flutter/cupertino.dart';

import '../../../Constants/global_variables.dart';
import '../../../common/Widgets/loader.dart';
import '../../../models/order.dart';
import '../../OrderDetails/screens/order_detail_screen.dart';
import '../Services/account_services.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  List<Order>? orders;
  final AccountServices accountServices = AccountServices();

  void fetchOrdersList() async {
    orders = await accountServices.fetchAllOrders(context);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchOrdersList();
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const Loader()
        : orders!.isEmpty
            ? const Center(child: Text("Not ordered yet"))
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                          left: 15,
                        ),
                        child: const Text(
                          'Your Orders',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                          right: 15,
                        ),
                        child: Text(
                          'See all',
                          style: TextStyle(
                            color: GlobalVariables.selectedNavBarColor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  //display orders

                  Container(
                    padding: const EdgeInsets.only(left: 10, top: 20, right: 0),
                    height: 170,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: orders!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              OrderDetailScreen.routeName,
                              arguments: orders![index],
                            );
                          },
                          child: SingleProduct(
                              image: orders![index].products[0].images[0]),
                        );
                      },
                    ),
                  )
                ],
              );
  }
}
