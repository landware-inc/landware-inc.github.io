import 'package:flutter/material.dart';

class CommecialScreen extends StatelessWidget {
  const CommecialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('상업용 부동산'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
            child: Text(
                '상업용 부동산',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
            ),
        ),
      ),
    );
  }
}
