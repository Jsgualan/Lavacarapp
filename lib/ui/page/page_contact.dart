import 'package:flutter/material.dart';

import '../util/global_color.dart';
import '../util/global_label.dart';
import '../util/global_widget.dart';

class PageContact extends StatelessWidget {
  static const route = GlobalLabel.routeContact;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
        value: GlobalWidget().colorBarView(GlobalColor.colorWhite),
        child: Scaffold(
          appBar: GlobalWidget().titleBar(GlobalLabel.textContact),
          body: SafeArea(
              child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(3),
            padding: const EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height,
            color: GlobalColor.colorWhite,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Image(
                    image: AssetImage(
                        '${GlobalLabel.directionImageInternal}logo.png'),
                  ),
                  GlobalWidget().styleTextTitle(GlobalLabel.textTitleMission,
                      GlobalColor.colorLetterTitle, 0.0, TextAlign.left),
                  GlobalWidget().styleTextSubTitle(GlobalLabel.textMission,
                      GlobalColor.colorLetterSubTitle, 0.0, TextAlign.left),
                  const SizedBox(height: 20),
                  GlobalWidget().styleTextTitle(GlobalLabel.textTitleVision,
                      GlobalColor.colorLetterTitle, 0.0, TextAlign.left),
                  GlobalWidget().styleTextSubTitle(GlobalLabel.textVision,
                      GlobalColor.colorLetterSubTitle, 0.0, TextAlign.left),
                  const SizedBox(height: 20),
                  GlobalWidget().styleTextTitle(GlobalLabel.textTitleValue,
                      GlobalColor.colorLetterTitle, 0.0, TextAlign.left),
                  const SizedBox(height: 10),
                  GlobalWidget().styleTextSubTitle(GlobalLabel.textValue,
                      GlobalColor.colorLetterSubTitle, 0.0, TextAlign.left),
                  const SizedBox(height: 20),
                  GlobalWidget().styleTextTitle(GlobalLabel.textContact,
                      GlobalColor.colorLetterTitle, 0.0, TextAlign.left),
                  const SizedBox(height: 10),
                  GlobalWidget().styleTextSubTitle(GlobalLabel.textNumber,
                      GlobalColor.colorLetterSubTitle, 0.0, TextAlign.left),
                  GlobalWidget().styleTextSubTitle(GlobalLabel.textEmailContact,
                      GlobalColor.colorLetterSubTitle, 0.0, TextAlign.left),
                  const SizedBox(height: 20),
                  GlobalWidget().styleTextTitle(GlobalLabel.textOpeningHour,
                      GlobalColor.colorLetterTitle, 0.0, TextAlign.left),
                  const SizedBox(height: 10),
                  GlobalWidget().styleTextSubTitle(GlobalLabel.textDay,
                      GlobalColor.colorLetterSubTitle, 0.0, TextAlign.left),
                  GlobalWidget().styleTextSubTitle(GlobalLabel.textDayHour,
                      GlobalColor.colorLetterSubTitle, 0.0, TextAlign.left),
                  GlobalWidget().styleTextSubTitle(GlobalLabel.textSaturday,
                      GlobalColor.colorLetterSubTitle, 0.0, TextAlign.left),
                  GlobalWidget().styleTextSubTitle(GlobalLabel.textSaturdayHour,
                      GlobalColor.colorLetterSubTitle, 0.0, TextAlign.left),
                ],
              ),
            ),
          )),
        ));
  }
}
