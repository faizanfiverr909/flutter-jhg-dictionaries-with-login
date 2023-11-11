import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_guitar/guitar_play/presentation/views/guitar_play_screen.dart';
import 'package:flutter_guitar/router/router.dart';
import 'package:flutter_guitar/utils/color_constants.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reg_page/reg_page.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  runApp(
    const ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MaterialApp(
      theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: ColorConstants.secondary,
              background: ColorConstants.primary,
              onBackground: ColorConstants.primary,
              secondary: ColorConstants.secondary,
              onSecondary: ColorConstants.secondary,
            ),
            useMaterial3: true,
            textTheme: GoogleFonts.plusJakartaSansTextTheme(),
      ),
      home: SplashScreen(
        yearlySubscriptionId: "",
        monthlySubscriptionId: "",
        nextPage: () => const GuitarPlayScreen(),
      ),
    ); //); } }

    // return MaterialApp.router(
    //   title: 'Flutter Demo',
    //   routerConfig: router,
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSeed(
    //       seedColor: ColorConstants.secondary,
    //       background: ColorConstants.primary,
    //       onBackground: ColorConstants.primary,
    //       secondary: ColorConstants.secondary,
    //       onSecondary: ColorConstants.secondary,
    //     ),
    //     useMaterial3: true,
    //     textTheme: GoogleFonts.plusJakartaSansTextTheme(),
    //   ),
    // );
  }
}
