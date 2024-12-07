import 'package:flutter/material.dart';
import '../screens/category_screen.dart';

class CategoryTile extends StatelessWidget {
  final String category;
  final IconData icon;

  const CategoryTile({required this.category, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CategoryScreen(category: category)),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40),
          SizedBox(height: 8),
          Text(category, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
