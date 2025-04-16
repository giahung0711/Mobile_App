import 'package:flutter/material.dart';

class Categories extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {"image": "assets/ban.jpg", "name": "Bàn"},
    {"image": "assets/ghe.jpg", "name": "Ghế"},
    {"image": "assets/giuong.jpg", "name": "Giường"},
    {"image": "assets/tu.jpg", "name": "Tủ"},
    {"image": "assets/guong.jpg", "name": "Kệ"},
  ];

  final Function(String) onCategorySelected;
  final String selectedCategory;

  Categories({
    required this.onCategorySelected,
    required this.selectedCategory,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categories.map((category) {
          bool isSelected = category["name"] == selectedCategory;
          return GestureDetector(
            onTap: () =>
                onCategorySelected(isSelected ? "" : category["name"]!),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.blue, width: 2),
              ),
              child: Row(
                children: [
                  Image.asset(category["image"]!, width: 40, height: 40),
                  SizedBox(width: 5),
                  Text(
                    category["name"]!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: isSelected ? Colors.white : Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
