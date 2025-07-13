import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickservice/Navigation/mainPage.dart';
import 'package:quickservice/bloc/mainPageCubit.dart';
import 'package:quickservice/bloc/themeCubit.dart';
import 'package:quickservice/auth/auth.dart';
import 'package:quickservice/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<Themecubit>(
          create: (_) => Themecubit(),
        ),
        BlocProvider<Mainpagecubit>(
          create: (_) => Mainpagecubit(),
          child: Mainpage(),
        )
        // Add more BlocProviders here in future
      ],
      child: BlocBuilder<Themecubit, ThemeData>(
        builder: (context, theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme,
            home: const AuthPage(),
          );
        },
      ),
    );
  }
}
