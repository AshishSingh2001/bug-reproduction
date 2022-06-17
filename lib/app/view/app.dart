// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:bug_reproduction/counter/counter.dart';
import 'package:bug_reproduction/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';

class App extends StatelessWidget {
  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      routeInformationProvider: _router.routeInformationProvider,
      title: 'Hello',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
      ),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }

  // ignore: avoid_field_initializers_in_const_classes
  final _router = GoRouter(
    initialLocation: '/counter/1',
    debugLogDiagnostics: true,
    routes: [
      // GoRoute(
      //   path: '/',
      //   redirect: (_) => '/counter/0',
      // ),
      GoRoute(
        path: '/counter/:id',
        builder: (_, state) => CounterPage(
          initialValue: int.parse(state.params['id']!),
        ),
      ),
    ],
  );
}

// class App extends StatelessWidget {
//   App({Key? key}) : super(key: key);

//   static const title = 'GoRouter Example: Initial Location';

//   @override
//   Widget build(BuildContext context) => MaterialApp.router(
//         routeInformationParser: _router.routeInformationParser,
//         routerDelegate: _router.routerDelegate,
//         title: title,
//       );

//   final _router = GoRouter(
//     initialLocation: '/page3',
//     routes: [
//       GoRoute(
//         path: '/',
//         builder: (context, state) => const Page1Screen(),
//       ),
//       GoRoute(
//         path: '/page2',
//         builder: (context, state) => const Page2Screen(),
//       ),
//       GoRoute(
//         path: '/page3',
//         builder: (context, state) => const Page3Screen(),
//       ),
//     ],
//   );
// }
