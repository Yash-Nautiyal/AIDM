(String firstName, String lastName) parseDisplayName(String displayName) {
  final trimmed = displayName.trim();
  if (trimmed.isEmpty) {
    return ('', '');
  }

  final parts = trimmed.split(RegExp(r'\s+'));
  if (parts.length == 1) {
    return (parts.first, '');
  }

  return (parts.first, parts.sublist(1).join(' '));
}
