import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meu_patrimonio/core/themes/themes.dart';
import 'package:meu_patrimonio/presentation/pages/home_page.dart';
import 'package:dynamic_color/dynamic_color.dart';

class AppWidget extends ConsumerWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DynamicColorBuilder(
      builder: (lightColorScheme, darkColorScheme) {
        return MaterialApp(
          title: 'Finanças pessoais',
          theme: getLightTheme(lightColorScheme),
          darkTheme: getDarkTheme(darkColorScheme),
          home: HomePage(),
        );
      },
    );
  }
}

// class AppWidget2 extends StatelessWidget {
//   const AppWidget2({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Modular.setInitialRoute('/home/');
//     // final appStore = context.watch<AppStore>(
//     //   (store) => store.themeMode,
//     // );

//     return DynamicColorBuilder(
//       builder: (lightColorScheme, darkColorScheme) {
//         return MaterialApp.router(
//           title: 'Flutter Demo',
//           theme: getLightTheme(lightColorScheme),
//           darkTheme: getDartTheme(darkColorScheme),
//           routerDelegate: Modular.routerDelegate,
//           routeInformationParser: Modular.routeInformationParser,
//         );
//       },
//     );
//   }
// }
