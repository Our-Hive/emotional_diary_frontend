import 'package:emotional_app/features/history/ui/screens/history_all_view.dart';
import 'package:emotional_app/features/history/ui/screens/history_diary_view.dart';
import 'package:emotional_app/features/history/ui/screens/history_trascendental_view.dart';
import 'package:flutter/material.dart';

class HistoryLayout extends StatelessWidget {
  const HistoryLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Historial'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                child: Text(
                  'Completo',
                ),
              ),
              Tab(
                child: Text(
                  'Emoción Diaria',
                  softWrap: true,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
              Tab(
                child: Text(
                  'Emoción Trascendental',
                  softWrap: true,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            HistoryAllView(),
            HistoryDiaryView(),
            HistoryTrascendentalView(),
          ],
        ),
      ),
    );
  }
}
