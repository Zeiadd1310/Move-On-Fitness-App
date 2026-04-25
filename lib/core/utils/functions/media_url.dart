String normalizeApiMediaUrl(String? rawUrl) {
  final raw = rawUrl?.trim() ?? '';
  if (raw.isEmpty) return '';

  final lower = raw.toLowerCase();
  if (lower.startsWith('http://') || lower.startsWith('https://')) {
    return raw;
  }

  const host = 'http://moveonapi-2-1.runasp.net';
  if (raw.startsWith('/')) {
    return '$host$raw';
  }

  return '$host/$raw';
}
