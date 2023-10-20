import 'package:flutter/material.dart';
import 'package:gym_h/widget/consejos.dart';

class TabBarH extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Widget> _tabs = [
      Tab(text: 'Rutina'),
      Tab(text: 'Musculos'),
      Tab(text: 'Lista'),
      Tab(text: 'Historial'),

    ];

    final PreferredSizeWidget appBar = PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: Container(
        color: Colors.blue,
        child: TabBar(
          tabs: _tabs,
        ),
      ),
    );

    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: appBar,
        body: TabBarView(
          children: [
            Center(child: Text('Rutina de hoy:')),
            Center(child: Text('Contenido de Tab 2')),
            Center(child: Text('Contenido de Tab 2')),
            Center(child: Text('Historial')),
          ],
        ),
      ),
    );
  }
}
