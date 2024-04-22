import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:caffe_latte/ui/component/themes.dart';
import 'package:caffe_latte/data/model/model_restaurant.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widget/widget_favorite.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail_page';
  final Restaurant restaurant;

  const DetailPage({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name,
        style: GoogleFonts.merriweather(
        textStyle: TextStyle(color: Colors.brown, fontSize: 21, fontWeight: FontWeight.normal, ),
        ),
        ),
        backgroundColor: primaryColor,

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Column(
                children: [
                  Hero(
                    tag: restaurant.pictureId,
                    child: Image.network(
                      restaurant.pictureId,
                      height: MediaQuery.of(context).size.width * 0.5,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Container(
                    color: secondaryColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                restaurant.name,
                                style: GoogleFonts.merriweather(
                                  textStyle: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.normal, ),
                                )
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 8),
                                  RatingBar.builder(
                                    initialRating: restaurant.rating,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemCount: 5,
                                    itemSize: 20,
                                    itemBuilder: (context, _) => Icon(
                                      Icons.star,
                                      color: Colors.white,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                  ButtonFavorite(),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_pin,
                              color: Colors.white,
                              size: 18,),
                              Padding(
                                padding: const EdgeInsets.only(left: 4.0),
                                child: Text(
                                  restaurant.city,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16,)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(8.0)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 20),
                      child: Text(
                        'Description',
                        style: GoogleFonts.dancingScript(
                          textStyle: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.normal, ),
                        ),
                      ),
                    ),
                    SizedBox(height: 6,),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                      child: Text(
                        restaurant.description,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Container(
              decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(8.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      'Foods',
                      style: GoogleFonts.dancingScript(
                        textStyle: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.normal, ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: restaurant.menus.foods.map((food) =>
                            Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              color: primaryColor,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
                                    child: Image.asset(
                                      food.image_food,
                                      height: 100,
                                      width: 150,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        food.name,
                                        style: TextStyle(color: Colors.brown),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ).toList(),
                      ),
                    ),
                  ),


                  SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Text(
                      'Drinks',
                      style: GoogleFonts.dancingScript(
                        textStyle: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.normal, ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: restaurant.menus.drinks.map((food) =>
                            Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              color: primaryColor,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
                                    child: Image.asset(
                                      food.image_drinks,
                                      height: 100,
                                      width: 150,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        food.name,
                                        style: TextStyle(color: Colors.brown),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                ],
              ),
            ),
            SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}
