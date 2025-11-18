import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Live Score"),
      ),
      body: ListView.builder(itemBuilder: (context, index){
        return ListTile(
          leading: CircleAvatar(backgroundColor: Colors.green, radius: 8,),
          title: Text("Bangladesh vs India"),
          trailing: Text("12-12"),
          subtitle: Text("Winner: "),
        );
      }),
    );
  }
}
