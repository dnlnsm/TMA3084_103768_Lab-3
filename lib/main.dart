import 'package:flutter/material.dart';

void main() {
  runApp(const RestaurantMenuApp());
}

/// Simple model for a food item.
class Food {
  final String name;
  final String description;
  final String price;
  final String image;

  const Food({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });
}

const List<Food> foods = [
  Food(
    name: 'Vegetable Pizza',
    description:
        'A fresh pizza topped with bell peppers, onions, mushrooms, olives '
        'and melted mozzarella on a crispy crust.',
    price: 'RM 18.00',
    image: 'assets/images/pizza.jpg',
  ),
  Food(
    name: 'Chicken Pizza',
    description:
        'Juicy grilled chicken, tomato sauce and gooey cheese baked to '
        'perfection on a hand-tossed base.',
    price: 'RM 22.00',
    image: 'assets/images/pizza.jpg',
  ),
  Food(
    name: 'Cheese Pizza',
    description:
        'The classic favourite: a rich blend of mozzarella and cheddar '
        'over a tangy tomato sauce.',
    price: 'RM 16.00',
    image: 'assets/images/pizza.jpg',
  ),
];

class RestaurantMenuApp extends StatelessWidget {
  const RestaurantMenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant Menu',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFFDF7FF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFF5722),
          foregroundColor: Colors.white,
          titleTextStyle: TextStyle(
            fontFamily: 'cursive',
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      home: const MenuScreen(),
    );
  }
}

/// Screen 1: the menu with three food cards.
class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Restaurant Menu')),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: foods.length,
        itemBuilder: (context, index) {
          final food = foods[index];
          return FoodCard(
            food: food,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => DetailScreen(food: food)),
              );
            },
          );
        },
      ),
    );
  }
}

/// Reusable card for one food item.
class FoodCard extends StatelessWidget {
  final Food food;
  final VoidCallback onTap;

  const FoodCard({super.key, required this.food, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange,
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                width: 66,
                height: 66,
                color: Colors.white24,
                child: FoodImage(path: food.image, size: 66),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  food.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Shows the asset image, or a pizza icon if the image file is missing.
class FoodImage extends StatelessWidget {
  final String path;
  final double size;

  const FoodImage({super.key, required this.path, required this.size});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      path,
      width: size,
      height: size,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => Icon(
        Icons.local_pizza,
        size: size * 0.7,
        color: Colors.white,
      ),
    );
  }
}

/// Screen 2 (extra task): details of the selected food.
class DetailScreen extends StatelessWidget {
  final Food food;

  const DetailScreen({super.key, required this.food});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(food.name)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.orange.shade100,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: FoodImage(path: food.image, size: 200),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              food.name,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              food.price,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.deepOrange,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              food.description,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
