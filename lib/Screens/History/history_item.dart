class HistoryItem {
  final String title;
  final String imagePath;

  HistoryItem({required this.title, required this.imagePath});
}

// Global in-memory storage
Map<String, List<HistoryItem>> userHistory = {};
