import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/booking.dart';
import '../provider/provider_principal.dart';
import '../provider/provider_reserve.dart';
import '../util/global_color.dart';
import '../util/global_function.dart';
import '../util/global_label.dart';
import '../util/global_widget.dart';

class PageNotification extends StatelessWidget {
  static const route = GlobalLabel.routeNotification;
  ProviderPrincipal? _providerPrincipal;
  ProviderReserve? _providerReserve;

  @override
  Widget build(BuildContext context) {
    if (_providerPrincipal == null) {
      _providerPrincipal = Provider.of<ProviderPrincipal>(context);
      _providerReserve = Provider.of<ProviderReserve>(context);
      _providerPrincipal!.addReserve(
          _providerReserve!,
          GlobalFunction().formatterDate.format(GlobalFunction().dateNow),
          GlobalFunction().dateNow);
    }

    return AnnotatedRegion(
        value: GlobalWidget().colorBarView(GlobalColor.colorWhite),
        child: Scaffold(
          appBar: GlobalWidget().titleBar(GlobalLabel.textNotification),
          body: SafeArea(
              child: _providerPrincipal!.listNotification!.isEmpty &&
                      !_providerPrincipal!.contListNotification
                  ? const Center(child: CircularProgressIndicator())
                  : Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(3),
                      height: MediaQuery.of(context).size.height,
                      color: GlobalColor.colorBackground,
                      child: Column(
                        children: [
                          calendar(),
                          Expanded(flex: 0, child: message()),
                          Expanded(flex: 1, child: listReserve())
                        ],
                      ),
                    )),
        ));
  }

  Widget message() {
    return Visibility(
      visible: !_providerPrincipal!.contListNotification,
      child: GlobalWidget().messageInformative(
          GlobalLabel.textTitleNotification,
          GlobalLabel.textDescriptionNotification),
    );
  }

  Widget calendar() {
    return CalendarAgenda(
      backgroundColor: GlobalColor.colorBackgroundView,
      locale: 'es',
      selectedDayPosition: SelectedDayPosition.left,
      weekDay: WeekDay.long,
      fullCalendarDay: WeekDay.short,
      initialDate: GlobalFunction().dateNow,
      firstDate: GlobalFunction().dateNow,
      lastDate: DateTime.now().add(const Duration(days: 30)),
      onDateSelected: (date) {
        DateTime dateTime = date;
        _providerPrincipal!.addReserve(_providerReserve!,
            GlobalFunction().formatterDate.format(date), dateTime);
      },
    );
  }

  Widget listReserve() {
    return !_providerPrincipal!.contListNotification
        ? SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 40, left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: GlobalColor.colorWhite,
                border: Border.all(width: 1.0, color: GlobalColor.colorWhite),
              ),
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: _providerPrincipal!.listNotification!.length,
                itemBuilder: (context, index) {
                  return itemReserve(
                      _providerPrincipal!.listNotification![index], index);
                },
              ),
            ),
          )
        : GlobalWidget().noResult(GlobalLabel.textNoResult);
  }

  Widget itemReserve(Booking booking, int index) {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GlobalWidget().styleTextTitle(
                        '${booking.nameUser} ${booking.lastNameUser}',
                        GlobalColor.colorLetterTitle,
                        0,
                        TextAlign.left),
                    const SizedBox(height: 5),
                    GlobalWidget().styleTextSubTitle(booking.numberLate!,
                        GlobalColor.colorLetterSubTitle, 0, TextAlign.left),
                    GlobalWidget().styleTextSubTitle(booking.typeVehicle!,
                        GlobalColor.colorLetterSubTitle, 0, TextAlign.left),
                    GlobalWidget().styleTextSubTitle(
                        '${booking.brand!} ${booking.model!}',
                        GlobalColor.colorLetterSubTitle,
                        0,
                        TextAlign.left),
                    GlobalWidget().styleTextSubTitle(
                        booking.descriptionService!,
                        GlobalColor.colorLetterSubTitle,
                        0,
                        TextAlign.left)
                  ],
                ),
              ),
              Expanded(
                flex: 0,
                child: Column(
                  children: [
                    booking.typeService == 2
                        ? const CircleAvatar(
                            radius: 15,
                            backgroundColor: GlobalColor.colorPrincipal,
                            child:
                                Icon(Icons.home, color: GlobalColor.colorWhite),
                          )
                        : const CircleAvatar(
                            radius: 15,
                            backgroundColor: GlobalColor.colorPrincipal,
                            child: Icon(
                              Icons.store,
                              color: GlobalColor.colorWhite,
                            ),
                          ),
                    GlobalWidget().styleTextSubTitle(
                        booking.typeService == 2
                            ? GlobalLabel.textHome
                            : GlobalLabel.textBusiness,
                        GlobalColor.colorLetterSubTitle,
                        14,
                        TextAlign.left),
                    GlobalWidget().styleTextSubTitle('${booking.date}',
                        GlobalColor.colorLetterSubTitle, 14, TextAlign.left),
                    GlobalWidget().styleTextSubTitle(booking.hour!,
                        GlobalColor.colorLetterSubTitle, 14, TextAlign.left)
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  width: double.infinity,
                  height: 30,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                    child: GlobalWidget()
                        .styleTextButton(GlobalLabel.buttonDecline),
                    onPressed: () {
                      GlobalFunction().messageConfirmation(
                          GlobalLabel.textQuestionDecline, () {
                        _providerPrincipal!
                            .declineNotification(booking.idReserve!);
                      });
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  width: double.infinity,
                  height: 30,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                    child: GlobalWidget()
                        .styleTextButton(GlobalLabel.buttonAddOperator),
                    onPressed: () {
                      _providerPrincipal!
                          .addOperatorReserve(booking.idReserve!, booking);
                    },
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          GlobalWidget().divider(),
        ],
      ),
    );
  }
}
