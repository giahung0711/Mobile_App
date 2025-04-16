import 'package:flutter/material.dart';
import '../cart/cart_screen.dart';
import '../widgets/app_drawer.dart'; // Import AppDrawer
import '../cart/cart_manager.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(25),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              Scaffold.of(context).openDrawer(); // Mở Drawer khi nhấn vào icon
            },
            child: Icon(
              Icons.sort,
              size: 30,
              color: Colors.blue,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Funiture Store",
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
          Spacer(),
          // Cập nhật Badge để hiển thị số lượng sản phẩm khác nhau
          Consumer<CartManager>(
            builder: (ctx, cart, child) => Badge(
              backgroundColor: Colors.red,
              padding: EdgeInsets.all(7),
              label: Text(
                cart.productCount
                    .toString(), // Hiển thị số lượng sản phẩm khác nhau
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      transitionDuration:
                          Duration(milliseconds: 300), // Thời gian hiệu ứng
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          CartScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(1.0, 0.0); // Bắt đầu từ bên phải
                        const end = Offset.zero; // Kết thúc tại vị trí hiện tại
                        const curve = Curves.easeInOut;

                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: Icon(
                  Icons.shopping_bag_outlined,
                  size: 32,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
