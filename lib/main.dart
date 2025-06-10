import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/features/auth/domain/auth_logic_repository.dart';
import 'core/features/auth/presentation/bloc/auth_bloc.dart';
import 'core/features/splash/splash_screen.dart';
import 'core/shared_storage_services/storage_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final token = await StorageService().getToken();

  runApp(MyApp(initialToken: token));
}

class MyApp extends StatelessWidget {
  final String? initialToken;

  const MyApp({super.key,this.initialToken});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => AuthBloc(AuthRepository()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(initialToken: initialToken),
      ),
    );
  }
}
