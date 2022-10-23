import 'package:flutter/material.dart';
import 'restaurant_model.dart';


class detailPage extends StatelessWidget {

  final RestaurantModel restaurant;

  const detailPage({
    super.key,
    required this.restaurant,
    });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints(
                    minWidth: 44,
                    minHeight: 44,
                    maxWidth: 64,
                    maxHeight: 64,
                  ),
                  child: Image.asset(restaurant.image, fit: BoxFit.cover),
            ),
            // Image.asset(restaurant.imgList[index]),
            Text(restaurant.title),
            Text("${restaurant.rating}"),
            const SizedBox(
              height: 16,
            ),
            Text(restaurant.deskripsi,textAlign: TextAlign.center,),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              }, 
              child: const Text("back")
              )            
          ],
        )),
    );
  }
}