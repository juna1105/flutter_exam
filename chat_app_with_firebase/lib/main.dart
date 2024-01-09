import 'package:chat_app_with_firebase/pallet/pallet.dart';
import 'package:chat_app_with_firebase/screens/chat_screens/chat_screens.dart';
import 'package:chat_app_with_firebase/screens/sign_in_and_up_scrren.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  // 앱 실행 이전에 초기화해야되는 메서드가 있을 때 그것을 허용해주는 메서드
  WidgetsFlutterBinding.ensureInitialized();
  // firebase 앱 사용을 위한 초기화 메서드
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Palette.backgroundColor,
        // 유저 로그인 상태 추적을 위한 스트림빌더
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // 로그인 후 페이지
              return const ChatScreen();
            }
            // 로그인을 위한 페이지
            return const SignInAndUpScreen();
          },
        ),
      ),
      theme: ThemeData(
        primarySwatch: Colors.red,
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
          displayMedium: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
