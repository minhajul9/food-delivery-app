// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic>? restaurantData;
  bool isLoading = true;

  // Load restaurant data
  void loadRestaurantData() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(Uri.parse(
        'https://demo-api.devdata.top/api/RestaurantInfo/GetRestaurantInfo'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        restaurantData = data["data"];
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadRestaurantData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 5,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // Image

                      Image(
                        image: NetworkImage(restaurantData!["ProfileImageUrl"]),
                        height: 185,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),

                      // Top icons
                      Positioned(
                        top: 8,
                        left: 8,
                        right: 8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.arrow_back, color: Colors.white),
                            Row(
                              children: [
                                Icon(Icons.favorite_border,
                                    color: Colors.white),
                                SizedBox(width: 8),
                                Icon(Icons.share, color: Colors.white),
                                SizedBox(width: 8),
                                Icon(Icons.more_vert_rounded,
                                    color: Colors.white),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // Details
                      Positioned(
                        top: 170,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height - 160,
                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // info
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // name
                                  Row(
                                    children: [
                                      Text(
                                        restaurantData!["Name"],
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Icon(
                                        Icons.info_outline,
                                        color:
                                            Color.fromARGB(255, 117, 125, 133),
                                        size: 30,
                                      )
                                    ],
                                  ),

                                  //rating
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.star,
                                              color: const Color.fromRGBO(
                                                  245, 142, 7, 1),
                                              size: 25),
                                          SizedBox(width: 4),
                                          Text(
                                            restaurantData!["AverageRating"],
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                          "${restaurantData!["TotalRating"]} Ratings",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 145, 150, 157),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600))
                                    ],
                                  )
                                ],
                              ),

                              SizedBox(height: 15),

                              // delivery info
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        color: Color.fromARGB(255, 161, 4, 91),
                                        size: 18,
                                      ),
                                      Text(
                                        " Delivery ",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 144, 150, 157),
                                            fontSize: 15),
                                      ),
                                      Text(
                                          restaurantData![
                                              'AverageDeliveryTime'],
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 93, 99, 106),
                                              fontSize: 15)),
                                      SizedBox(
                                        width: 5,
                                      ),

                                      // DISTANCE
                                      Transform.rotate(
                                        angle:
                                            0.5, // Rotation angle in radians (e.g., 0.5 radians = ~28.6 degrees)
                                        child: Icon(
                                          Icons.navigation_outlined,
                                          color:
                                              Color.fromARGB(255, 161, 4, 91),
                                          size: 20,
                                        ),
                                      ),

                                      Text(restaurantData!['Distance'],
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 93, 99, 106),
                                              fontSize: 15)),

                                      Text(
                                        " away",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 144, 150, 157),
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Review',
                                        style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 161, 4, 91),
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800),
                                      ))
                                ],
                              ),

                              //
                              Text(
                                restaurantData!["Description"] ?? "",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                ),
                              ),
                              // Add more details or widgets below
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Icon(Icons.delivery_dining),
                                  SizedBox(width: 8),
                                  Text(
                                    "Delivery: ${restaurantData!["DeliveryTime"] ?? "15-25 mins"}",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Icon(Icons.location_on_outlined),
                                  SizedBox(width: 8),
                                  Text(
                                    "Distance: ${restaurantData!["Distance"] ?? "2 km"}",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}
