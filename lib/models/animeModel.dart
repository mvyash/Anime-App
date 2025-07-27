class Anime {
  late String id;
  late String createdAt;
  late String updatedAt;
  late String slug;
  late String synopsis;
  late Map<String, dynamic> titles;
  late String canonicalTitle;
  late String averageRating;
  late Map<String, dynamic> ratingFrequencies;
  late String startDate;
  late String endDate;
  late String ageRating;
  late String ageRatingGuide;
  late String status;
  late Map<String, dynamic> posterImage;
  late Map<String, dynamic> coverImage;
  late int episodeCount;
  late String youtubeVideoId;
  late bool nsfw;

  Anime({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.slug,
    required this.synopsis,
    required this.titles,
    required this.canonicalTitle,
    required this.averageRating,
    required this.ratingFrequencies,
    required this.startDate,
    required this.endDate,
    required this.ageRating,
    required this.ageRatingGuide,
    required this.status,
    required this.posterImage,
    required this.coverImage,
    required this.episodeCount,
    required this.youtubeVideoId,
    required this.nsfw,
  });

  factory Anime.createInstance(Map<String, dynamic> animeData) {
    Map<String, dynamic> posterImage =
        animeData["attributes"]["posterImage"] ?? <String, dynamic>{};
    posterImage.removeWhere((key, value) => key.startsWith("m"));
    Map<String, dynamic> coverImage =
        animeData["attributes"]["coverImage"] ?? <String, dynamic>{};
    coverImage.removeWhere((key, value) => key.startsWith("m"));

    return Anime(
      id: animeData["id"] ?? "Not Provided",
      createdAt: animeData["attributes"]["createdAt"] ?? "Not Provided",
      updatedAt: animeData["attributes"]["updatedAt"] ?? "Not Provided",
      slug: animeData["attributes"]["slug"] ?? "Not Provided",
      synopsis: animeData["attributes"]["synopsis"] ?? "Not Provided",
      titles: animeData["attributes"]["titles"] ?? <String, dynamic>{},
      canonicalTitle:
          animeData["attributes"]["canonicalTitle"] ?? "Not Provided",
      averageRating: animeData["attributes"]["averageRating"] ?? "Not Provided",
      ratingFrequencies:
          animeData["attributes"]["ratingFrequencies"] ?? <String, dynamic>{},
      startDate: animeData["attributes"]["startDate"] ?? "Not Provided",
      endDate: animeData["attributes"]["endDate"] ?? "Not Provided",
      ageRating: animeData["attributes"]["ageRating"] ?? "Not Provided",
      ageRatingGuide:
          animeData["attributes"]["ageRatingGuide"] ?? "Not Provided",
      status: animeData["attributes"]["status"] ?? "Not Provided",
      posterImage: posterImage,
      coverImage: coverImage,
      episodeCount: animeData["attributes"]["episodeCount"] ?? -1,
      youtubeVideoId:
          animeData["attributes"]["youtubeVideoId"] ?? "Not Provided",
      nsfw: animeData["attributes"]["nsfw"] ?? true,
    );
  }
}
