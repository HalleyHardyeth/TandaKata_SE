import 'package:flutter/material.dart';
import 'package:tanda_kata/Screens/History/history_item.dart';
import 'package:tanda_kata/color.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<HistoryItem> historyItems = [
      HistoryItem(
        title: 'Topic A',
        item: 'Quiz',
        imagePath: '',
      ),
      HistoryItem(
        title: 'Topic B',
        item: 'Course',
        imagePath: '',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Learning History',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 80,
                    height: 80, // This will now be respected
                    decoration: BoxDecoration(
                      color: grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: item.imagePath.isNotEmpty
                        ? Image.asset(item.imagePath, fit: BoxFit.cover)
                        : const SizedBox(), // fallback if image is empty
                  ),
                  const SizedBox(width: 12),
                  SizedBox(
                    height: 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item.title,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          item.item,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
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
