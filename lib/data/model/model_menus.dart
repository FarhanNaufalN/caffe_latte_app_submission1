import 'package:caffe_latte/data/model/model_restaurant.dart';

class LocalRestaurant {
  LocalRestaurant({
    required this.restaurants,
  });

  List<Restaurant> restaurants;

  factory LocalRestaurant.fromJson(Map<String, dynamic> json) =>
      LocalRestaurant(
        restaurants: List<Restaurant>.from(
            json["restaurants"].map((x) => Restaurant.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
  };
}

class Menus {
  Menus menus;

  Menus({
    required this.foods,
    required this.drinks,
    required this.menus,
  });

  List<Drink> foods;
  List<Drink> drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
    foods: List<Drink>.from(json["foods"].map((x) => Drink.fromJson(x))),
    drinks: List<Drink>.from(json["drinks"].map((x) => Drink.fromJson(x))),
    menus: Menus.fromJson(json["menus"]),
  );

  Map<String, dynamic> toJson() => {
    "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
    "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
    "menus": menus.toJson(),
  };
}

class Drink {
  Drink({
    required this.name,
  });

  String name;

  factory Drink.fromJson(Map<String, dynamic> json) => Drink(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}
