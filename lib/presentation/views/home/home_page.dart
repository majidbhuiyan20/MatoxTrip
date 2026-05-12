import 'package:flutter/material.dart';
import '../../widgets/common/navbar_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          NavbarWidget(),
          Expanded(
            child: Center(
              child: Text('Home Page Content'),
            ),
          ),
        ],
      ),
    );
  }
}
