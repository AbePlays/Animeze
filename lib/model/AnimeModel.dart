class Anime {
  final int id;
  final String imageUrl;
  final String title;
  final double score;
  final String dateReleased;

  Anime({this.id, this.imageUrl, this.title, this.score, this.dateReleased});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'title': title,
      'score': score,
      "dateReleased": dateReleased
    };
  }
}
