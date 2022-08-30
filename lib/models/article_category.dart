enum ArticleCategory {
  general,
  business,
  technology,
  entertainment,
  sports,
  science,
  health
}

extension ParseToString on ArticleCategory {
  String toShortString() {
    return this.toString().split('.').last;
  }
}
