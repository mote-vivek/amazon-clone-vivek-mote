import 'package:amazon_clone/Features/account/widgets/account_button.dart';
import 'package:flutter/cupertino.dart';

import '../Services/account_services.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({Key? key}) : super(key: key);

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  AccountServices accountServices = AccountServices();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(
              text: "your Orders",
              onTap: () {},
            ),
            AccountButton(
              text: "Turn Seller",
              onTap: () {},
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            AccountButton(
              text: "Log out",
              onTap: () {
                accountServices.logOut(context);
              },
            ),
            AccountButton(
              text: "Wish List",
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
