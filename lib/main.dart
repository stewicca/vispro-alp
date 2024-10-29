import 'package:alp/screens/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'blocs/sign_in/sign_in_bloc.dart';
import 'data/repositories/auth_repository.dart';
import 'screens/sign_in/sign_in_page.dart';

void main() {
  final dio = Dio();
  final authRepository = AuthRepository(dio);

  runApp(MyApp(authRepository: authRepository));
}

class AppRoutes {
  static const String signIn = '/';
  static const String home = '/home';
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;

  const MyApp({super.key, required this.authRepository});

  Future<String> getInitialPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('token') != null) {
      return AppRoutes.home;
    }
    return AppRoutes.signIn;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ALP',
      home: FutureBuilder<String>(
        future: getInitialPage(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading initial page'));
          } else {
            return Navigator(
              initialRoute: snapshot.data,
              onGenerateRoute: (RouteSettings settings) {
                switch (settings.name) {
                  case AppRoutes.home:
                    return MaterialPageRoute(
                      builder: (context) => const HomePage(title: "Home Page"),
                    );
                  case AppRoutes.signIn:
                    return MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => SignInBloc(authRepository),
                        child: SignInPage(),
                      ),
                    );
                  default:
                    return null; // Handle unknown routes
                }
              },
            );
          }
        },
      ),
    );
  }
}
