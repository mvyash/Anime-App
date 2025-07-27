import 'package:flutter/material.dart';
import 'package:tamasha/services/animeServices.dart';
import 'package:tamasha/ui/widgets/appBar.dart';
import 'package:tamasha/ui/widgets/banner.dart' as banner;

class Ranking extends StatefulWidget {
  const Ranking({super.key});

  @override
  State<Ranking> createState() => _RankingState();
}

class _RankingState extends State<Ranking> {
  late Future<List> animesCategory;

  List<int> offsetValues = [1, 2, 3, 4];

  List<String> navigateButtons = ["First", "Prev", "Next", "Last"];

  @override
  void initState() {
    animesCategory = getSortedData(20, 0, "-averageRating");
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
                                        .coverImage["original"],
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
                                      animesCategory = getSortedData(
                                        20,
                                        offsetValues[0],
                                        "-averageRating",
                                      );
                                    }

                                    if (button == "Prev" &&
                                        offsetValues[1] != -1) {
                                      animesCategory = getSortedData(
                                        20,
                                        offsetValues[1],
                                        "-averageRating",
                                      );
                                    }

                                    if (button == "Next" &&
                                        offsetValues[2] != -1) {
                                      animesCategory = getSortedData(
                                        20,
                                        offsetValues[2],
                                        "-averageRating",
                                      );
                                    }

                                    if (button == "Last" &&
                                        offsetValues[3] != -1) {
                                      animesCategory = getSortedData(
                                        20,
                                        offsetValues[3],
                                        "-averageRating",
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
