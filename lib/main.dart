import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:social_app/features/auth/presentation/presentation_layer.dart';
import 'package:social_app/features/auth/domain/domain_layer.dart';
import 'features/auth/data/data_layer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepositoryImp(
            AuthRemoteDataSource(
                FirebaseAuth.instance, FirebaseFirestore.instance),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(
              context.read<AuthRepositoryImp>(),
            ),
          ),
        ],
        child: MaterialApp(
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: LoginScreen(),
        ),
      ),
    );
  }
}
