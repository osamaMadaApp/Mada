// import '../../pages/projects_listview/projects_listview.dart';
// import 'dart:async';
//
// import '/backend/schema/structs/index.dart';
// import '/structure_main_flow/flutter_mada_util.dart';
// import '../../api/routes_keys.dart';
// import '../../general_exports.dart';
// import '../../pages/exclusive_projects/exclusive_projects.dart';
// import '../../pages/login_page/login_page_widget.dart';
//
// export 'package:go_router/go_router.dart';
//
// export 'serialization_util.dart';
//
// const kTransitionInfoKey = '__transition_info__';
//
// GoRouter createRouter(AppProvider appStateNotifier) => GoRouter(
//       initialLocation: '/',
//       debugLogDiagnostics: true,
//       refreshListenable: appStateNotifier,
//       errorBuilder: (context, state) => const LoginPageWidget(),
//       routes: [
//         FFRoute(
//           name: routeProjectsListview,
//           path: routeProjectsListview.toRoutePath(),
//           builder: (context, params) => ProjectsListview(
//             keyTitle: params.getParam('keyTitle', ParamType.String),
//             keyProjectStatus:
//                 params.getParam('keyProjectStatus', ParamType.String),
//             keyType: params.getParam('keyType', ParamType.String),
//           ),
//         ),
//         FFRoute(
//           name: routeExclusiveProjects,
//           path: routeExclusiveProjects.toRoutePath(),
//           builder: (context, params) => const ExclusiveProjects(),
//         ),
//         FFRoute(
//           name: '_initialize',
//           path: '/',
//           builder: (context, _) => FFAppState().isLoggedIn() == true
//               ? const NavBarPage()
//               : const LoginPageWidget(),
//         ),
//         FFRoute(
//           name: routeHome,
//           path: routeHome.toRoutePath(),
//           builder: (context, params) => const NavBarPage(),
//         ),
//         FFRoute(
//           name: routeLogin,
//           path: '/loginPage',
//           builder: (context, params) => const LoginPageWidget(),
//         ),
//       ].map((r) => r.toRoute(appStateNotifier)).toList(),
//     );
//
// extension NavParamExtensions on Map<String, String?> {
//   Map<String, String> get withoutNulls => Map.fromEntries(
//         entries
//             .where((e) => e.value != null)
//             .map((e) => MapEntry(e.key, e.value!)),
//       );
// }
//
// extension NavigationExtensions on BuildContext {
//   void goNamedAuth(
//     String name,
//     bool mounted, {
//     Map<String, String> pathParameters = const <String, String>{},
//     Map<String, String> queryParameters = const <String, String>{},
//     Object? extra,
//     bool ignoreRedirect = false,
//   }) =>
//       !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
//           ? null
//           : goNamed(
//               name,
//               pathParameters: pathParameters,
//               queryParameters: queryParameters,
//               extra: extra,
//             );
//
//   void pushNamedAuth(
//     String name,
//     bool mounted, {
//     Map<String, String> pathParameters = const <String, String>{},
//     Map<String, String> queryParameters = const <String, String>{},
//     Object? extra,
//     bool ignoreRedirect = false,
//   }) =>
//       !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
//           ? null
//           : pushNamed(
//               name,
//               pathParameters: pathParameters,
//               queryParameters: queryParameters,
//               extra: extra,
//             );
//
//   void safePop() {
//     // If there is only one route on the stack, navigate to the initial
//     // page instead of popping.
//     if (canPop()) {
//       pop();
//     } else {
//       go('/');
//     }
//   }
// }
//
// extension GoRouterExtensions on GoRouter {
//   AppProvider get appState => AppProvider.instance;
//
//   void prepareAuthEvent([bool ignoreRedirect = false]) =>
//       appState.hasRedirect() && !ignoreRedirect
//           ? null
//           : appState.updateNotifyOnAuthChange(false);
//
//   bool shouldRedirect(bool ignoreRedirect) =>
//       !ignoreRedirect && appState.hasRedirect();
//
//   void clearRedirectLocation() => appState.clearRedirectLocation();
//
//   void setRedirectLocationIfUnset(String location) =>
//       appState.updateNotifyOnAuthChange(false);
// }
//
// extension _GoRouterStateExtensions on GoRouterState {
//   Map<String, dynamic> get extraMap =>
//       extra != null ? extra as Map<String, dynamic> : {};
//
//   Map<String, dynamic> get allParams => <String, dynamic>{}
//     ..addAll(pathParameters)
//     ..addAll(uri.queryParameters)
//     ..addAll(extraMap);
//
//   TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
//       ? extraMap[kTransitionInfoKey] as TransitionInfo
//       : TransitionInfo.appDefault();
// }
//
// class FFParameters {
//   FFParameters(this.state, [this.asyncParams = const {}]);
//
//   final GoRouterState state;
//   final Map<String, Future<dynamic> Function(String)> asyncParams;
//
//   Map<String, dynamic> futureParamValues = {};
//
//   // Parameters are empty if the params map is empty or if the only parameter
//   // present is the special extra parameter reserved for the transition info.
//   bool get isEmpty =>
//       state.allParams.isEmpty ||
//       (state.allParams.length == 1 &&
//           state.extraMap.containsKey(kTransitionInfoKey));
//
//   bool isAsyncParam(MapEntry<String, dynamic> param) =>
//       asyncParams.containsKey(param.key) && param.value is String;
//
//   bool get hasFutures => state.allParams.entries.any(isAsyncParam);
//
//   Future<bool> completeFutures() => Future.wait(
//         state.allParams.entries.where(isAsyncParam).map(
//           (param) async {
//             final doc = await asyncParams[param.key]!(param.value)
//                 .onError((_, __) => null);
//             if (doc != null) {
//               futureParamValues[param.key] = doc;
//               return true;
//             }
//             return false;
//           },
//         ),
//       ).onError((_, __) => [false]).then((v) => v.every((e) => e));
//
//   dynamic getParam<T>(
//     String paramName,
//     ParamType type, {
//     bool isList = false,
//     StructBuilder<T>? structBuilder,
//   }) {
//     if (futureParamValues.containsKey(paramName)) {
//       return futureParamValues[paramName];
//     }
//     if (!state.allParams.containsKey(paramName)) {
//       return null;
//     }
//     final param = state.allParams[paramName];
//     // Got parameter from `extras`, so just directly return it.
//     if (param is! String) {
//       return param;
//     }
//     // Return serialized value.
//     return deserializeParam<T>(
//       param,
//       type,
//       isList,
//       structBuilder: structBuilder,
//     );
//   }
// }
//
// class FFRoute {
//   FFRoute({
//     required this.name,
//     required this.path,
//     required this.builder,
//     this.requireAuth = false,
//     this.asyncParams = const {},
//     this.routes = const [],
//   });
//
//   final String name;
//   final String path;
//   final bool requireAuth;
//   final Map<String, Future<dynamic> Function(String)> asyncParams;
//   final Widget Function(BuildContext, FFParameters) builder;
//   final List<GoRoute> routes;
//
//   // late final String? isNavigatingToPath;
//
//   GoRoute toRoute(AppProvider appStateNotifier) => GoRoute(
//         name: name,
//         path: path,
//         redirect: (context, state) {
//           return null;
//         },
//         pageBuilder: (context, state) {
//           fixStatusBarOniOS16AndBelow(context);
//           final ffParams = FFParameters(state, asyncParams);
//           final page = ffParams.hasFutures
//               ? FutureBuilder(
//                   future: ffParams.completeFutures(),
//                   builder: (context, _) => builder(context, ffParams),
//                 )
//               : builder(context, ffParams);
//           final child = page;
//           final transitionInfo = state.transitionInfo;
//           return transitionInfo.hasTransition
//               ? CustomTransitionPage(
//                   key: state.pageKey,
//                   child: child,
//                   transitionDuration: transitionInfo.duration,
//                   transitionsBuilder:
//                       (context, animation, secondaryAnimation, child) =>
//                           PageTransition(
//                     type: transitionInfo.transitionType,
//                     duration: transitionInfo.duration,
//                     reverseDuration: transitionInfo.duration,
//                     alignment: transitionInfo.alignment,
//                     child: child,
//                   ).buildTransitions(
//                     context,
//                     animation,
//                     secondaryAnimation,
//                     child,
//                   ),
//                 )
//               : MaterialPage(key: state.pageKey, child: child);
//         },
//         routes: routes,
//       );
// }
//
// class TransitionInfo {
//   const TransitionInfo({
//     required this.hasTransition,
//     this.transitionType = PageTransitionType.fade,
//     this.duration = const Duration(milliseconds: 300),
//     this.alignment,
//   });
//
//   final bool hasTransition;
//   final PageTransitionType transitionType;
//   final Duration duration;
//   final Alignment? alignment;
//
//   static TransitionInfo appDefault() =>
//       const TransitionInfo(hasTransition: false);
// }
//
// class RootPageContext {
//   const RootPageContext(this.isRootPage, [this.errorRoute]);
//
//   final bool isRootPage;
//   final String? errorRoute;
//
//   static bool isInactiveRootPage(BuildContext context) {
//     final rootPageContext = context.read<RootPageContext?>();
//     final isRootPage = rootPageContext?.isRootPage ?? false;
//     final location = GoRouterState.of(context).path.toString();
//     return isRootPage &&
//         location != '/' &&
//         location != rootPageContext?.errorRoute;
//   }
//
//   static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
//         value: RootPageContext(true, errorRoute),
//         child: child,
//       );
// }
//
// extension GoRouterLocationExtension on GoRouter {
//   String getCurrentLocation() {
//     final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
//     final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
//         ? lastMatch.matches
//         : routerDelegate.currentConfiguration;
//     return matchList.toString();
//   }
// }
