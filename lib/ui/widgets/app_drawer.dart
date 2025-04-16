import 'package:flutter/material.dart';
import '../products/user_product_screen.dart';
import '../auth/auth_manager.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blue,
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text(
              'Furniture Shop',
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.blue,
          ),

          const Divider(color: Colors.white), // Màu ngăn cách trắng
          _buildDrawerItem(Icons.shop, 'Home', () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          const Divider(color: Colors.white),
          _buildDrawerItem(Icons.edit, 'Manage Products', () {
            Navigator.of(context)
                .pushReplacementNamed(UserProductsScreen.routeName);
          }),
          const Divider(color: Colors.white),
          _buildDrawerItem(Icons.exit_to_app, 'Logout', () {
            Navigator.of(context)
              ..pop()
              ..pushReplacementNamed('/');
            context.read<AuthManager>().logout();
          }),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.white), // Icon màu trắng
      title: Text(
        title,
        style: const TextStyle(color: Colors.white), // Chữ màu trắng
      ),
      onTap: onTap,
    );
  }
}
