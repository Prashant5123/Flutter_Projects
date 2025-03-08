import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // Track selected box index
  CarouselSliderController _carouselController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                height: 64,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(247, 147, 26, 1),
                ),
              ),
              SizedBox(
                height: 26,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  children: [
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: Image.asset("assets/png/profile.png"),
                    ),
                    Text(
                      "John Doe",
                      style: GoogleFonts.robotoMono(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                    Spacer(),
                    SizedBox(
                      height: 25,
                      width: 25,
                      child: Image.asset("assets/png/star-medal.png"),
                    ),
                    Text(
                      "Level 01",
                      style: GoogleFonts.robotoMono(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: Image.asset("assets/png/wallet.png"),
                    ),
                    Text(
                      "\$25.00",
                      style: GoogleFonts.robotoMono(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 62,
              ),
              Text(
                "Claim your Daily Reward",
                style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color.fromRGBO(150, 82, 0, 1)),
              ),
              SizedBox(
                height: 120,
                child: RotatedBox(
                  quarterTurns: 1,
                  child: ListWheelScrollView(
                    itemExtent: 62,
                    children: [
                      Container(
                        height: 62,
                        width: 62,
                        child: Center(child: Text("22")),
                        decoration:
                            BoxDecoration(color: Colors.deepOrangeAccent),
                      ),
                      Container(
                        height: 62,
                        width: 62,
                        child: Center(child: Text("22")),
                        decoration:
                            BoxDecoration(color: Colors.deepOrangeAccent),
                      ),
                      Container(
                        height: 62,
                        width: 62,
                        child: Center(child: Text("22")),
                        decoration:
                            BoxDecoration(color: Colors.deepOrangeAccent),
                      ),
                      Container(
                        height: 62,
                        width: 62,
                        child: Center(child: Text("22")),
                        decoration:
                            BoxDecoration(color: Colors.deepOrangeAccent),
                      ),
                      Container(
                        height: 62,
                        width: 62,
                        child: Center(child: Text("22")),
                        decoration:
                            BoxDecoration(color: Colors.deepOrangeAccent),
                      ),
                    
                    ],
                  ),
                ),
              ),

                Text(
                        "Selected: Box ${_currentIndex + 1}",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20),
                      CarouselSlider.builder(
                        carouselController: _carouselController,
                        itemCount: 10, // Number of boxes
                        options: CarouselOptions(
                          height: 150,
                          enlargeCenterPage:
                              true, // Makes the center box bigger
                          viewportFraction: 1/7, // Ensures 7 boxes are visible
                          enableInfiniteScroll: true,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                        itemBuilder: (context, index, realIndex) {
                          bool isCenter = index == _currentIndex;
                          double scale = isCenter
                              ? 1.2
                              : 0.8; // Scale effect for center box

                          return Transform.scale(
                            scale: scale,
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              width: 80,
                              height: scale * 80 + 20, // Dynamic height
                              margin: EdgeInsets.symmetric(horizontal: 5),
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26, blurRadius: 5)
                                ],
                                border: isCenter
                                    ? Border.all(
                                        color: Colors.orange.shade900, width: 2)
                                    : null,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                "\$${(index + 1) * 2} AD",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: scale * 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
            ],
          ),
        ),
      ),
    );
  }
}
