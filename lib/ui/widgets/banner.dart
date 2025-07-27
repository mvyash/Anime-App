import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tamasha/ui/screens/anime.dart';
import 'package:tamasha/models/animeModel.dart' as model;

late model.Anime animeInfo;

class Banner extends StatelessWidget {
  late String imageUrl;
  late String name;
  late String sNo;
  late String type;
  late String ratings;
  late model.Anime animeInstance;

  Banner({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.sNo,
    required this.type,
    required this.ratings,
    required this.animeInstance,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: FractionalOffset(0.01, 0.85),
      children: [
        Column(
          spacing: 30,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(imageUrl),
                ),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              height: 300,
              width: 230,
            ),

            SizedBox(
              width: 230,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      overlayColor: Colors.transparent,
                    ),
                    onPressed: () {
                      animeInfo = animeInstance;
                      //Navigator.pushNamed(context, "/anime");
                      GoRouter.of(context).push("/anime");
                    },
                    child: Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      name,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),

                  Text(type, style: TextStyle(color: Colors.grey)),

                  Text(
                    "Avg Ratings: $ratings",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),

        Visibility(
          visible: sNo == "0" ? false : true,
          child: Stack(
            children: [
              Text(
                sNo,
                style: TextStyle(
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 8
                    ..color = Colors.white,
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Text(
                sNo,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 80,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
