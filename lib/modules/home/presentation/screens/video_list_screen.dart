import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:reels/core/services/api_service.dart';
import 'package:reels/modules/home/data/models/video_model.dart';
import 'package:reels/modules/home/presentation/widgets/reel_widget.dart';

class VideoListScreen extends StatefulWidget {
  const VideoListScreen({super.key});

  @override
  State<VideoListScreen> createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  late Future<List<VideoModel>> futureVideos;
  int currentPage = 1;

  @override
  void initState() {
    super.initState();
    futureVideos = ApiService.fetchVideos(currentPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<List<VideoModel>>(
            future: futureVideos,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child:
                        LottieBuilder.asset('assets/lottie/loadingBar.json'));
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.hasData) {
                final videos = snapshot.data!;
                return PageView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: videos.length,
                  itemBuilder: (context, index) {
                    final video = videos[index];
                    return ReelWidget(
                      videoUrl: video.videoUrl,
                      previewUrl: video.previewUrl,
                      description: 'video number ${index + 1}',
                    );
                  },
                );
              } else {
                return const Center(child: Text('No videos found'));
              }
            },
          ),
          Positioned(
            top: 40,
            left: 130,
            child: Container(
              decoration: const BoxDecoration(
                color: Color.fromARGB(180, 172, 171, 171),
                border: Border(
                  top: BorderSide(width: 1.0, color: Colors.white),
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      CupertinoIcons.back,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        if (currentPage > 1) {
                          currentPage--;
                          futureVideos = ApiService.fetchVideos(currentPage);
                        } else {
                          currentPage = 1;
                          futureVideos = ApiService.fetchVideos(currentPage);
                        }
                      });
                    },
                  ),
                  Text('Page $currentPage',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                  IconButton(
                    icon: const Icon(
                      CupertinoIcons.forward,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        if (currentPage < 16) {
                          currentPage++;
                          futureVideos = ApiService.fetchVideos(currentPage);
                        } else {
                          currentPage = 16;
                          futureVideos = ApiService.fetchVideos(currentPage);
                        }
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}



/* ListTile(
                  leading: CachedNetworkImage(
                    imageUrl: video.previewUrl,
                    placeholder: (context, url) => const Icon(
                      CupertinoIcons.video_camera,
                      size: 40,
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  title: Text(video
                      .duration), // Display duration as a placeholder for title
                  subtitle: Text('Size: ${video.size}'),
                  onTap: () {
                    // Navigate to a detail screen to play the video using video_player
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ReelsPlayerScreen(videoUrl: video.videoUrl),
                      ),
                    );
                  },
                );
             */