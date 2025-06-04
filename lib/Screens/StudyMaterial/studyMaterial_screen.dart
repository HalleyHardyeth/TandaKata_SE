import 'package:flutter/material.dart';
import 'package:tanda_kata/Screens/Home/home.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class StudymaterialScreen extends StatefulWidget {
  const StudymaterialScreen({super.key});

  @override
  State<StudymaterialScreen> createState() => _StudymaterialScreenState();
}

class _StudymaterialScreenState extends State<StudymaterialScreen> {
  late YoutubePlayerController _controller;
  late String currentTitle;

  final List<Map<String, String>> videos = [
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
    },
  ];

  @override
  void initState() {
    super.initState();
    currentTitle = videos[0]["title"]!;
    _initPlayer(videos[0]["url"]!);
  }

  void _initPlayer(String url) {
    final videoID = YoutubePlayer.convertUrlToId(url)!;
    _controller = YoutubePlayerController(
      initialVideoId: videoID,
      flags: const YoutubePlayerFlags(autoPlay: true),
    );
  }

  void _changeVideo(String url) {
    final newVideoId = YoutubePlayer.convertUrlToId(url);
    if (newVideoId != null && newVideoId != _controller.metadata.videoId) {
      setState(() {
        _controller.load(newVideoId);
        currentTitle =
            videos.firstWhere((video) => video["url"] == url)["title"]!;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildVideoCard(Map<String, String> video) {
    return GestureDetector(
      onTap: () => _changeVideo(video["url"]!),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                "https://img.youtube.com/vi/${video["videoId"]}/0.jpg",
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(video["title"]!,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(video["duration"]!),
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

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        onReady: () => debugPrint('Player Ready'),
      ),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Sign Language Basic'),
            centerTitle: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Home()),
                );
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: player,
                ),
                const SizedBox(height: 20),
                Text(
                  currentTitle,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
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
            ),
          ),
        );
      },
    );
  }
}
