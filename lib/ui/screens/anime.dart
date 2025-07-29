import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tamasha/services/animeServices.dart';
import 'package:tamasha/ui/widgets/appBar.dart';
import 'package:tamasha/models/animeModel.dart' as model;

class Anime extends StatelessWidget {
  Anime({super.key});

  @override
  Widget build(BuildContext context) {
    late Future animeData = getDataById(
      GoRouter.of(context).routeInformationProvider.value.uri.toString(),
    );
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
          child: FutureBuilder(
            future: animeData,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }

              if (snapshot.hasData) {
                model.Anime anime = snapshot.data!;
                return Column(
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
                                anime.posterImage["original"],
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
                                  Text(
                                    "Title: ",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    anime.canonicalTitle,
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
                                    anime.createdAt,
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
                                    anime.episodeCount.toString(),
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
                                    anime.ageRating,
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
                                    anime.startDate,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "End Date: ",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    anime.endDate,
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
                                    anime.ageRating,
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
                                    anime.ageRatingGuide,
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "NSFW: ",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Text(
                                    anime.nsfw ? "True" : "False",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    Text(anime.synopsis, style: TextStyle(fontSize: 20)),
                  ],
                );
              }

              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
