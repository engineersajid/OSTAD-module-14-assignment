import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'providers/cart_provider.dart';
import 'viewmodels/product_view_model.dart';
import 'views/home/home_view.dart';

void main() {
  runApp(const ProductCartApp());
}

class ProductCartApp extends StatelessWidget {
  const ProductCartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CartProvider(),
        ),

        ChangeNotifierProvider(
          create: (_) => ProductViewModel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConstants.appName,
        theme: AppTheme.lightTheme,
        home: const HomeView(),
      ),
    );
  }
}