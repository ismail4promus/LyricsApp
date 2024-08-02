import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'screens/lyrics_list_screen.dart';
import 'providers/lyrics_provider.dart';
import 'utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(LyricsApp());
}

class LyricsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LyricsProvider(),
      child: MaterialApp(
        title: 'Lyrics App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: kBackgroundColor,
          fontFamily: 'AnekBangla',
          appBarTheme: AppBarTheme(
            backgroundColor: kPrimaryColor,
            elevation: 0,
          ),
          cardTheme: CardTheme(
            shape: kCardShape,
            elevation: kCardElevation,
            margin: kCardMargin,
          ),
        ),
        home: LyricsListScreen(),
      ),
    );
  }
}
