import 'package:flutter/material.dart';
import 'package:tamasha/ui/widgets/appBar.dart';
import 'package:tamasha/models/animeModel.dart' as model;

class Anime extends StatelessWidget {
  late model.Anime animeInstance;
  Anime({super.key, required this.animeInstance});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Appbar(searchIconVisibility: true, backIconVisibility: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 150,
            right: 150,
            top: 30,
            bottom: 10,
          ),
          child: Column(
            spacing: 50,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.50,
                    child: Expanded(
                      child: Image(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          animeInstance.posterImage["original"],
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Title: ", style: TextStyle(fontSize: 20)),
                            Text(
                              animeInstance.canonicalTitle,
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Created At: ",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              animeInstance.createdAt,
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Episode Count: ",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              animeInstance.episodeCount.toString(),
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Avg Rating: ",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              animeInstance.ageRating,
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Start Date: ",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              animeInstance.startDate,
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("End Date: ", style: TextStyle(fontSize: 20)),
                            Text(
                              animeInstance.endDate,
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Age Rating: ",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              animeInstance.ageRating,
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Age Rating Guide: ",
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              animeInstance.ageRatingGuide,
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("NSFW: ", style: TextStyle(fontSize: 20)),
                            Text(
                              animeInstance.nsfw ? "True" : "False",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Text(animeInstance.synopsis, style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
