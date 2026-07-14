import 'package:aidm/core/utils/common/file_utils.dart';
import 'package:aidm/core/utils/app/responsive_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FileTypeBadge extends StatelessWidget {
  const FileTypeBadge({super.key, required this.fileName});

  final String fileName;

  @override
  Widget build(BuildContext context) {
    final visual = FileUtils.getFileTypeVisual(fileName);

    return SvgPicture.asset(visual.iconPath, width: 34.sp, height: 40.sp);
  }
}
