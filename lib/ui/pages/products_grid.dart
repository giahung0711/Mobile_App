import 'package:flutter/material.dart';
import '../../models/product.dart';
import 'product_grid_tile.dart';
import 'product_manager.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavorites;
  final String searchQuery;

  const ProductsGrid(this.showFavorites, {this.searchQuery = "", super.key});

  @override
  Widget build(BuildContext context) {
    final productsManager = context.watch<ProductsManager>();
    List<Product> products =
        showFavorites ? productsManager.favoriteItems : productsManager.items;

    // Lọc sản phẩm theo tiêu đề
    products = products
        .where((product) =>
            product.title.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth =
        screenWidth / 2 - 20; // Chia đôi màn hình với khoảng cách lề
    double itemHeight = itemWidth * 1.5; // Điều chỉnh tỷ lệ phù hợp
    double aspectRatio = itemWidth / itemHeight;

    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Hiển thị 2 cột
        childAspectRatio: aspectRatio, // Tự động tính tỷ lệ
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: products.length,
      itemBuilder: (ctx, i) => ProductGridTile(products[i]),
    );
  }
}
