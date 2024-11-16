
import 'package:flutter/material.dart';

class DashBoardFirstScreen extends StatelessWidget {
  const DashBoardFirstScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Discover",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(height: 28, width: 28, decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: Colors.grey, width: 0.5)), child: IconButton(padding: EdgeInsets.zero, onPressed: () {}, icon: const Icon(Icons.add_shopping_cart, size: 15, color: Colors.black))),
            Positioned(
              top: -8,
              right: -5,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                child: const Text(
                  "3",
                  style: TextStyle(color: Colors.white, fontSize: 10),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}