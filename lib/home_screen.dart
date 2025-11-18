import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<FootballMatch> _matchList = [];
  bool _inProgress = false;

  @override
  void initState() {
    _getFootballMatch();
    super.initState();
  }

  Future<void> _getFootballMatch() async {
    _inProgress = true;
    setState(() {

    });
    _matchList.clear();
    final snapshots = await FirebaseFirestore.instance
        .collection('football')
        .get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> docs in snapshots.docs) {
      _matchList.add(FootballMatch(
        id: docs.id,
        team1: docs.get('team1_name'),
        team1Score: docs.get('team1_score'),
        team2: docs.get('team2_name'),
        team2Score: docs.get('team2_score'),
        isRunning: docs.get('is_running'),
        winner: docs.get('winner_team'),
      ));

      print(docs.id);
      print(docs.data());
    }
    _inProgress = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Live Score")),
      body: Visibility(
        visible: _inProgress == false,
        replacement: Center(child: CircularProgressIndicator()),
        child: ListView.builder(
          itemCount: _matchList.length,
          itemBuilder: (context, index) {
            final football_match = _matchList[index];
            return ListTile(
              leading: CircleAvatar(backgroundColor: football_match.isRunning ? Colors.green : Colors.grey, radius: 8),
              title: Text('${football_match.team1} VS ${football_match.team2}'),
              trailing: Text('${football_match.team1Score} - ${football_match.team2Score}'),
              subtitle: Text("Winner: ${football_match.isRunning ? 'Pending' : football_match.winner}"),
            );
          },
        ),
      ),
    );
  }
}

class FootballMatch {
  final String id;
  final String team1;
  final int team1Score;
  final String team2;
  final int team2Score;
  final bool isRunning;
  final String winner;

  FootballMatch({
    required this.id,
    required this.team1,
    required this.team1Score,
    required this.team2,
    required this.team2Score,
    required this.isRunning,
    required this.winner,
  });
}
