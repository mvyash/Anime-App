import 'package:flutter/material.dart';
import 'package:tamasha/services/animeServices.dart';
import 'package:tamasha/ui/widgets/appBar.dart';
import 'package:tamasha/ui/widgets/banner.dart' as banner;

class Category extends StatefulWidget {
  const Category({super.key});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<String> categoryButtons = [
    "Drama",
    "Action",
    "Adventure",
    "Comedy",
    "Fantasy",
  ];

  String pathC = "drama";
  bool filterC = true;

  String selectedCategory = "drama";

  late Future<List> animesCategory;

  List<String> navigateButtons = ["First", "Prev", "Next", "Last"];

  List<int> offsetValues = [1, 2, 3, 4];

  @override
  void initState() {
    animesCategory = getDataByCategory(20, 0, pathC);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Appbar(searchIconVisibility: true, backIconVisibility: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 150, right: 150, top: 30, bottom: 10),
          child: Column(
            spacing: 30,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 15,
                children: categoryButtons
                    .map(
                      (category) => Container(
                        height: 50,
                        width: 120,
                        decoration: BoxDecoration(
                          color: selectedCategory == category.toLowerCase()
                              ? Colors.black
                              : const Color.fromARGB(34, 158, 158, 158),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                        ),
                        child: TextButton(
                          onPressed: () {
                            pathC = category.toLowerCase();
                            filterC = true;
                            selectedCategory = category.toLowerCase();
                            animesCategory = getDataByCategory(20, 0, pathC);
                            setState(() {});
                          },
                          child: Text(
                            category,
                            style: TextStyle(
                              color: selectedCategory == category.toLowerCase()
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),

              FutureBuilder(
                future: animesCategory,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }
                  if (snapshot.hasData) {
                    List animesInstances = snapshot.data!;
                    for (int i = 0; i < 4; i++) {
                      offsetValues[i] = animesInstances[1][i];

                      //print(offsetValues[i]);
                    }
                    animesInstances = animesInstances[0];
                    int instancesCount = animesInstances.length;

                    return Column(
                      spacing: 30,
                      children: [
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width,
                          height: MediaQuery.sizeOf(context).height,
                          child: GridView.count(
                            crossAxisCount: 5,
                            mainAxisSpacing: 60,
                            childAspectRatio: 0.6,
                            children: List.generate(instancesCount, (index) {
                              return banner.Banner(
                                imageUrl:
                                    animesInstances[index]
                                        .posterImage["original"] ??
                                    animesInstances[index]
                                        .coverImage["original"] ??
                                    animesInstances[index]
                                        .posterImage[animesInstances[index]
                                        .posterImage
                                        .toList()
                                        .first] ??
                                    animesInstances[index]
                                        .coverImage[animesInstances[index]
                                        .coverImage
                                        .toList()
                                        .first] ??
                                    "assets/images/img404.png",
                                name: animesInstances[index].canonicalTitle,
                                // sNo: (rowIndex[sNo] + 1).toString(),
                                sNo: "0",
                                type: animesInstances[index].ageRatingGuide,
                                ratings: animesInstances[index].averageRating,
                                animeInstance: animesInstances[index],
                              );
                            }),
                          ),
                        ),

                        Row(
                          spacing: 20,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: navigateButtons
                              .map(
                                (button) => TextButton(
                                  onPressed: () {
                                    if (button == "First" &&
                                        offsetValues[0] != -1) {
                                      animesCategory = getDataByCategory(
                                        20,
                                        offsetValues[0],
                                        pathC,
                                      );
                                    }

                                    if (button == "Prev" &&
                                        offsetValues[1] != -1) {
                                      animesCategory = getDataByCategory(
                                        20,
                                        offsetValues[1],
                                        pathC,
                                      );
                                    }

                                    if (button == "Next" &&
                                        offsetValues[2] != -1) {
                                      animesCategory = getDataByCategory(
                                        20,
                                        offsetValues[2],
                                        pathC,
                                      );
                                    }

                                    if (button == "Last" &&
                                        offsetValues[3] != -1) {
                                      animesCategory = getDataByCategory(
                                        20,
                                        offsetValues[3],
                                        pathC,
                                      );
                                    }
                                    setState(() {});
                                  },
                                  child: Text(
                                    button,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
