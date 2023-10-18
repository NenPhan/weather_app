import 'package:weather_app/src/app/features/home/pages/home_page.dart';
import 'package:weather_app/src/app/features/splash/splash_page.dart';
import 'package:weather_app/src/app/widgets/loading_page.dart';

get appRoutes => {
      '/': (context) => const LoadingPage(),
      const SplashPage().route: (context) => const SplashPage(),
      HomePage.route: (context) => const HomePage(),
    };
