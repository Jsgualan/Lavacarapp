import 'package:calendar_agenda/calendar_agenda.dart';
import 'package:flutter/material.dart';
import 'package:lavacar/ui/provider/provider_service.dart';
import 'package:provider/provider.dart';

import '../../domain/entities/booking.dart';
import '../provider/provider_principal.dart';
import '../provider/provider_reserve.dart';
import '../util/global_color.dart';
import '../util/global_function.dart';
import '../util/global_label.dart';
import '../util/global_widget.dart';
import 'page_detail_reserve.dart';
import 'page_notification.dart';
import 'page_profile.dart';
import 'page_register_reserve.dart';

class PagePrincipal extends StatefulWidget {
  static const route = GlobalLabel.routePrincipal;

  @override
  State<PagePrincipal> createState() => _PagePrincipalState();
}

class _PagePrincipalState extends State<PagePrincipal> {
  ProviderPrincipal? _providerPrincipal;
  ProviderReserve? _providerReserve;
  ProviderService? _providerService;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_providerPrincipal == null) {
      _providerPrincipal = Provider.of<ProviderPrincipal>(context);
      _providerReserve = Provider.of<ProviderReserve>(context);
      _providerService = Provider.of<ProviderService>(context);
      _providerPrincipal!.dateTimeSelected = GlobalFunction().dateNow;
      _providerPrincipal!.addReserve(
          _providerReserve!,
          GlobalFunction().formatterDate.format(GlobalFunction().dateNow),
          GlobalFunction().dateNow);
      _providerPrincipal!.notificationPush(_providerReserve!);
      _providerService!.getListService();
    }

    return AnnotatedRegion(
        value: GlobalWidget().colorBarView(GlobalColor.colorWhite),
        child: Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(
            child: PageProfile(),
          ),
          body: SafeArea(
              child: Container(
            width: double.infinity,
            margin: const EdgeInsets.all(3),
            height: MediaQuery.of(context).size.height,
            color: GlobalColor.colorBackground,
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(flex: 0, child: menu()),
                    Expanded(flex: 1, child: listReserve())
                  ],
                ),
              ],
            ),
          )),
        ));
  }

  Widget menu() {
    return Column(
      children: [
        Container(
          height: 60,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.only(right: 15, left: 10),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: GlobalColor.colorBackgroundView.withOpacity(.2),
                blurRadius: 2.0,
              ),
            ],
            color: GlobalColor.colorWhite,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(
              color: GlobalColor.colorBorder,
              width: .5,
            ),
          ),
          child: Row(
            children: [
              Expanded(
                  child: GestureDetector(
                onTap: () {
                  _scaffoldKey.currentState!.openDrawer();
                },
                child: Row(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(right: 20),
                        child: const Icon(Icons.menu)),
                    GlobalWidget().styleTextTitle(
                        '${GlobalLabel.textHello} ${_providerPrincipal!.user.name}',
                        GlobalColor.colorLetterTitle,
                        20,
                        TextAlign.left),
                  ],
                ),
              )),
              Expanded(
                flex: 0,
                child: GestureDetector(
                    onTap: () {
                      if (_providerPrincipal!.user.rol == 1) {
                        GlobalWidget()
                            .animationNavigatorView(PageNotification());
                      } else {
                        _providerPrincipal!.logOut();
                      }
                    },
                    child: Visibility(
                      visible: _providerPrincipal!.user.rol == 1 ? true : false,
                      child: Badge(
                          isLabelVisible:
                              _providerPrincipal!.listNotification!.isNotEmpty
                                  ? true
                                  : false,
                          backgroundColor:
                              _providerPrincipal!.listNotification!.isNotEmpty
                                  ? Colors.red
                                  : Colors.white,
                          textColor:
                              _providerPrincipal!.listNotification!.isNotEmpty
                                  ? Colors.red
                                  : Colors.white,
                          textStyle: const TextStyle(
                              color: Colors.white, fontSize: 10),
                          label: Text(_providerPrincipal!
                              .listNotification!.length
                              .toString()),
                          child: const Icon(Icons.notifications)),
                    )),
              )
            ],
          ),
        ),
        calendar(),
        filterOption(),
      ],
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
        _providerPrincipal!.dateTimeSelected = date;
        DateTime dateTime = date;
        _providerPrincipal!.addReserve(_providerReserve!,
            GlobalFunction().formatterDate.format(date), dateTime);
      },
    );
  }

  Widget filterOption() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
      child: Row(
        children: [
          Expanded(
              flex: 1,
              child: Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: GlobalColor.colorBackgroundView.withOpacity(.2),
                        blurRadius: 1.0,
                      ),
                    ],
                    color: GlobalColor.colorWhite,
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: GlobalColor.colorBorder,
                      width: .1,
                    ),
                  ),
                  child: Column(
                    children: [
                      GlobalWidget().styleTextTitle(GlobalLabel.textPending,
                          GlobalColor.colorLetterTitle, 0, TextAlign.center),
                      GlobalWidget().styleTextTitle(
                          '${_providerPrincipal!.countPending}',
                          GlobalColor.colorLetterTitle,
                          0,
                          TextAlign.center),
                    ],
                  ))),
          Expanded(
              flex: 1,
              child: Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: GlobalColor.colorBackgroundView.withOpacity(.2),
                        blurRadius: 1.0,
                      ),
                    ],
                    color: GlobalColor.colorWhite,
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(
                      color: GlobalColor.colorBorder,
                      width: .1,
                    ),
                  ),
                  child: Column(
                    children: [
                      GlobalWidget().styleTextTitle(GlobalLabel.textFinish,
                          GlobalColor.colorLetterTitle, 0, TextAlign.center),
                      GlobalWidget().styleTextTitle(
                          '${_providerPrincipal!.countFinish}',
                          GlobalColor.colorLetterTitle,
                          0,
                          TextAlign.center),
                    ],
                  ))),
          Visibility(
            visible: _providerPrincipal!.user.rol != 3 ? true : false,
            child: Expanded(
                flex: 1,
                child: Container(
                  margin: const EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: () {
                      _providerReserve!.setDataUser(_providerPrincipal!);
                      _providerReserve!.cleanReserve();
                      Navigator.of(GlobalFunction.contextGlobal.currentContext!)
                          .pushNamed(PageRegisterReserve.route,
                              arguments: {'type': 1});
                    },
                    child: Container(
                        height: 45,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: GlobalColor.colorBackgroundView
                                  .withOpacity(.2),
                              blurRadius: 1.0,
                            ),
                          ],
                          color: GlobalColor.colorWhite,
                          borderRadius: BorderRadius.circular(5.0),
                          border: Border.all(
                            color: GlobalColor.colorBorder,
                            width: .1,
                          ),
                        ),
                        child: Column(
                          children: [
                            GlobalWidget().styleTextTitle(
                                GlobalLabel.textAdd,
                                GlobalColor.colorLetterTitle,
                                0,
                                TextAlign.center),
                            const Icon(
                              Icons.add,
                              size: 15,
                            )
                          ],
                        )),
                  ),
                )),
          ),
        ],
      ),
    );
  }

  Widget listReserve() {
    return Visibility(
      visible: _providerPrincipal!.listReserve!.isNotEmpty,
      child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
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
            itemCount: _providerPrincipal!.listReserve!.length,
            itemBuilder: (context, index) {
              return itemReserve(
                  _providerPrincipal!.listReserve![index], index);
            },
          ),
        ),
      ),
    );
  }

  Widget itemReserve(Booking booking, int index) {
    return GestureDetector(
      onTap: () {
        _providerPrincipal!.bookingActive(booking);
        GlobalWidget().animationNavigatorView(PageDetailReserve());
      },
      child: Container(
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
                          TextAlign.left)
                    ],
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Column(
                    children: [
                      booking.typeService == 2
                          ? CircleAvatar(
                              radius: 15,
                              backgroundColor: booking.state == 2
                                  ? GlobalColor.colorPrincipal
                                  : GlobalColor.colorRed,
                              child: const Icon(Icons.home,
                                  color: GlobalColor.colorWhite),
                            )
                          : CircleAvatar(
                              radius: 15,
                              backgroundColor: booking.state == 2
                                  ? GlobalColor.colorPrincipal
                                  : GlobalColor.colorRed,
                              child: const Icon(
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
                      GlobalWidget().styleTextSubTitle(booking.hour!,
                          GlobalColor.colorLetterSubTitle, 14, TextAlign.left)
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 5),
            GlobalWidget().divider(),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
