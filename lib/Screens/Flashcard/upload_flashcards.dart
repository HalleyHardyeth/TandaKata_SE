import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

final List<Map<String, String>> flashcardData = [
  {
    "imageUrl":
        "https://drive.google.com/uc?export=view&id=1NGVDiA1tE6OhdzQLkULE4Aq1ASqYZj-7",
    "answer": "A"
  },
  {
    "imageUrl":
        "https://drive.google.com/uc?export=view&id=1JX5jobn2E-sfNa3FnZHxyFihJ4_MaKk_",
    "answer": "B"
  },
  {
    "imageUrl":
        "https://drive.google.com/uc?export=view&id=12aCVgq-a7cB1WogB1wvH7uP8hT-Zdmz7",
    "answer": "C"
  },
  {
    "imageUrl":
        "https://drive.google.com/uc?export=view&id=1TDZPWWl6aM4uaBVAXcbG4Xzq47tdgOi2",
    "answer": "D"
  },
  {
    "imageUrl":
        "https://drive.google.com/uc?export=view&id=160ZCQnZ7vXAz6PjN6rb6yaJVkuzd4CG9",
    "answer": "E"
  },
  {
    "imageUrl":
        "https://drive.google.com/uc?export=view&id=1fc9sGz_Q4wudHkBS4NFR7_6iMbiUYSEs",
    "answer": "F"
  },
  {
    "imageUrl":
        "https://drive.google.com/uc?export=view&id=1fc9sGz_Q4wudHkBS4NFR7_6iMbiUYSEs",
    "answer": "G"
  },
  {
    "imageUrl":
        "https://drive.google.com/uc?export=view&id=1HCT9cAd-RxSDkZ266aMGXMbn9V47Bgky",
    "answer": "H"
  },
  {
    "imageUrl":
        "https://drive.google.com/uc?export=view&id=1rqETyG6LQSjE7tIhlJF4e1ZtaNq60aR9",
    "answer": "I"
  },
  {
    "imageUrl":
        "https://drive.google.com/uc?export=view&id=1rqETyG6LQSjE7tIhlJF4e1ZtaNq60aR9",
    "answer": "J"
  },
  {
    "imageUrl":
        "https://drive.google.com/uc?export=view&id=1Kgrc5YNz4e3JRlyo2BuwC13yB1uScC3M",
    "answer": "K"
  },
  {
    "imageUrl":
        "https://drive.google.com/uc?export=view&id=1bQS8oDoKzlYi3Vp8jlEejs24MuE_F89X",
    "answer": "L"
  },
  {
    "imageUrl":
        "https://drive.google.com/uc?export=view&id=1usDL-DsOeCHH3MAV8a6mvzvnZtUGh4Ez",
    "answer": "M"
  },
  {
    "imageUrl":
        "https://drive.google.com/uc?export=view&id=1kVaOPRpwQMe2D5RbrjRVRP93-S_tqTti",
    "answer": "N"
  },
  {
    "imageUrl":
        "https://drive.google.com/uc?export=view&id=1hRymOXQK5Uf4o81pBPjlQ3YHQ4EjgEHa",
    "answer": "O"
  },
  {
    "imageUrl":
        "https://drive.google.com/uc?export=view&id=1hb21QlwFPVJ78TTOkIs8jrF43JgDlMPI",
    "answer": "P"
  },
  {
    "imageUrl":
        "https://drive.google.com/uc?export=view&id=1TST2r227in6zt2qXonIO_8FKfHeYK4hr",
    "answer": "Q"
  },
  {
    "imageUrl":
        "https://drive.google.com/uc?export=view&id=1toErqIuWy4jEEeu_HqBijbXkBVeeCQB5",
    "answer": "R"
  },
  {
    "imageUrl":
        "https://drive.google.com/uc?export=view&id=1UdhW9F41XdaIJNzwnd2ghlErmoG8bfqZ",
    "answer": "S"
  },
  {
    "imageUrl":
        "https://drive.google.com/uc?export=view&id=1jroUcTZJpj-LXG7p-pNfTpEuYjEjsJO0",
    "answer": "T"
  },
  {
    "imageUrl":
        "https://drive.google.com/uc?export=view&id=1bv15Gk_1bRiiEPbZW8DHGN668nmmsSMH",
    "answer": "U"
  },
  {
    "imageUrl":
        "https://drive.google.com/uc?export=view&id=1cGrqiTBx2g6-g8Kekeap8oZ0amWTra-L",
    "answer": "V"
  },
  {
    "imageUrl":
        "https://drive.google.com/uc?export=view&id=1hVm1LJVghBWkD6BFF9g-s1_tAK4NfCjL",
    "answer": "W"
  },
  {
    "imageUrl":
        "https://drive.google.com/uc?export=view&id=1L5soccdhakT2T9a0VHI8mbV0AoKbI0F1",
    "answer": "X"
  },
  {
    "imageUrl":
        "https://drive.google.com/uc?export=view&id=1zGmpN94ABN1wLzLMlH_FBplYYgDjaLtc",
    "answer": "Y"
  },
  {
    "imageUrl":
        "https://drive.google.com/uc?export=view&id=1h4aWbkfTzDJWQ0AfeQRrVCxrFN0QHo0q",
    "answer": "Z"
  }
];

Future<void> uploadFlashcardsToFirestore() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final firestore = FirebaseFirestore.instance;
  final flashcardsCollection = firestore.collection('flashcards');

  for (final flashcard in flashcardData) {
    await flashcardsCollection.add({
      'imageUrl': flashcard['imageUrl'],
      'answer': flashcard['answer'],
    });
  }

  print("✅ Semua flashcard berhasil diupload!");
}

void main() => uploadFlashcardsToFirestore();
