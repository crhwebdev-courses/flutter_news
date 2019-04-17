import 'package:flutter/material.dart';
import 'dart:async';

class NewsList extends StatelessWidget {
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top News'),
      ),
      body: buildList(),
    );
  }

  //use ListView.builder to render items to screen only if they are visible
  // FutureBuilder will resolve each future it recieves as it recieves it
  Widget buildList() {
    return ListView.builder(
      itemCount: 1000,
      itemBuilder: (context, index) {
        return FutureBuilder(
          future: getFuture(),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Text('I\'m visible $index')
                : Text('I haven\'t fetched data yet');
          },
        );
      },
    );
  }

  Future getFuture() {
    return Future.delayed(
      Duration(seconds: 2),
      () => 'hi',
    );
  }
}
