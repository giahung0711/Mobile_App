import 'package:ct312h_project/ui/cart/cart_manager.dart';
import 'package:ct312h_project/ui/products/user_product_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/pages/HomePage.dart';
import 'ui/cart/cart_screen.dart';
import 'ui/products/edit_product_screen.dart';
import 'ui/products/user_product_list_tile.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'ui/auth/auth_manager.dart';
import 'ui/pages/product_manager.dart';
import 'ui/products/product_detail_screen.dart';
import 'ui/splash_screen.dart';
import 'ui/auth/auth_screen.dart';
import 'ui/screen.dart';
import 'services/auth_service.dart';
// import 'ui/orders/orders_manager.dart'; //

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthManager()),
        ChangeNotifierProvider(create: (ctx) => ProductsManager()),
        ChangeNotifierProvider(create: (ctx) => CartManager()),
        // ChangeNotifierProvider(create: (ctx) => OrdersManager()),
      ],
      child: Consumer<AuthManager>(
        builder: (ctx, authManager, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
            ),
            home: authManager.isAuth
                ? const HomePage()
                : FutureBuilder(
                    future: authManager.tryAutoLogin(),
                    builder: (ctx, snapshot) {
                      return snapshot.connectionState == ConnectionState.waiting
                          ? const SafeArea(child: SplashScreen())
                          : const SafeArea(child: AuthScreen());
                    },
                  ),
            routes: {
              CartScreen.routeName: (ctx) => const CartScreen(),
              UserProductsScreen.routeName: (ctx) => const UserProductsScreen(),
            },
            onGenerateRoute: (settings) {
              if (settings.name == ProductDetailScreen.routeName) {
                final productId = settings.arguments as String;
                return MaterialPageRoute(
                  builder: (ctx) {
                    return SafeArea(
                      child: ProductDetailScreen(
                        ctx.read<ProductsManager>().findById(productId)!,
                      ),
                    );
                  },
                );
              }
              if (settings.name == EditProductScreen.routeName) {
                final productId = settings.arguments as String?;
                return MaterialPageRoute(
                  builder: (ctx) {
                    return SafeArea(
                      child: EditProductScreen(
                        productId != null
                            ? ctx.read<ProductsManager>().findById(productId)
                            : null,
                      ),
                    );
                  },
                );
              }
              return null;
            },
          );
        },
      ),
    );
  }
}
