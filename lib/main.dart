import 'package:flutter/material.dart';
import 'package:portfolio_creator/app/myapp.dart';
import 'package:portfolio_creator/provider/profile_data_provider.dart';
import 'package:portfolio_creator/provider/set_profile_data.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SetProfileDataProvider()),
        ChangeNotifierProvider(create: (_) => ProfileDataProvider()),
      ],
      child: MyApp(),
    ),
  );
}
