import 'package:flutter/material.dart';
import 'package:caffe_latte/ui/component/themes.dart';
import 'package:caffe_latte/data/model/model_restaurant.dart';
import 'package:google_fonts/google_fonts.dart';
import 'detail_page.dart';
import 'package:flutter/services.dart' show rootBundle;

class SearchPage extends StatefulWidget {
  static const String routeName = '/search_page';

  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late List<Restaurant> allRestaurants;
  List<Restaurant> searchResults = [];
  String? query;

  @override
  void initState() {
    super.initState();
    getAllRestaurants().then((restaurants) {
      setState(() {
        allRestaurants = restaurants;
        searchResults.addAll(allRestaurants);
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Pencarian',
            style: GoogleFonts.merriweather(
            textStyle: TextStyle(color: Colors.brown),
      ),
        ),
        backgroundColor: primaryColor,
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(
                  color: Colors.brown,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: TextField(
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.search,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(16),
                border: InputBorder.none,
                hintText: 'Cari restoran',
                suffixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
              onSubmitted: (value) {
                _search(value);
              },
            ),
          ),
          Expanded(
            child: FutureBuilder<String>(
              future: DefaultAssetBundle.of(context).loadString(
                  'assets/local_restaurant.json'),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  try {
                    localRestaurantFromJson(
                        snapshot.data!);
                    return ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        return content(context, searchResults[index]);
                      },
                    );
                  } catch (e) {
                    return Center(
                      child: Text('Error: ${e.toString()}'),
                    );
                  }
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error.toString()}'),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget content(BuildContext context, Restaurant restaurant) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.pushNamed(context, DetailPage.routeName, arguments: restaurant);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: Stack(
            children: [
              Image.network(
                restaurant.pictureId,
                height: MediaQuery.of(context).size.width * 0.5,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitWidth,
              ),
              Container(
                height: MediaQuery.of(context).size.width * 0.5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0x80000000),
                      Color(0x80000000),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 8.0,
                right: 8.0,
                child: Container(
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      bottomRight: Radius.circular(8.0),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 16.0,
                      ),
                      SizedBox(width: 4.0),
                      Text(
                        restaurant.rating.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        restaurant.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                      child: RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Icon(
                                Icons.location_pin,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                            TextSpan(
                              text: restaurant.city,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _search(String query) {
    setState(() {
      searchResults.clear();
      if (query.isEmpty) {
        searchResults.addAll(allRestaurants);
      } else {
        searchResults.addAll(allRestaurants.where((restaurant) =>
            restaurant.name.toLowerCase().contains(query.toLowerCase())));
      }
    });

    if (searchResults.isEmpty) {
      return [
        Container(
          padding: EdgeInsets.all(16.0),
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/profile_farhan.png',
                width: 100,
                height: 100,
              ),
              SizedBox(height: 16.0),
              Text(
                'Oopss... Pencarian tidak ditemukan',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ];
    }
    return searchResults.map((restaurant) => content(context, restaurant)).toList();
  }

  Future<List<Restaurant>> getAllRestaurants() async {
    String jsonRestaurantData = await rootBundle.loadString(
        'assets/local_restaurant.json');

    LocalRestaurant localRestaurant = localRestaurantFromJson(
        jsonRestaurantData);

    return localRestaurant.restaurants;
  }
}
