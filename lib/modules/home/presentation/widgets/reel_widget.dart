import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ReelWidget extends StatefulWidget {
  final String videoUrl;
  final String description;
  final String previewUrl;
  // final String videoNumber;
  const ReelWidget({
    super.key,
    required this.videoUrl,
    required this.description,
    required this.previewUrl,
    // required this.videoNumber,
  });

  @override
  State<ReelWidget> createState() => _ReelWidgetState();
}

class _ReelWidgetState extends State<ReelWidget> {
  late VideoPlayerController _controller;
  bool isLiked = false;
  @override
  void initState() {
    super.initState();
    // ignore: deprecated_member_use
    _controller = VideoPlayerController.network(widget.videoUrl,
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true));
    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _controller.value.isInitialized
            ? Positioned(
                top: 0,
                bottom: 0,
                left: 0,
                right: 0,
                child: AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                ),
              )
            : Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(widget.previewUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
        Positioned(
          bottom: 50,
          right: 20,
          child: Column(
            children: [
              GestureDetector(
                onTap: () => setState(() => isLiked = !isLiked),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: const Color.fromARGB(180, 172, 171, 171),
                  child: Icon(
                    CupertinoIcons.heart_fill,
                    color: isLiked ? Colors.red : Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: GestureDetector(
                  onTap: () {},
                  child: const CircleAvatar(
                    radius: 30,
                    backgroundColor: Color.fromARGB(180, 172, 171, 171),
                    child: Icon(
                      CupertinoIcons.cloud_download_fill,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: const CircleAvatar(
                  radius: 30,
                  backgroundColor: Color.fromARGB(180, 172, 171, 171),
                  child: Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 50,
          left: 20,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Color.fromARGB(180, 172, 171, 171),
              border: Border(
                top: BorderSide(width: 1.0, color: Colors.white),
              ),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.description,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
