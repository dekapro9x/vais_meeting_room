import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    print('Initializing HomeScreen');
  }

  @override
  void dispose() {
    print('Disposing HomeScreen');
    super.dispose();
  }

  Future<Widget> renderBody() async {
    await Future.delayed(Duration(seconds: 2));
    return Container(
      child: const Text("This is the body"),
    );
  }

  Widget renderBodyNew() {
    return Container(
      child: Text("This is the body"),
    );
  }

  Widget renderBodyDemo() {
    return const Center(
      child: Text(
        'Xin chào đến với nhà phát triển ứng dụng!',
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }

  Widget renderBottomDemo() {
    return const Center(
      child: Text(
        'Xin chào đến với nhà phát triển ứng dụng!',
        style: TextStyle(fontSize: 24.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Version App Develop'),
      ),
      body: renderBodyDemo(),
      bottomNavigationBar: renderBottomDemo(),
    );
  }
}
