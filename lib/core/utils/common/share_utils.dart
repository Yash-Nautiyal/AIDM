import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

abstract class ShareUtils {
  static Uri inviteUri(String inviteLink) {
    final link = inviteLink.trim();
    if (link.startsWith('http://') || link.startsWith('https://')) {
      return Uri.parse(link);
    }
    return Uri.parse('https://$link');
  }

  static Rect? originFromContext(BuildContext context) {
    final box = context.findRenderObject() as RenderBox?;
    if (box == null || !box.hasSize) return null;
    return box.localToGlobal(Offset.zero) & box.size;
  }

  static Future<void> shareWebinarInvite({
    required BuildContext context,
    required String title,
    required String inviteLink,
    Rect? sharePositionOrigin,
  }) async {
    try {
      await SharePlus.instance.share(
        ShareParams(
          uri: inviteUri(inviteLink),
          title: title,
          subject: title,
          sharePositionOrigin: sharePositionOrigin,
        ),
      );
    } on MissingPluginException {
      await Clipboard.setData(ClipboardData(text: inviteLink));
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Link copied. Stop and fully restart the app to use native share.',
          ),
        ),
      );
    }
  }
}
