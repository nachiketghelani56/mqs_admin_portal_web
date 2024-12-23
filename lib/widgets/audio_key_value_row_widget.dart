import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mqs_admin_portal_web/config/font_text_style_config.dart';
import 'package:mqs_admin_portal_web/config/size_config.dart';
import 'package:mqs_admin_portal_web/views/pathway/controller/pathway_controller.dart';

Widget audioKeyValueRowWidget(
    {required String key,
    String value = "",
    bool isImage = false,
    bool isFirst = false,
    isLast = false,
    Widget? widget,
    child,
    Function? onTap,
    required String url,
    required PathwayController audioController}) {
  return Container(
    padding: const EdgeInsets.symmetric(
        horizontal: SizeConfig.size14, vertical: SizeConfig.size14),
    decoration: isFirst
        ? FontTextStyleConfig.headerDecoration
        : FontTextStyleConfig.contentDecoration.copyWith(
            borderRadius: isLast
                ? const BorderRadius.vertical(
                    bottom: Radius.circular(SizeConfig.size12),
                  )
                : null,
          ),
    child: Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: SizeConfig.size2.toInt(),
              child: Text(
                key,
                style: FontTextStyleConfig.tableBottomTextStyle,
              ),
            ),
            Expanded(
                flex: SizeConfig.size4.toInt(),
                child: Obx(
                  () {
                    final isCurrent = audioController.currentUrl.value == url;

                    return Padding(
                      padding: const EdgeInsets.all(SizeConfig.size16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Play/Pause Button
                          GestureDetector(
                            onTap: () {
                              audioController.playNewAudio(url);
                            },
                            child: Icon(
                              isCurrent && audioController.audioPlayer.playing
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              size: SizeConfig.size25,
                            ),
                          ),
                          const SizedBox(height: SizeConfig.size10),
                          if (isCurrent)
                            Column(
                              children: [
                                if (audioController.totalDuration.value > 0 &&
                                    audioController.currentPosition.value >=
                                        0 &&
                                    audioController.currentPosition.value <=
                                        audioController.totalDuration.value)
                                  Slider(
                                    min: 0.0,
                                    max: audioController.totalDuration.value,
                                    value:
                                        audioController.currentPosition.value,
                                    onChanged: (value) {
                                      audioController.seekTo(value);
                                    },
                                  ),

                                const SizedBox(height: SizeConfig.size5),
                                // Time indicator
                                Text(
                                  "${Duration(milliseconds: audioController.currentPosition.value.toInt()).toString().split('.').first} / ${Duration(milliseconds: audioController.totalDuration.value.toInt()).toString().split('.').first}",
                                  style: const TextStyle(
                                      fontSize: SizeConfig.size14),
                                ),
                              ],
                            ),
                        ],
                      ),
                    );
                  },
                ))
          ],
        )
      ],
    ),
  );
}
