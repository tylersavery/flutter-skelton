import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import "../generated/l10n.dart";
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_skeleton/src/config/constants/breakpoints.dart';
import 'package:flutter_skeleton/src/core/app/singletons.dart';
import 'package:flutter_skeleton/src/core/app_router.gr.dart';
import 'package:flutter_skeleton/src/feature/theme/theme_provider.dart';
import 'package:flutter_skeleton/src/utils/debugger.dart';
import 'package:responsive_framework/responsive_framework.dart';

GlobalKey<State<BottomNavigationBar>> bottomNavigationBar =
    GlobalKey<State<BottomNavigationBar>>();

GlobalKey<NavigatorState> rootNavigatorKey =
    singleton<AppRouter>().navigatorKey;

final GlobalKey<ScaffoldMessengerState> rootScaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

class App extends ConsumerWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = singleton<AppRouter>();

    Debugger.log("App bootstraped");

    return MaterialApp.router(
      restorationScopeId: 'app',
      debugShowCheckedModeBanner: false,

      scaffoldMessengerKey: rootScaffoldMessengerKey,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      themeMode: ref.watch(themeProvider),
      routeInformationParser:
          appRouter.defaultRouteParser(includePrefixMatches: true),
      routerDelegate: AutoRouterDelegate(
        appRouter,
        // Provide an AutoRouteObserver instance
        navigatorObservers: () => [AutoRouteObserver()],
      ),
      builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget!),
        defaultScale: true,
        breakpoints: BreakPoints.breakpoints,
      ),
      // initialRoute: '/home',
    );
  }
}