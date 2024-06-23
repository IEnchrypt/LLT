import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/// Creates list of video players
class VideoList extends StatefulWidget {
  final Function()? onTap;

  VideoList({super.key, required this.onTap});
  
  @override
  _VideoListState createState() => _VideoListState();
}

class _VideoListState extends State<VideoList> {
  final List<YoutubePlayerController> _controllers = [
    'aOgRveK5hoE',
    'rQ9Ojt17R4w',
    'ek_VOzpMmEo',
    'Bc7tikM7oEc',
    'qidM64JW5kw',
    'wONviPCc6Xw',
    'Q-jPXDnBKHE',
    'l9X_xcIDvoM',
  ]
      .map<YoutubePlayerController>(
        (videoId) => YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
          ),
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: ListView.separated(
        itemBuilder: (context, index) {
          return YoutubePlayer(
            key: ObjectKey(_controllers[index]),
            controller: _controllers[index],
            actionsPadding: const EdgeInsets.only(left: 16.0),
            bottomActions: [
              CurrentPosition(),
              const SizedBox(width: 10.0),
              ProgressBar(isExpanded: true),
              const SizedBox(width: 10.0),
              RemainingDuration(),
              FullScreenButton(),
            ],
          );
        },
        itemCount: _controllers.length,
        separatorBuilder: (context, _) => const SizedBox(height: 10.0),
      ),
    floatingActionButton: CircleAvatar(
          radius: 30,
          backgroundColor: Color.fromARGB(255, 20, 102, 23),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_sharp, size: 40),
            color: Color.fromARGB(255, 255, 255, 255),
            onPressed: widget.onTap,
          ),
        ));
  }
}