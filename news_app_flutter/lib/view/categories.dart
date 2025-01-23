import 'package:flutter/material.dart';


// ignore: must_be_immutable
class Categories extends StatefulWidget {
  Map categoryData;
   Categories({super.key,required this.categoryData });

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 30,
       backgroundColor: const Color.fromARGB(255, 180, 224, 255),
       automaticallyImplyLeading: false,
      ),

      body:ListView.builder(
              shrinkWrap: true,
              
              itemCount:widget.categoryData["results"]
                  .length, //GetNews.widget.categoryData["results"].length,,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 160),
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.of(context).push(MaterialPageRoute(
                        //     builder: (context) => WebView(index: index)));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      const Color.fromARGB(255, 203, 202, 202),
                                  offset: Offset(4, 4),
                                  blurRadius: 4),
                            ]),
                        child: Row(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Visibility(
                                visible: (widget.categoryData["results"][index]
                                            ["image_url"] !=
                                        null)
                                    ? true
                                    : false,
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Container(
                                    height: 130,
                                    width: 130,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Image.network(
                                      widget.categoryData["results"][index]["image_url"]
                                          .toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Visibility(
                                visible: (widget.categoryData["results"][index]["title"] ==
                                        null)
                                    ? false
                                    : true,
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                    widget.categoryData["results"][index]["title"],
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}