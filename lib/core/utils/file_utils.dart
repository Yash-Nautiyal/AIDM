import 'package:aidm/core/constant/app_assets.dart';
import 'package:flutter/material.dart';

class FileTypeVisual {
  const FileTypeVisual({
    required this.label,
    required this.color,
    required this.iconPath,
  });

  final String label;
  final Color color;
  final String iconPath;
}

abstract class FileUtils {
  static String getFileIcon(String fileType) {
    return getFileTypeVisual(fileType).iconPath;
  }

  static FileTypeVisual getFileTypeVisual(String fileType) {
    final extension = _normalizeExtension(fileType);

    return switch (extension) {
      'pdf' => const FileTypeVisual(
        label: 'PDF',
        color: Color(0xFFEF3838),
        iconPath: AppAssets.filePdfIcon,
      ),
      'zip' || 'rar' || '7z' => const FileTypeVisual(
        label: 'ZIP',
        color: Color(0xFFF59E0B),
        iconPath: AppAssets.fileZipIcon,
      ),
      'ppt' || 'pptx' || 'powerpoint' => const FileTypeVisual(
        label: 'PPT',
        color: Color(0xFFEA580C),
        iconPath: AppAssets.filePptIcon,
      ),
      'doc' || 'docx' || 'word' => const FileTypeVisual(
        label: 'DOC',
        color: Color(0xFF3762E3),
        iconPath: AppAssets.fileDocIcon,
      ),
      'jpg' ||
      'jpeg' ||
      'png' ||
      'gif' ||
      'webp' ||
      'heic' ||
      'image' ||
      'img' => const FileTypeVisual(
        label: 'IMG',
        color: Color(0xFF0D9488),
        iconPath: AppAssets.fileImgIcon,
      ),
      'xls' || 'xlsx' || 'csv' || 'excel' => const FileTypeVisual(
        label: 'XLS',
        color: Color(0xFF16A34A),
        iconPath: AppAssets.fileIcon,
      ),
      'mp4' || 'mkv' || 'avi' || 'mov' || 'video' => const FileTypeVisual(
        label: 'VID',
        color: Color(0xFF6648FA),
        iconPath: AppAssets.fileIcon,
      ),
      'mp3' || 'wav' || 'aac' || 'audio' => const FileTypeVisual(
        label: 'AUD',
        color: Color(0xFF8B5CF6),
        iconPath: AppAssets.fileIcon,
      ),
      'txt' || 'text' || 'md' || 'markdown' => const FileTypeVisual(
        label: 'TXT',
        color: Color(0xFF737378),
        iconPath: AppAssets.fileIcon,
      ),
      _ => FileTypeVisual(
        label: extension.length > 3
            ? extension.substring(0, 3).toUpperCase()
            : extension.toUpperCase(),
        color: const Color(0xFF737378),
        iconPath: AppAssets.fileIcon,
      ),
    };
  }

  static String formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      final kb = (bytes / 1024).toStringAsFixed(1);
      return '$kb KB';
    } else {
      final mb = (bytes / (1024 * 1024)).toStringAsFixed(1);
      return '$mb MB';
    }
  }

  static String formatAttachmentDate(DateTime date) {
    const months = <String>[
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  static String getExtensionFromMime(String mimeType) {
    switch (mimeType) {
      // Word Documents
      case 'application/vnd.openxmlformats-officedocument.wordprocessingml.document':
      case 'application/msword':
        return 'docx';

      // Text/Markdown
      case 'text/markdown':
        return 'md';

      // PDFs
      case 'application/pdf':
        return 'pdf';

      // Images
      case 'image/jpeg':
      case 'image/jpg':
        return 'jpg';
      case 'image/png':
        return 'png';

      // Fallback for unknown types (uses your split logic)
      default:
        final parts = mimeType.split('/');
        if (parts.length > 1) {
          final subType = parts.last;
          return subType.split('.').last;
        }
        return 'unknown';
    }
  }

  static String _normalizeExtension(String fileType) {
    final trimmed = fileType.trim().toLowerCase();
    if (trimmed.contains('/')) {
      return getExtensionFromMime(trimmed);
    }
    if (trimmed.contains('.')) {
      return trimmed.split('.').last;
    }
    return trimmed;
  }
}
