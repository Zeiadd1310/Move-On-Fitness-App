/// Returns the YouTube video id from common URL shapes, or null if not recognized.
String? parseYoutubeVideoId(String rawUrl) {
  final trimmed = rawUrl.trim();
  if (trimmed.isEmpty) return null;

  final uri = Uri.tryParse(trimmed);
  if (uri == null) return null;

  final host = uri.host.toLowerCase();

  if (host == 'youtu.be' || host.endsWith('.youtu.be')) {
    if (uri.pathSegments.isEmpty) return null;
    final id = uri.pathSegments.first;
    if (id.isNotEmpty) return id;
  }

  if (host.contains('youtube.com')) {
    if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'shorts') {
      if (uri.pathSegments.length > 1) {
        final id = uri.pathSegments[1];
        if (id.isNotEmpty) return id;
      }
    }
    if (uri.pathSegments.isNotEmpty && uri.pathSegments.first == 'embed') {
      if (uri.pathSegments.length > 1) {
        final id = uri.pathSegments[1];
        if (id.isNotEmpty) return id;
      }
    }
    final v = uri.queryParameters['v'];
    if (v != null && v.isNotEmpty) return v;
  }

  return null;
}

/// Canonical watch URL for opening in the YouTube app or browser (bypasses embed restrictions).
Uri? youtubeWatchUriForVideoId(String? videoId) {
  if (videoId == null || videoId.isEmpty) return null;
  return Uri.parse('https://www.youtube.com/watch?v=$videoId');
}
