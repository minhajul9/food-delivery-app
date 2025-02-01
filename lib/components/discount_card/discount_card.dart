import 'package:flutter/material.dart';

class DiscountCard extends StatelessWidget {

  final List<Color> gradientColors;
  final String discountText;
  final String details;
  final String deliveryText;

  DiscountCard({
    required this.gradientColors,
    required this.discountText,
    required this.details,
    required this.deliveryText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      width: 300,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: gradientColors),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            discountText,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          Text(
            details,
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.delivery_dining, color: Colors.white70),
              SizedBox(width: 8),
              Text(
                deliveryText,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
