import 'package:flutter/material.dart';
import 'package:mqs_admin_portal_web/config/config.dart';
import 'package:mqs_admin_portal_web/extensions/ext_on_num.dart';
import 'package:mqs_admin_portal_web/views/pathway/controller/pathway_controller.dart';

Widget pracActivityListWidget({required PathwayController pathwayController}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (pathwayController.mqsPracticeActivity.isNotEmpty) ...[
        SizeConfig.size30.height,
        Container(
          height: SizeConfig.size55,
          padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
          decoration: FontTextStyleConfig.headerDecoration,
          child: Row(
            children: [
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Text(
                  StringConfig.pathway.activityID,
                  style: FontTextStyleConfig.tableBottomTextStyle,
                ),
              ),
              Expanded(
                flex: SizeConfig.size3.toInt(),
                child: Text(
                  StringConfig.pathway.activityTitle,
                  style: FontTextStyleConfig.tableBottomTextStyle,
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        ),
        for (int i = 0; i < pathwayController.mqsPracticeActivity.length; i++)
          Container(
            height: SizeConfig.size55,
            padding: const EdgeInsets.symmetric(horizontal: SizeConfig.size14),
            decoration: i == pathwayController.mqsPracticeActivity.length - 1
                ? FontTextStyleConfig.contentDecoration.copyWith(
                    borderRadius: const BorderRadius.vertical(
                      bottom: Radius.circular(SizeConfig.size12),
                    ),
                  )
                : FontTextStyleConfig.contentDecoration,
            child: Row(
              children: [
                Expanded(
                  flex: SizeConfig.size3.toInt(),
                  child: Text(
                    pathwayController.mqsPracticeActivity[i].id,
                    style: FontTextStyleConfig.tableContentTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  flex: SizeConfig.size3.toInt(),
                  child: Text(
                    pathwayController.mqsPracticeActivity[i].mqsActivityTitle,
                    style: FontTextStyleConfig.tableContentTextStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  child: PopupMenuButton<int>(
                    icon: const Icon(
                      Icons.more_vert,
                      color: ColorConfig.textFieldBorderColor,
                    ),
                    iconSize: SizeConfig.size22,
                    onSelected: (value) {
                      if (value == 0) {
                        pathwayController.setPracActivtyForm(index: i);
                      } else if (value == 1) {
                        pathwayController.removePracActivity(index: i);
                      }
                    },
                    itemBuilder: (context) {
                      return [
                        for (int i = 0;
                            i < pathwayController.options.length;
                            i++)
                          PopupMenuItem<int>(
                            value: i,
                            child: Container(
                              width: SizeConfig.size140,
                              padding: const EdgeInsets.all(SizeConfig.size8),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Image.asset(
                                    pathwayController.options[i].icon,
                                    height: SizeConfig.size24,
                                  ),
                                  SizeConfig.size15.width,
                                  Expanded(
                                    child: Text(
                                      pathwayController.options[i].title,
                                      style: FontTextStyleConfig.tableTextStyle
                                          .copyWith(
                                              color: pathwayController
                                                  .options[i].color),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ];
                    },
                  ),
                ),
              ],
            ),
          ),
      ],
    ],
  );
}
