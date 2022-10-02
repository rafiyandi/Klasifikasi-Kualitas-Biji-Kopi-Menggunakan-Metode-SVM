import 'package:flutter_modular/flutter_modular.dart';
import 'package:kopi/ui/pages/main/main_page.dart';
import 'package:kopi/ui/pages/onboarding/onboarding_page.dart';
import 'package:kopi/ui/pages/splash/splash_page.dart';

class AppModule extends Module {
  bool showHome;
  AppModule(this.showHome);
  List<ModularRoute> get routes => [
        ChildRoute(Modular.initialRoute,
            child: (context, args) => SplashPage()),
        ChildRoute("/main",
            duration: Duration(seconds: 1),
            transition: TransitionType.leftToRight,
            child: (_, __) => showHome ? OnBoardingPage() : MainPage())
      ];
}
