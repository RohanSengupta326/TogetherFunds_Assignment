import 'repository/together_repository.dart';
import 'weather/cubit/together_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_routes.dart';

void main() {
  runApp(MyWeatherApp());
}

class MyWeatherApp extends StatelessWidget {
  final AppRoutes appRoutes = AppRoutes();

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TogetherRepository(),
      // for one instance of repository to be maintained throughout the widget tree
      // whereever in the widget tree this repo will be needed to call functions from or something,
      // here at the top , we will provide this single instance of WeatherRepository
      // to all the BlocProviders, so that one instance is used not multiple.
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TogetherCubit>(
            create: (ctx) => TogetherCubit(
              togetherRepository: ctx.read<TogetherRepository>(),
              // sending already created instance of repository.
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            appBarTheme: AppBarTheme(
              iconTheme: IconThemeData(color: Colors.white),
              backgroundColor: Colors.green[300],
              titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            primaryColor: Colors.green[200],
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 106, 208, 114),
            ),
          ),
          onGenerateRoute: appRoutes.onGeneratedRoute,
        ),
      ),
    );
  }
}
