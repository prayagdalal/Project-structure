import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:opx_certification/core/shared_pref.dart';
import 'package:opx_certification/design/app_colors.dart';
import 'package:opx_certification/features/create_certificate/bloc/certificate_bloc.dart';
import 'package:opx_certification/features/home/bloc/home_bloc.dart';
import 'package:opx_certification/features/onboarding/presentation/onboarding_page.dart';
import 'package:opx_certification/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:opx_certification/utills/bottom_app_bar/bottom_app_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  String? token = SharedPref.getToken();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CertificateBloc>(
          create: (BuildContext context) => CertificateBloc(),
        ),
        BlocProvider<HomeBloc>(
          create: (BuildContext context) => HomeBloc(),
        )
      ],
      child: GlobalLoaderOverlay(
        overlayColor: Colors.transparent,
        useDefaultLoading: false,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          supportedLocales: L10n.all,
          locale: const Locale('en'),
          theme: ThemeData(
              splashColor: Colors.transparent,
              colorSchemeSeed: const Color(0xff6750a4),
              useMaterial3: true,
              dialogBackgroundColor: Colors.white),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          home: token != null ? BottomNavAppBar() : OnboardingPage(),
        ),
      ),
    );
  }
}
