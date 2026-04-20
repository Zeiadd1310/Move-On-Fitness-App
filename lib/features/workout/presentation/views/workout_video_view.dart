import 'package:flutter/material.dart';
import 'package:move_on/features/workout/presentation/views/widgets/workout_video_view_body.dart';

class WorkoutVideoView extends StatelessWidget {
  const WorkoutVideoView({
    super.key,
    required this.videoUrl,
    required this.title,
  });

  final String videoUrl;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: WorkoutVideoViewBody(videoUrl: videoUrl, title: title),
    );
  }
}
