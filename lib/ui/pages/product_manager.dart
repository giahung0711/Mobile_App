import 'package:flutter/foundation.dart';
import '../../../models/product.dart';
import '../../services/products_service.dart';

class ProductsManager with ChangeNotifier {
  final ProductsService _productsService = ProductsService();
  List<Product> _items = [];

  int get itemCount {
    return _items.length;
  }

  List<Product> get items {
    return [..._items]; // Trả về một bản sao của danh sách _items
  }

  List<Product> get favoriteItems {
    return _items.where((item) => item.isFavorite).toList();
  }

  Product? findById(String id) {
    try {
      return _items.firstWhere((item) => item.id == id);
    } catch (error) {
      return null;
    }
  }

  Future<void> fetchProducts() async {
    print("🔄 Fetching products...");
    _items = await _productsService.fetchProducts();
    print("✅ Fetched ${_items.length} products");
    notifyListeners();
  }

  Future<void> fetchUserProducts() async {
    _items = await _productsService.fetchProducts(
      filteredByUser: true,
    );
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final newProduct = await _productsService.addProduct(product);
    if (newProduct != null) {
      _items.add(newProduct);
      notifyListeners();
    }
  }

  Future<void> updateProduct(Product product) async {
    final index = _items.indexWhere((item) => item.id == product.id);
    if (index >= 0) {
      final updatedProduct = await _productsService.updateProduct(product);
      if (updatedProduct != null) {
        _items[index] = updatedProduct;
        notifyListeners();
      }
    }
  }

  Future<void> deleteProduct(String id) async {
    final index = _items.indexWhere((item) => item.id == id);
    if (index >= 0 && !await _productsService.deleteProduct(id)) {
      _items.removeAt(index);
      notifyListeners();
    }
  }
}
