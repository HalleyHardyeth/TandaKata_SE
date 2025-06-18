import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tanda_kata/Screens/History/history_item.dart';
import 'package:tanda_kata/Screens/History/history_store.dart';
import 'package:tanda_kata/Screens/History/user_session.dart';
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
  late String currentVideoId;
  List<Map<String, dynamic>> videos = [];

  @override
  void initState() {
    super.initState();
    fetchVideos();
  }

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
          currentVideoId = firstVideo['videoId'];
          _initPlayer(firstVideo['videoId']);
        });
        _addToHistory(firstVideo);
      }
    } catch (e) {
      print('Failed to fetch videos: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to fetch videos from Firestore')),
      );
    }
  }

  void _initPlayer(String videoId) {
    _controller = YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(autoPlay: true),
    );
  }

  void _changeVideo(String videoId) {
    if (videoId != _controller.metadata.videoId) {
      setState(() {
        _controller.load(videoId);
        currentTitle = videos.firstWhere((video) => video["videoId"] == videoId)["title"];
        currentVideoId = videoId;
      });
      final clickedVideo = videos.firstWhere((video) => video["videoId"] == videoId);
      _addToHistory(clickedVideo);
    }
  }

  void _addToHistory(Map<String, dynamic> video) {
    final userId = UserSession().userId ?? "guest";
    final item = HistoryItem(
      title: video["title"],
      imagePath: "https://img.youtube.com/vi/${video["videoId"]}/0.jpg",
    );
    HistoryStore.addHistory(userId, item);
  }

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
                  Text(video["title"],
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(video["duration"]),
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
  void dispose() {
    _controller.dispose();
    super.dispose();
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
            child: videos.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : Column(
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