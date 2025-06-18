import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class StudymaterialScreen extends StatefulWidget {
  const StudymaterialScreen({super.key});

  @override
  State<StudymaterialScreen> createState() => _StudymaterialScreenState();
}

class _StudymaterialScreenState extends State<StudymaterialScreen> {
  YoutubePlayerController? _controller;
  String currentTitle = '';
  List<Map<String, dynamic>> videos = [];

  @override
  void initState() {
    super.initState();
    fetchVideos();
  }

  /// Ambil data dari Firestore
  Future<void> fetchVideos() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('local_videos')
          .orderBy('createdAt', descending: false)
          .get();

      final fetchedVideos = snapshot.docs.map((doc) => doc.data()).toList();

      if (fetchedVideos.isNotEmpty) {
        final firstVideo = fetchedVideos[0];
        setState(() {
          videos = List<Map<String, dynamic>>.from(fetchedVideos);
          currentTitle = firstVideo['title'];
          _initPlayer(firstVideo['videoId']);
        });
      }
    } catch (e) {
      print('Gagal mengambil data video: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal mengambil data dari Firestore')),
      );
    }
  }

  /// Inisialisasi YouTube player
  void _initPlayer(String videoId) {
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  /// Ganti video saat item diklik
  void _changeVideo(String videoId) {
    if (_controller != null) {
      _controller!.load(videoId);
      setState(() {
        currentTitle = videos
            .firstWhere((video) => video["videoId"] == videoId)["title"];
      });
    }
  }

  /// Card item video
  Widget _buildVideoCard(Map<String, dynamic> video) {
    return GestureDetector(
      onTap: () => _changeVideo(video["videoId"]),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(Icons.play_circle_fill, size: 60),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video["title"] ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(video["duration"] ?? ''),
                ],
              ),
            ),
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.download),
            ),
          ],
        ),
      ),
    );
  }

  /// Fungsi untuk seed data ke Firestore
  void createInitialVideos() async {
    final sampleVideos = [
      {
      "title":
          "Mengenal Sistem Isyarat Bahasa Indonesia (SIBI - BISINDO ?) | Belajar Isyarat Part #1",
      "url": "https://www.youtube.com/watch?v=4DZnZv3weBw",
      "videoId": "4DZnZv3weBw",
      "duration": "16:51"
    },
    {
      "title":
          "Alfabet - ABJAD dalam SIBI [Sistem Isyarat Bahasa Indonesia] | Belajar Isyarat Part #2",
      "url": "https://www.youtube.com/watch?v=QUxNzUiWvAY",
      "videoId": "QUxNzUiWvAY",
      "duration": "12:31"
    },
    {
      "title":
          "Angka - Bilangan dan Operasi Hitung dalam SIBI | Belajar Isyarat Part #3",
      "url": "https://www.youtube.com/watch?v=h681dhezQyw",
      "videoId": "h681dhezQyw",
      "duration": "13:21"
    },
    {
      "title":
          "Kata Ganti Orang | Belajar SIBI Sistem Isyarat Bahasa Indonesia #4",
      "url": "https://www.youtube.com/watch?v=P683FVLH-2o",
      "videoId": "P683FVLH-2o",
      "duration": "2:19"
    },
    {
      "title":
          "Bertanya dengan SIBI - Sistem Isyarat Bahasa Indonesia | Belajar Part #5",
      "url": "https://www.youtube.com/watch?v=TuQj8aFOcgs",
      "videoId": "TuQj8aFOcgs",
      "duration": "2:04"
    },
    {
      "title": "SALAM DALAM SIBI (Greetings) | Belajar Isyarat Part #6",
      "url": "https://www.youtube.com/watch?v=h4hy75JWBdE",
      "videoId": "h4hy75JWBdE",
      "duration": "7:57"
    },
    {
      "title":
          "Kata-kata CINTA dalam SIBI [Sistem Isyarat Bahasa Indonesia] | Belajar Isyarat Part #7",
      "url": "https://www.youtube.com/watch?v=7CAjxgZpPUU",
      "videoId": "7CAjxgZpPUU",
      "duration": "6:47"
    },
    {
      "title":
          "Isyarat Hari-hari dalam SIBI - [ Senin sampai Minggu !! ] | Belajar Isyarat Part #8",
      "url": "https://www.youtube.com/watch?v=9A8sVFdMxcA",
      "videoId": "9A8sVFdMxcA",
      "duration": "10:17"
    },
    {
      "title":
          "Kata-kata IBADAH dalam SIBI [Puasa, Sholat dll] | Belajar Isyarat Part #9",
      "url": "https://www.youtube.com/watch?v=pbVDNa4WLlQ",
      "videoId": "pbVDNa4WLlQ",
      "duration": "13:35"
    },
    {
      "title": "Kata Medis / Kedokteran dalam SIBI | Belajar Isyarat Part #10",
      "url": "https://www.youtube.com/watch?v=QYHY0sq1mcM",
      "videoId": "QYHY0sq1mcM",
      "duration": "7:38"
    }
    ];

    for (var video in sampleVideos) {
      await FirebaseFirestore.instance.collection('local_videos').add({
        'title': video['title'],
        "url" : video['url'],
        'videoId': video['videoId'],
        'duration': video['duration'],
        'createdAt': FieldValue.serverTimestamp(),
      });
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Data awal berhasil ditambahkan')),
    );

    fetchVideos(); // refresh list setelah tambah data
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  /// UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Language Basic'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Seed Data',
            onPressed: createInitialVideos,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: videos.isEmpty || _controller == null
            ? const Center(child: Text('Tidak ada video ditemukan'))
            : YoutubePlayerBuilder(
                player: YoutubePlayer(
                  controller: _controller!,
                  showVideoProgressIndicator: true,
                ),
                builder: (context, player) {
                  return Column(
                    children: [
                      player,
                      const SizedBox(height: 20),
                      Text(
                        currentTitle,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          itemCount: videos.length,
                          itemBuilder: (context, index) {
                            return _buildVideoCard(videos[index]);
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
      ),
      floatingActionButton: (_controller != null)
          ? FloatingActionButton(
              onPressed: () {
                if (_controller!.value.isPlaying) {
                  _controller!.pause();
                } else {
                  _controller!.play();
                }
                setState(() {}); // agar icon berubah
              },
              child: Icon(
                _controller!.value.isPlaying
                    ? Icons.pause
                    : Icons.play_arrow,
              ),
            )
          : null,
    );
  }
}
