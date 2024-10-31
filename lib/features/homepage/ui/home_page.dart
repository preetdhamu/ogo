import 'package:flutter/material.dart';
import 'package:ogo/features/authentication/providers/auth_service_provider.dart';
import 'package:ogo/shared/widgets/custom_header.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthServiceProvider>(builder: (context, provider, _) {
      return Column(
        children: [
          const Oheader(text: "User Registerd Successfully "),
          Oheader(text: " ${provider.getCurrentUser()}"),
        ],
      );
    });
  }
}
