// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'dart:async';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:dttv/controller/lifecycle_event_handler.dart';
import 'package:dttv/controller/network_connect.dart';
import 'package:dttv/import.dart';
import 'package:dttv/loading_wrapper.dart';
import 'package:dttv/utils/localization_service.dart';

import 'global/app_router.dart';
import 'global/app_theme.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with BaseMixin {
  final LifecycleEventHandler _lifecycleEventHandler = LifecycleEventHandler();
  late StreamSubscription<AppLifecycleState> _streamSubscriptionLifeCycle;

  @override
  void initState() {
    super.initState();
    _streamSubscriptionLifeCycle = _lifecycleEventHandler.streamNotifyLifecycle
        .listen(_listenerLifecycleEvent);
  }

  @override
  void dispose() {
    _streamSubscriptionLifeCycle.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      footerTriggerDistance: 15,
      headerTriggerDistance: 20,
      enableScrollWhenRefreshCompleted: true,
      // headerBuilder: buildHeaderSmartRefresh,
      // footerBuilder: buildFooterSmartRefresh,
      dragSpeedRatio: 0.5,
      child: GetMaterialApp(
        enableLog: true,
        translations: LocalizationService(),
        translationsKeys: AppTranslation.translations,
        locale: LocalizationService.locale,
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          RefreshLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: LocalizationService.locales,
        fallbackLocale: LocalizationService.fallbackLocale,
        color: color.grey0,
        debugShowCheckedModeBanner: false,
        title: 'PCM',
        theme: Get.find<AppThemeBase>().themeData,
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: LoadingWrapper(child: NetWorkConnect(child: child)),
          );
        },
        initialRoute: AppRouter.routerSplash,
        getPages: AppRouter.getPages,
        defaultTransition: Transition.topLevel,
        transitionDuration: const Duration(milliseconds: 1000),
      ),
    );
  }

  void _listenerLifecycleEvent(AppLifecycleState event) {}
}
