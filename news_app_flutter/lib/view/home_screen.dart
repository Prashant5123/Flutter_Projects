import 'dart:convert';
import 'dart:developer';

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:news_app_flutter/controller/getData.dart';
import 'package:news_app_flutter/controller/loader.dart';
import 'package:news_app_flutter/controller/local_storage.dart';
import 'package:news_app_flutter/model/inherited_state.dart';
import 'package:news_app_flutter/view/categories.dart';

import 'package:news_app_flutter/view/profile_screen.dart';
import 'package:news_app_flutter/view/web_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'splash_screen.dart';
 int articleReadHome = LocalStorage.articlesRead!;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool imageUrl = true;
  bool _isLoading = false;
  Map categoryData = {};
  String category = "";
  int currentIndexBottomNavigation = 0;
  String? webData;
  int? selectedCategoryIndex;
 

  @override
  void initState() {
    super.initState();
  }

  // Map categoryImgUrl = {
  //   "Business": "assets/jpg/Business.jpg",
  //   "crime": "assets/jpg/crime.jpg",
  //   "sports": "assets/jpg/sports.jpg",
  //   "education": "assets/jpg/education.jpg",
  //   "entertainment": "assets/jpg/entertainment.jpg",
  //   "environment": "assets/jpg/environment.jpg",
  //   "food": "assets/jpg/food.jpg",
  //   "health": "assets/jpg/health.jpg",
  //   "lifestyle": "assets/jpg/lifestyle.jpg",
  //   "politics": "assets/jpg/politics.jpg",
  //   "science": "assets/jpg/science.png",
  //   "technology": "assets/jpg/technology.jpg",
  //   "tourism": "assets/jpg/tourism.jpg",
  //   "world": "assets/jpg/world.jpg"
  // };

  List categories = [
    "business",
    "sports",
    "general",
    "entertainment",
    "health",
    "science",
    "technology",
  ];
  final controller = PageController();

  bool _isSearching = false;

  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 252, 251, 249),
      appBar: AppBar(
        shadowColor: Colors.grey,
        backgroundColor: Colors.black,
        title: (_isSearching)
            ? SizedBox(
                height: 30,
                child: TextField(
                  controller: _searchController,
                  onSubmitted: (value) async {
                    setState(() {
                      _isLoading = true;
                    });
                    String search =
                        _searchController.text.trim().toString().toLowerCase();
                    if (_searchController.text.trim().isNotEmpty) {
                      log("---");
                      newsData = await Getdata.searchData(search);
                    }

                    setState(() {
                      _isLoading = false;
                    });
                  },
                  // onEditingComplete: () async{
                  //   setState(() {
                  //     _isLoading=true;
                  //   });
                  //   String search=_searchController.text.trim().toString().toLowerCase();
                  //   if(_searchController.text.trim().isNotEmpty){
                  //     newsData=await Getdata.searchData(search);
                  //   }

                  //   setState(() {
                  //     _isLoading=false;
                  //   });
                  //   log("---");
                  // },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white))),
                ),
              )
            : Text(
                "World News",
                style: GoogleFonts.sahitya(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
        centerTitle: true,
        leading: Image.asset("assets/image.png", color: Colors.white),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: IconButton(
              icon: Icon(_isSearching ? Icons.close : Icons.search,
                  color: Colors.white),
              onPressed: () async {
                setState(() {
                  _isSearching = !_isSearching;
                  if (!_isSearching) {
                    _searchController.clear();
                  }
                });
                if (!_isSearching) {
                  newsData = await Getdata.homeData();
                }
                setState(() {});
              },
            ),
          )
        ],
      ),
      body: (newsData["totalResults"] == 0)
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error,
                    size: 45,
                    color: Colors.red,
                  ),
                  Text(
                    "Data not found",
                    style: GoogleFonts.sahitya(fontSize: 30),
                  ),
                ],
              ),
            )
          : Stack(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: 20,
                      child: ListView.builder(
                          itemCount: categories.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                GestureDetector(
                                  onTap: () async {
                                    selectedCategoryIndex = index;
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    category = categories[index];
                                    newsData =
                                        await Getdata.categoryData(category);

                                    setState(() {
                                      _isLoading = false;
                                    });
                                  },
                                  child: Text(
                                    categories[index].toString().toUpperCase(),
                                    style: TextStyle(
                                        color: (selectedCategoryIndex == index)
                                            ? Colors.blue
                                            : Colors.black),
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                if (index < categories.length - 1) Text("/"),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                            );
                          }),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: newsData["articles"].length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: GestureDetector(
                            onTap: () {

                              articleReadHome++;

                            LocalStorage.storesSessionData(1, articleReadHome);

                             

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => WebView(index: index)));
                            },
                            child: Container(
                              // decoration: BoxDecoration(
                              //     color: Colors.white,
                              //     borderRadius: BorderRadius.circular(8),
                              //     boxShadow: [
                              //       BoxShadow(
                              //           color:
                              //               const Color.fromARGB(255, 203, 202, 202),
                              //           offset: Offset(4, 4),
                              //           blurRadius: 4),
                              //     ]),
                              child: Column(
                                children: [
                                  Visibility(
                                    visible: (newsData["articles"][index]
                                                ["title"] !=
                                            null)
                                        ? true
                                        : false,
                                    child: Text(
                                      '"${newsData["articles"][index]["title"]}"',
                                      style: GoogleFonts.timmana(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Visibility(
                                    visible: (newsData["articles"][index]
                                                ["description"] !=
                                            null)
                                        ? true
                                        : false,
                                    child: Text(
                                      "${newsData["articles"][index]["description"]}",
                                      style: GoogleFonts.sahitya(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 150,
                                        child: Text(
                                          "${newsData["articles"][index]["source"]["name"]}",
                                          style: GoogleFonts.sahitya(
                                              color: Colors.grey),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Container(
                                        width: 150,
                                        child: Text(
                                          "  ${newsData["articles"][index]["publishedAt"]}",
                                          style: GoogleFonts.sahitya(
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Visibility(
                                    visible: (newsData["articles"][index]
                                                ["urlToImage"] !=
                                            null)
                                        ? true
                                        : false,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        height: 200,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Image.network(
                                          newsData["articles"][index]
                                                  ["urlToImage"]
                                              .toString(),
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Container(
                                              color: Colors.grey[200],
                                              child: Icon(
                                                Icons.broken_image,
                                                color: Colors.grey,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Divider()
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
              if (_isLoading) Loader.circularLoading()
            ]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 252, 251, 249),
          currentIndex: currentIndexBottomNavigation,
          onTap: (index) async {
            if (index == 2) {
              selectedCategoryIndex = -1;
              currentIndexBottomNavigation=0;
           
               setState(() {
                       
                  });
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ProfileScreen()));
                 
            } else if (index == 0) {
              selectedCategoryIndex = -1;
              currentIndexBottomNavigation=0;
              setState(() {
                
              });
              
              newsData = await Getdata.homeData();
              setState(() {
                
              });
            }else{
              selectedCategoryIndex = -1;
              currentIndexBottomNavigation=1;
              setState(() {
                
              });
              
              newsData = await Getdata.searchData("trending");
              setState(() {
                
              });
            }
            // setState(() {
            //   currentIndexBottomNavigation = index;
            // });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.trending_up_outlined),
              label: 'Trending',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ]),
    );
  }
}
