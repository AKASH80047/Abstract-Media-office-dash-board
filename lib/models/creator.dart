class Creator {
  final String name;
  final String avatarUrl;
  final int artworksCount;
  final double ratingProgress; // Value between 0.0 and 1.0

  Creator({
    required this.name,
    required this.avatarUrl,
    required this.artworksCount,
    required this.ratingProgress,
  });
}
