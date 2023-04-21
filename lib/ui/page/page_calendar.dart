import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/hour.dart';
import '../provider/provider_principal.dart';
import '../provider/provider_reserve.dart';
import '../util/global_color.dart';
import '../util/global_function.dart';
import '../util/global_label.dart';
import '../util/global_widget.dart';

class PageCalendar extends StatelessWidget {
  static const route = GlobalLabel.routeCalendar;
  ProviderReserve? _providerReserve;
  ProviderPrincipal? _providerPrincipal;

  @override
  Widget build(BuildContext context) {
    if (_providerReserve == null) {
      _providerReserve = Provider.of<ProviderReserve>(context);
      _providerPrincipal = Provider.of<ProviderPrincipal>(context);
      _providerPrincipal!.addReserve(
          _providerReserve!,
          GlobalFunction().formatterDate.format(GlobalFunction().dateNow),
          GlobalFunction().dateNow);
    }

    return AnnotatedRegion(
        value: GlobalWidget().colorBarView(GlobalColor.colorWhite),
        child: Scaffold(
          appBar: GlobalWidget().titleBar(GlobalLabel.textSelectReserve),
          body: SafeArea(
              child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(3),
                  height: MediaQuery.of(context).size.height,
                  color: GlobalColor.colorBackground,
                  child: Column(
                    children: [
                      Expanded(flex: 0, child: calendar()),
                      Expanded(flex: 1, child: gridHour())
                    ],
                  ))),
        ));
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
        DateTime dateValue = date;
        _providerPrincipal!.addReserve(_providerReserve!,
            GlobalFunction().formatterDate.format(dateValue), dateValue);
      },
    );
  }

  Widget gridHour() {
    return SingleChildScrollView(
      child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 10.0,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          children: List.generate(
              _providerReserve!.listResult!.isEmpty
                  ? 0
                  : _providerReserve!.listResult!.length, (index) {
            return itemHour(_providerReserve!.listResult![index], index);
          })),
    );
  }

  Widget itemHour(Hour hour, int index) {
    return GestureDetector(
      onTap: () {
        if (hour.state != 1) return;
        _providerReserve!.selectedHour = hour.hour!;
        GlobalFunction().closeView();
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: _providerReserve!.colorStateHour(hour.state!),
          border: Border.all(width: 1.0, color: GlobalColor.colorWhite),
        ),
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GlobalWidget().styleTextTitle(
                hour.hour!, GlobalColor.colorWhite, 25.0, TextAlign.center),
            GlobalWidget().styleTextTitle(
                _providerReserve!.stateHour(hour.state!),
                GlobalColor.colorWhite,
                14.0,
                TextAlign.center),
          ],
        ),
      ),
    );
  }
}
