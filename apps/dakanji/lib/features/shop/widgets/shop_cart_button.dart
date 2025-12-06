import 'package:flutter/material.dart';
import 'shop_constants.dart';

class AddToCartButton extends StatelessWidget {
  final String label;

  const AddToCartButton({
    super.key,
    this.label = "ADD TO CART",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: kPrimaryActionColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: kPrimaryActionColor.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Added to Cart'),
                duration: Duration(milliseconds: 500),
              ),
            );
          },
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}