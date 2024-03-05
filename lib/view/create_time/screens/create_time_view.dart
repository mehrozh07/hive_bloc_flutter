import 'package:flutter/material.dart';

class CreateTimeView extends StatelessWidget {
  const CreateTimeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: (){},
            child: const Text('change theme'),
          )
        ],
      ),
    );
  }
}
