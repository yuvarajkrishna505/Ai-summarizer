

import 'package:ai/login.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://wsikoxnbgmcnlugcosor.supabase.co",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndzaWtveG5iZ21jbmx1Z2Nvc29yIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTY1NjUyMTgsImV4cCI6MjA3MjE0MTIxOH0.70L710LML-xDoPfFR_D94lHwJeSDLi3mg9khZl1HCiQ",
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login()
    );
  }
}
