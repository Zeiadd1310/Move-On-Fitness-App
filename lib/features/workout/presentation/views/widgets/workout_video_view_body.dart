import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:move_on/core/utils/youtube_video_id.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

/// Mobile WebView user-agents that satisfy YouTube embed + referrer checks (mitigates 152/153-style errors).
String? _youtubeWebViewUserAgent() {
  if (kIsWeb) return null;
  switch (defaultTargetPlatform) {
    case TargetPlatform.iOS:
      return 'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile/15E148 Safari/604.1';
    case TargetPlatform.android:
      return 'Mozilla/5.0 (Linux; Android 13; Mobile) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Mobile Safari/537.36';
    default:
      return null;
  }
}

class WorkoutVideoViewBody extends StatefulWidget {
  const WorkoutVideoViewBody({
    super.key,
    required this.videoUrl,
    required this.title,
  });

  final String videoUrl;
  final String title;

  @override
  State<WorkoutVideoViewBody> createState() => _WorkoutVideoViewBodyState();
}

class _WorkoutVideoViewBodyState extends State<WorkoutVideoViewBody> {
  YoutubePlayerController? _youtubeController;
  WebViewController? _fallbackWebController;
  StreamSubscription<YoutubePlayerValue>? _playerSubscription;

  @override
  void initState() {
    super.initState();
    final videoId = parseYoutubeVideoId(widget.videoUrl);
    if (videoId != null) {
      _youtubeController = YoutubePlayerController.fromVideoId(
        videoId: videoId,
        autoPlay: true,
        params: YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
          strictRelatedVideos: false,
          // Privacy-enhanced embed host; often fixes embed errors 152-x / 153 with strict referrer rules.
          origin: 'https://www.youtube-nocookie.com',
          userAgent: _youtubeWebViewUserAgent(),
        ),
      );
      _playerSubscription = _youtubeController!.listen((value) {
        if (value.hasError && mounted) {
          setState(() {});
        }
      });
    } else if (widget.videoUrl.isNotEmpty) {
      _fallbackWebController = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(Uri.parse(widget.videoUrl));
    }
  }

  @override
  void dispose() {
    _playerSubscription?.cancel();
    _youtubeController?.close();
    super.dispose();
  }

  Future<void> _openInYoutubeApp() async {
    final id = parseYoutubeVideoId(widget.videoUrl);
    final uri = youtubeWatchUriForVideoId(id);
    if (uri == null) return;
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open YouTube.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final videoId = parseYoutubeVideoId(widget.videoUrl);
    final lastError = _youtubeController?.value.error;

    return SafeArea(
      child: Column(
        children: [
          AppBar(
            title: Text(widget.title),
            centerTitle: true,
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
          if (videoId != null && lastError != null && lastError != YoutubeError.none)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Playback failed in the app (${lastError.code}). '
                'Try opening in YouTube below.',
                style: const TextStyle(color: Colors.white70, fontSize: 13),
                textAlign: TextAlign.center,
              ),
            ),
          Expanded(
            child: ColoredBox(
              color: Colors.black,
              child: _buildPlayer(),
            ),
          ),
          if (videoId != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: TextButton.icon(
                onPressed: _openInYoutubeApp,
                icon: const Icon(Icons.open_in_new, color: Colors.redAccent),
                label: const Text(
                  'Open in YouTube',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPlayer() {
    final yt = _youtubeController;
    if (yt != null) {
      return YoutubePlayer(
        controller: yt,
        aspectRatio: 16 / 9,
        backgroundColor: Colors.black,
      );
    }

    final web = _fallbackWebController;
    if (web != null) {
      return WebViewWidget(controller: web);
    }

    return const Center(
      child: Text(
        'No video URL available.',
        style: TextStyle(color: Colors.white70),
      ),
    );
  }
}
