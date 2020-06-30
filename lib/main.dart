// adapted from: https://www.youtube.com/watch?v=0HLt1TYA600

import 'package:flutter/material.dart';
import 'package:macrobaseapp/app/services/macro_notifier.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'app/services/firebase_auth_service.dart';
import 'app/services/macro_notifier.dart';

void main() => runApp(
  /// Inject the [FirebaseAuthService]
  /// and provide a stream of [User]
  ///
  /// This needs to be above [MaterialApp]
  /// At the top of the widget tree, to
  /// accomodate for navigations in the app
  MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => MacroNotifier(),
      ),
      Provider(
        create: (_) => FirebaseAuthService(),
      ),
      StreamProvider(
        create: (context) =>
          context.read<FirebaseAuthService>().onAuthStateChanged,
      ),
    ],
    child: MyApp(),
  ),
);

