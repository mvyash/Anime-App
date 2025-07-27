import 'package:flutter/material.dart';
import 'package:tamasha/services/animeServices.dart';
import 'package:tamasha/ui/widgets/appBar.dart';
import 'package:tamasha/ui/widgets/banner.dart' as banner;

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final formKey = GlobalKey<FormState>();

  ScrollController scroll1 = ScrollController();
  ScrollController scroll2 = ScrollController();
  ScrollController scroll3 = ScrollController();

  bool scrollRight1 = true;
  bool scrollRight2 = true;
  bool scrollRight3 = true;

  String path = "/api/edge/trending/anime";
  bool filter = false;

  String pathC = "drama";
  bool filterC = true;

  bool isTrending = true;
  String selectedCategory = "drama";

  late Future<List> animes, animesCategory, latestAnimes;

  List<String> categoryButtons = [
    "Drama",
    "Action",
    "Adventure",
    "Comedy",
    "Fantasy",
  ];

  List<int> animeSNo = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  @override
  void initState() {
    animes = getData(20, 0, path, filter);
    animesCategory = getDataByCategory(20, 0, pathC);
    latestAnimes = getSortedData(20, 0, "-startDate");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: false,
      appBar: Appbar(searchIconVisibility: true, backIconVisibility: false),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 150,
            right: 150,
            top: 30,
            bottom: 30,
          ),
          child: Column(
            spacing: 60,
            children: [
              Stack(
                alignment: scrollRight1
                    ? FractionalOffset.centerRight
                    : FractionalOffset.centerLeft,
                children: [
                  Column(
                    spacing: 20,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Trending & Popular Series",
                        style: TextStyle(fontSize: 30),
                      ),

                      Row(
                        spacing: 15,
                        children: [
                          Container(
                            height: 50,
                            width: 120,
                            decoration: BoxDecoration(
                              color: isTrending
                                  ? Colors.black
                                  : const Color.fromARGB(34, 158, 158, 158),
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                path = "/api/edge/trending/anime";
                                filter = false;
                                isTrending = true;
                                animes = getData(20, 0, path, filter);

                                if (!scrollRight1) {
                                  scroll1.animateTo(
                                    0,
                                    duration: Duration(microseconds: 1),
                                    curve: Curves.easeIn,
                                  );
                                  scrollRight1 = !scrollRight1;
                                }

                                setState(() {});
                              },
                              child: Text(
                                "Trending",
                                style: TextStyle(
                                  color: isTrending
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),

                          Container(
                            height: 50,
                            width: 120,
                            decoration: BoxDecoration(
                              color: isTrending
                                  ? const Color.fromARGB(34, 158, 158, 158)
                                  : Colors.black,
                              borderRadius: BorderRadius.all(
                                Radius.circular(50),
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                path = "popular";
                                filter = true;
                                isTrending = false;
                                animes = getData(20, 0, path, filter);

                                if (!scrollRight1) {
                                  scroll1.animateTo(
                                    0,
                                    duration: Duration(microseconds: 1),
                                    curve: Curves.easeIn,
                                  );
                                  scrollRight1 = !scrollRight1;
                                }

                                setState(() {});
                              },
                              child: Text(
                                "Popular",
                                style: TextStyle(
                                  color: isTrending
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      FutureBuilder(
                        future: animes,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(snapshot.error.toString()),
                            );
                          }
                          if (snapshot.hasData) {
                            List animesInstances = snapshot.data!;
                            return SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),
                              controller: scroll1,
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 20,
                                children: animeSNo
                                    .map(
                                      (sNo) => banner.Banner(
                                        imageUrl:
                                            animesInstances[sNo]
                                                .posterImage["original"] ??
                                            animesInstances[sNo]
                                                .coverImage["original"],
                                        name:
                                            animesInstances[sNo].canonicalTitle,
                                        sNo: (sNo + 1).toString(),
                                        type:
                                            animesInstances[sNo].ageRatingGuide,
                                        ratings:
                                            animesInstances[sNo].averageRating,
                                        animeInstance: animesInstances[sNo],
                                      ),
                                    )
                                    .toList(),
                              ),
                            );
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                    ],
                  ),

                  Visibility(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                        onPressed: () {
                          if (scrollRight1) {
                            scroll1.animateTo(
                              1300,
                              duration: Duration(seconds: 1),
                              curve: Curves.easeIn,
                            );
                          } else {
                            scroll1.animateTo(
                              0,
                              duration: Duration(seconds: 1),
                              curve: Curves.easeIn,
                            );
                          }
                          scrollRight1 = !scrollRight1;
                          setState(() {});
                        },
                        icon: Icon(
                          scrollRight1
                              ? Icons.keyboard_arrow_right
                              : Icons.keyboard_arrow_left,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Stack(
                alignment: scrollRight2
                    ? FractionalOffset.centerRight
                    : FractionalOffset.centerLeft,
                children: [
                  Column(
                    spacing: 20,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Popular Series by Category",
                        style: TextStyle(fontSize: 30),
                      ),

                      Row(
                        spacing: 15,
                        children: categoryButtons
                            .map(
                              (category) => Container(
                                height: 50,
                                width: 120,
                                decoration: BoxDecoration(
                                  color:
                                      selectedCategory == category.toLowerCase()
                                      ? Colors.black
                                      : const Color.fromARGB(34, 158, 158, 158),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(50),
                                  ),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    pathC = category.toLowerCase();
                                    filterC = true;
                                    selectedCategory = category.toLowerCase();
                                    animesCategory = getDataByCategory(
                                      20,
                                      0,
                                      pathC,
                                    );

                                    if (!scrollRight2) {
                                      scroll2.animateTo(
                                        0,
                                        duration: Duration(microseconds: 1),
                                        curve: Curves.easeIn,
                                      );
                                      scrollRight2 = !scrollRight2;
                                    }

                                    setState(() {});
                                  },
                                  child: Text(
                                    category,
                                    style: TextStyle(
                                      color:
                                          selectedCategory ==
                                              category.toLowerCase()
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
                            return Center(
                              child: Text(snapshot.error.toString()),
                            );
                          }
                          if (snapshot.hasData) {
                            List animesInstances = snapshot.data!;
                            animesInstances = animesInstances[0];
                            return SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),
                              controller: scroll2,
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 20,
                                children: animeSNo
                                    .map(
                                      (sNo) => banner.Banner(
                                        imageUrl:
                                            animesInstances[sNo]
                                                .posterImage["original"] ??
                                            animesInstances[sNo]
                                                .coverImage["original"],
                                        name:
                                            animesInstances[sNo].canonicalTitle,
                                        sNo: (sNo + 1).toString(),
                                        type:
                                            animesInstances[sNo].ageRatingGuide,
                                        ratings:
                                            animesInstances[sNo].averageRating,
                                        animeInstance: animesInstances[sNo],
                                      ),
                                    )
                                    .toList(),
                              ),
                            );
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                    ],
                  ),

                  Visibility(
                    //visible: scrollRight,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                        onPressed: () {
                          if (scrollRight2) {
                            scroll2.animateTo(
                              1300,
                              duration: Duration(seconds: 1),
                              curve: Curves.easeIn,
                            );
                          } else {
                            scroll2.animateTo(
                              0,
                              duration: Duration(seconds: 1),
                              curve: Curves.easeIn,
                            );
                          }
                          scrollRight2 = !scrollRight2;
                          setState(() {});
                        },
                        icon: Icon(
                          scrollRight2
                              ? Icons.keyboard_arrow_right
                              : Icons.keyboard_arrow_left,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              Stack(
                alignment: scrollRight3
                    ? FractionalOffset.centerRight
                    : FractionalOffset.centerLeft,
                children: [
                  Column(
                    spacing: 20,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Newly Released Originals",
                        style: TextStyle(fontSize: 30),
                      ),

                      FutureBuilder(
                        future: latestAnimes,
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(snapshot.error.toString()),
                            );
                          }
                          if (snapshot.hasData) {
                            List animesInstances = snapshot.data!;
                            animesInstances = animesInstances[0];
                            return SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),
                              controller: scroll3,
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 20,
                                children: animeSNo
                                    .map(
                                      (sNo) => banner.Banner(
                                        imageUrl:
                                            animesInstances[sNo]
                                                .posterImage["original"] ??
                                            animesInstances[sNo]
                                                .coverImage["original"],
                                        name:
                                            animesInstances[sNo].canonicalTitle,
                                        sNo: (sNo + 1).toString(),
                                        type:
                                            animesInstances[sNo].ageRatingGuide,
                                        ratings:
                                            animesInstances[sNo].averageRating,
                                        animeInstance: animesInstances[sNo],
                                      ),
                                    )
                                    .toList(),
                              ),
                            );
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                    ],
                  ),

                  Visibility(
                    //visible: scrollRight,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                        onPressed: () {
                          if (scrollRight3) {
                            scroll3.animateTo(
                              1300,
                              duration: Duration(seconds: 1),
                              curve: Curves.easeIn,
                            );
                          } else {
                            scroll3.animateTo(
                              0,
                              duration: Duration(seconds: 1),
                              curve: Curves.easeIn,
                            );
                          }
                          scrollRight3 = !scrollRight3;
                          setState(() {});
                        },
                        icon: Icon(
                          scrollRight3
                              ? Icons.keyboard_arrow_right
                              : Icons.keyboard_arrow_left,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
