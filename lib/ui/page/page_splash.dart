import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/provider_principal.dart';
import '../provider/provider_splash.dart';
import '../util/global_color.dart';
import '../util/global_label.dart';
import '../util/global_widget.dart';

class PageSplash extends StatefulWidget {
  static const route = GlobalLabel.routeSplash;

  @override
  State<PageSplash> createState() => _PageSplashState();
}

class _PageSplashState extends State<PageSplash> {
  ProviderSplash? _providerSplash;
  ProviderPrincipal? _providerPrincipal;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_providerSplash == null) {
      _providerSplash = Provider.of<ProviderSplash>(context);
      _providerPrincipal = Provider.of<ProviderPrincipal>(context);
      _providerSplash!.startApplication(_providerPrincipal!);
    }
  }

  @override
  Widget build(BuildContext context) {
    _providerSplash ??= Provider.of<ProviderSplash>(context);
    return AnnotatedRegion(
      value: GlobalWidget().colorBarSplash(GlobalColor.colorWhite),
      child: Scaffold(
        backgroundColor: GlobalColor.colorWhite,
        body: SafeArea(
            child: Center(
          child: Stack(
            children: [logo(), owner()],
          ),
        )),
      ),
    );
  }

  Widget logo() {
    return const Center(
      child: Image(
          image: AssetImage('${GlobalLabel.directionImageInternal}logo.png')),
    );
  }

  Widget owner() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: GlobalWidget().styleTextSubTitle(GlobalLabel.textOwner,
          GlobalColor.colorLetterSubTitle, 0, TextAlign.left),
    );
  }
}
