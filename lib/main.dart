import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sticker_app/data/repositories/sticker_pack_repository_impl.dart';
import 'package:sticker_app/domain/repositories/sticker_pack_repository.dart';
import 'package:sticker_app/presentation/screens/home_screen.dart';
import 'package:sticker_app/presentation/screens/sticker_pack_details_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<StickerPackRepository>(
      create: (context) => StickerPackRepositoryImpl(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,
        ),
        initialRoute: '/',
        routes: {
          "/": (context) => const HomeScreen(),
          '/sticker-details': (context) => StickerPackDetailsScreen(
            packId: ModalRoute.of(context)!.settings.arguments as String,
          ),
        },
      ),
    );
  }
}
