import 'package:amazon_clone/Constants/global_variables.dart';
import 'package:amazon_clone/Features/admin/screens/admin_screen.dart';
import 'package:amazon_clone/Features/auth/Screens/auth_screen.dart';
import 'package:amazon_clone/Providers/user_provider.dart';
import 'package:amazon_clone/common/Widgets/bottom_bar.dart';
import 'package:amazon_clone/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Features/auth/Services/auth_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService _authService = AuthService();
  @override
  void initState() {
    _authService.getUserData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Amazon Clone",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      // home: const AdminScreen(),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.type == "user"
              ? Builder(
                  builder: (context) {
                    return const BottomBar();
                  },
                )
              : Builder(
                  builder: (context) {
                    return const AdminScreen();
                  },
                )
          : Builder(
              builder: (context) {
                return const AuthScreen();
              },
            ),
    );
  }
}
