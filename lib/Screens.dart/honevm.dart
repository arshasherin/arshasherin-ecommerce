import 'dart:convert';
import 'dart:math';

import 'package:ecommerce/model/cart_model.dart';
import 'package:ecommerce/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeDashboardVm extends ChangeNotifier {
  bool isSelect = false;
  // List<String> categories = ["All", "Smartphone", "Lipstick", "Shoe", "Headphone", "Watch"];
  String selectedCategory = " ";
  List<String> images = ['assets/g1.png', 'assets/g11.png', 'assets/g2.png', 'assets/g8.png', 'assets/g3.png', 'assets/g6.png', 'assets/g4.png', 'assets/g5.png', 'assets/g7.png', 'assets/g9.png', 'assets/g10.png'];
  List<Product> productList = [];
  List<Cart> cartList = [];
  List<Product> cart = [];
  String? selectedPaymentMethod;
  List<String> categoryList = [];
  int? qty;
  HomeDashboardVm() {
    getProduct();
    getCart();
    getCategories();
  }

  Future<void> getProduct({String? category, String? query}) async {
    try {
      print("queryyyyy" + query.toString());
      String url = 'https://fakestoreapi.com/products';
      if (category != null && category != "All") {
        url += '/category/$category';
      }
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        if (response.body.isNotEmpty) {
          List<dynamic> data = json.decode(response.body);
          productList = data.map((json) => Product.fromJson(json)).toList();
          print("Productlistttt" + productList.toString());
          // Apply search filter if a query is provided
          if (query != null && query.isNotEmpty) {
            productList = productList.where((product) => product.title.toLowerCase().contains(query.toLowerCase())).toList();
            print("nimmmmm" + productList.length.toString());
          }

          print("Filtered productList: ${productList.length}");
        } else {
          print("Empty response body.");
          productList = []; // Set productList to empty if no data
        }
      } else {
        print("Error: ${response.statusCode} ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error fetching products: $e");
    }
    notifyListeners();
  }

  Future<void> getCart() async {
    try {
      final res = await http.get(Uri.parse('https://fakestoreapi.com/carts'));
      if (res.statusCode == 200) {
        List<dynamic> data = json.decode(res.body);
        cartList = data.map((e) => Cart.fromJson(e)).toList();
        print("cartlist" + cartList.toString());
      } else {
        throw Exception("failed");
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getCategories() async {
    try {
      final response = await http.get(Uri.parse('https://fakestoreapi.com/products/categories'));
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        categoryList = ["All", ...List<String>.from(data)];

        print("categoryList: ${categoryList.length}");
      } else {
        throw Exception("failed");
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  void selectCategory(String category) {
    selectedCategory = category;
    getProduct(category: category);
    notifyListeners();
  }

  void refresh() {
    notifyListeners();
  }

  Future<void> addToCart(Product product) async {
    final url = Uri.parse("https://fakestoreapi.com/carts");

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "userId": 6,
          "date": "2020-02-03",
          "products": [
            {"productId": product.id, "quantity": 1}
          ]
        }),
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        final cartId = responseBody['id'];
        print("Added to cart with ID: $cartId");

        cart.add(product); // Add product to local cart
        notifyListeners(); // Update UI
      } else {
        throw Exception("Failed to add to cart");
      }
    } catch (error) {
      print("Error adding to cart: $error");
    }
  }

  void increaseQuantity(Product product) {
    final cartItem = cart.firstWhere(
      (item) => item.id == product.id,
    );
    if (cartItem != null) {
      // qty++;
      notifyListeners();
    }
  }

  void decreaseQuantity(Product product) {
    final cartItem = cart.firstWhere(
      (item) => item.id == product.id,
    );
    if (cartItem != null && qty! > 1) {
      // qty--;
      notifyListeners();
    } else if (cartItem != null && qty == 1) {
      cart.remove(cartItem); // Remove item if quantity reaches 0
      notifyListeners();
    }
  }
}
