import 'package:ecommerce/Screens.dart/cart_screen.dart';
import 'package:ecommerce/Screens.dart/honevm.dart';
import 'package:ecommerce/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import '../CustomWidgets/custom_button.dart';

class ProductDetailPage extends StatelessWidget {
  final Product data;

  const ProductDetailPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeDashboardVm>(builder: (context, vm, child) {
      return Scaffold(
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.arrow_back)),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.1), spreadRadius: 1, blurRadius: 8, offset: const Offset(0, 4)),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                data.image,
                                fit: BoxFit.contain,
                                width: 200,
                                height: 200,
                              ),
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.favorite_border,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.share,
                                    color: Colors.grey,
                                    size: 20,
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.green, Colors.teal],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(
                          color: Colors.teal.shade700,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.local_shipping, color: Colors.white, size: 14),
                          const SizedBox(width: 8),
                          Text(
                            "Free Shipping",
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    5.height,
                    Text(
                      data.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    5.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '\u{20B9}${data.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.green),
                              child: Row(
                                children: [
                                  Icon(Icons.star, color: Colors.white, size: 14),
                                  Text(
                                    data.rating.rate.toString(),
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                            8.width,
                            Text(
                              '(${data.rating.count} Reviews)',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black38,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    20.height,
                    Text(data.description, style: const TextStyle(fontSize: 13, color: Colors.black38)),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 14,
              right: 14,
              child: CustomButton(
                width: double.infinity,
                text: "Add To Cart",
                onPressed: () {
                  vm.addToCart(data);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Cart()));
                },
                backgroundColor: Colors.green,
                textColor: Colors.white,
                iconColor: Colors.white,
              ),
            ),
          ],
        ),
      );
    });
  }
}
