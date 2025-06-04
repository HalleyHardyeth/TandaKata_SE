import 'package:tanda_kata/Screens/History/history_item.dart';

class HistoryStore {
  static final Map<String, List<HistoryItem>> _userHistory = {};

  static void addHistory(String userId, HistoryItem item) {
    if (!_userHistory.containsKey(userId)) {
      _userHistory[userId] = [];
    }
    if (!_userHistory[userId]!.any((h) => h.title == item.title)) {
      _userHistory[userId]!.add(item);
    }
  }

  static List<HistoryItem> getHistory(String userId) {
    return _userHistory[userId] ?? [];
  }
}
