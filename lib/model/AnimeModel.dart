class Anime {
  final int id;
  final String imageUrl;
  final String title;
  final double score;
  final String dateReleased;
  final int numberOfEpisodes;

  Anime(
      {this.id,
      this.imageUrl,
      this.title,
      this.score,
      this.dateReleased,
      this.numberOfEpisodes});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'title': title,
      'score': score,
      "dateReleased": dateReleased,
      'numberOfEpisodes': numberOfEpisodes
    };
  }
}
