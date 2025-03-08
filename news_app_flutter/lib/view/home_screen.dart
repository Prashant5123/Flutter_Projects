

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:news_app_flutter/controller/getData.dart';
import 'package:news_app_flutter/controller/loader.dart';
import 'package:news_app_flutter/controller/local_storage.dart';


import 'package:news_app_flutter/view/profile_screen.dart';
import 'package:news_app_flutter/view/web_view.dart';
import 'package:provider/provider.dart';


import '../model/news.dart';

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



  List<String> categories = [
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
                      
                      Map newsData = await Getdata.searchData(search);
                      Provider.of<News>(context,listen: false).changeNewsData(newsData) ;
                    }

                    setState(() {
                      _isLoading = false;
                    });
                  },
                
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
                  Map newsData = await Getdata.homeData();
                  Provider.of<News>(context,listen: false).changeNewsData(newsData) ;
                }
                setState(() {});
              },
            ),
          )
        ],
      ),
      body: (Provider.of<News>(context).newsData["totalResults"] == 0)
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

DropdownButton<String>(
      //value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
         // dropdownValue = value!;
        });
      },
      items: categories.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ),
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
                                    Map newsData =
                                        await Getdata.categoryData(category);

                                        Provider.of<News>(context,listen: false).changeNewsData(newsData) ;

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
                      itemCount: Provider.of<News>(context).newsData["articles"].length,
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
                                    visible: (Provider.of<News>(context).newsData["articles"][index]
                                                ["title"] !=
                                            null)
                                        ? true
                                        : false,
                                    child: Text(
                                      '"${Provider.of<News>(context).newsData["articles"][index]["title"]}"',
                                      style: GoogleFonts.timmana(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Visibility(
                                    visible: (Provider.of<News>(context).newsData["articles"][index]
                                                ["description"] !=
                                            null)
                                        ? true
                                        : false,
                                    child: Text(
                                      "${Provider.of<News>(context).newsData["articles"][index]["description"]}",
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
                                          "${Provider.of<News>(context).newsData["articles"][index]["source"]["name"]}",
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
                                          "  ${Provider.of<News>(context).newsData["articles"][index]["publishedAt"]}",
                                          style: GoogleFonts.sahitya(
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Visibility(
                                    visible: (Provider.of<News>(context).newsData["articles"][index]
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
                                        Provider.of<News>(context).newsData["articles"][index]
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
              
              Map newsData = await Getdata.homeData();
              Provider.of<News>(context,listen: false).changeNewsData(newsData) ;
              setState(() {
                
              });
            }else{
              selectedCategoryIndex = -1;
              currentIndexBottomNavigation=1;
              setState(() {
                
              });
              
              Map newsData = await Getdata.searchData("trending");
              Provider.of<News>(context,listen: false).changeNewsData(newsData) ;
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
