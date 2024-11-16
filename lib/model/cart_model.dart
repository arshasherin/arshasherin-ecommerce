import 'dart:convert';

import 'package:ecommerce/model/product_model.dart';

class Cart {
  final int id;
  final int userId;
  final DateTime date;
  final List<CartProduct> products;
  final int version;

  Cart({
    required this.id,
    required this.userId,
    required this.date,
    required this.products,
    required this.version,
  });

  // Factory constructor to create an Cart from a JSON map
  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        id: json['id'],
        userId: json['userId'],
        date: DateTime.parse(json['date']),
        products: List<CartProduct>.from(json['products'].map((x) => Product.fromJson(x))),
        version: json['__v'],
      );

  // Method to convert an Order to a JSON map
  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'date': date.toIso8601String(),
        'products': List<dynamic>.from(products.map((x) => x.toJson())),
        '__v': version,
      };
}

class CartProduct {
  final int productId;
  final int quantity;

  CartProduct({
    required this.productId,
    required this.quantity,
  });

  // Factory constructor to create a Product from a JSON map
  factory CartProduct.fromJson(Map<String, dynamic> json) => CartProduct(
        productId: json['productId'],
        quantity: json['quantity'],
      );

  // Method to convert a Product to a JSON map
  Map<String, dynamic> toJson() => {
        'productId': productId,
        'quantity': quantity,
      };
}

// Function to parse JSON string and return a list of Orders
List<Cart> CartFromJson(String str) => List<Cart>.from(json.decode(str).map((x) => Cart.fromJson(x)));

// Function to convert a list of Carts to JSON string
String CartToJson(List<Cart> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
