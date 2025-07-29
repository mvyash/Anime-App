import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget {
  bool searchIconVisibility = true;
  bool backIconVisibility = false;

  Appbar({
    super.key,
    required this.searchIconVisibility,
    required this.backIconVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      toolbarHeight: 120,
      shape: Border(
        bottom: BorderSide(color: const Color.fromARGB(158, 158, 158, 158)),
      ),
      actionsPadding: EdgeInsets.only(right: 30),
      backgroundColor: Colors.white,
      title: Row(
        spacing: 30,
        children: [
          Visibility(
            visible: backIconVisibility,
            child: IconButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              icon: Icon(Icons.arrow_back, size: 25),
            ),
          ),
          Text(
            "TAMASHA",
            style: TextStyle(
              fontFamily: "ShadowsIntoLight",
              fontWeight: FontWeight.w900,
              fontSize: 30,
            ),
          ),

          TextButton(
            style: TextButton.styleFrom(overlayColor: Colors.transparent),
            onPressed: () {
              GoRouter.of(context).push("/category");
            },
            child: Text(
              "CATEGORIES",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),

          TextButton(
            style: TextButton.styleFrom(overlayColor: Colors.transparent),
            onPressed: () {
              GoRouter.of(context).push("/rankings");
            },
            child: Text(
              "RANKINGS",
              style: TextStyle(color: Colors.black, fontSize: 20),
            ),
          ),
        ],
      ),

      actions: [
        Row(
          spacing: 25,
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(34, 158, 158, 158),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: TextButton(
                onPressed: () {
                  GoRouter.of(context).push("/login");
                },
                child: Text("LOGIN", style: TextStyle(color: Colors.black)),
              ),
            ),

            Visibility(
              visible: searchIconVisibility ? true : false,
              child: IconButton(
                onPressed: () {
                  GoRouter.of(context).push("/search");
                },
                icon: Icon(Icons.search),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(100);
}
