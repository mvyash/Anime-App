import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:tamasha/models/animeModel.dart';

Future<List> getData(int limit, int offset, String path, bool filter) async {
  final url;
  if (filter) {
    url = Uri.https("kitsu.io", "/api/edge/anime", {
      "page[limit]": limit.toString(),
      "page[offset]": offset.toString(),
      "filter[text]": path,
    });
  } else {
    url = Uri.https("kitsu.io", path, {
      "page[limit]": limit.toString(),
      "page[offset]": offset.toString(),
    });
  }
  final response = await http.get(
    url,
    headers: {"Content-Type": "application/vnd.api+json"},
  );

  if (response.statusCode != 200) {
    throw ErrorDescription("Unable to reach the server.");
  }

  final body = json.decode(response.body);
  return body["data"].map((anime) => Anime.createInstance(anime)).toList();
}

Future<List> getDataByCategory(int limit, int offset, String path) async {
  var url;

  if (path.isNotEmpty) {
    url = Uri.https("kitsu.io", "/api/edge/anime", {
      "page[limit]": limit.toString(),
      "page[offset]": offset.toString(),
      "filter[text]": path,
    });
  } else {
    url = Uri.https("kitsu.io", "/api/edge/anime", {
      "page[limit]": limit.toString(),
      "page[offset]": offset.toString(),
    });
  }

  final response = await http.get(
    url,
    headers: {"Content-Type": "application/vnd.api+json"},
  );

  if (response.statusCode != 200) {
    throw ErrorDescription("Unable to reach the server.");
  }

  final body = json.decode(response.body);

  Map urls = body["links"];
  List<String> keys = ["first", "prev", "next", "last"];
  String urlValue;
  Uri uriValue;
  Map<String, String> queryParameters;
  List<int> offsetValues = [1, 2, 3, 4];

  for (int i = 0; i < 4; i++) {
    urlValue = urls[keys[i]] ?? "null";

    if (urlValue.isNotEmpty && urlValue != "null") {
      uriValue = Uri.parse(urlValue);
      queryParameters = uriValue.queryParameters;
      offsetValues[i] = int.tryParse(queryParameters["page[offset]"]!) ?? -1;
    } else {
      offsetValues[i] = -1;
    }

    //print(offsetValues[i]);
  }

  List instances = body["data"]
      .map((anime) => Anime.createInstance(anime))
      .toList();

  List returnValues = [instances, offsetValues];

  return returnValues;
}

Future<List> getSortedData(int limit, int offset, String sort) async {
  final url;
  url = Uri.https("kitsu.io", "/api/edge/anime", {
    "page[limit]": limit.toString(),
    "page[offset]": offset.toString(),
    "sort": sort,
  });
  final response = await http.get(
    url,
    headers: {"Content-Type": "application/vnd.api+json"},
  );

  if (response.statusCode != 200) {
    throw ErrorDescription("Unable to reach the server.");
  }

  final body = json.decode(response.body);

  Map urls = body["links"];
  List<String> keys = ["first", "prev", "next", "last"];
  String urlValue;
  Uri uriValue;
  Map<String, String> queryParameters;
  List<int> offsetValues = [1, 2, 3, 4];

  for (int i = 0; i < 4; i++) {
    urlValue = urls[keys[i]] ?? "null";

    if (urlValue.isNotEmpty && urlValue != "null") {
      uriValue = Uri.parse(urlValue);
      queryParameters = uriValue.queryParameters;
      offsetValues[i] = int.tryParse(queryParameters["page[offset]"]!) ?? -1;
    } else {
      offsetValues[i] = -1;
    }

    //print(offsetValues[i]);
  }

  List instances = body["data"]
      .map((anime) => Anime.createInstance(anime))
      .toList();

  List returnValues = [instances, offsetValues];

  return returnValues;
}
