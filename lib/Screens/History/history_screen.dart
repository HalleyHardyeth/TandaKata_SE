import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tanda_kata/Screens/History/history_store.dart';
import 'package:tanda_kata/Screens/History/user_session.dart';
import 'package:tanda_kata/Screens/Home/home.dart';
import 'package:tanda_kata/color.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = UserSession().userId ?? "guest";
    final historyItems = HistoryStore.getHistory(userId);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Home()));
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text(
          'Learning History',
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.builder(
          itemCount: historyItems.length,
          itemBuilder: (context, index) {
            final item = historyItems[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Container(
                    width: 100,
                    height: 70,
                    decoration: BoxDecoration(
                      color: grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: item.imagePath.isNotEmpty
                        ? Image.network(item.imagePath, fit: BoxFit.cover)
                        : const SizedBox(),
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    width: 230,
                    height: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            item.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
