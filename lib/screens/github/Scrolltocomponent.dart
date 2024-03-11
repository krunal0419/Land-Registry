import 'package:flutter/material.dart';

class ScrollToComponentExample extends StatefulWidget {
  @override
  _ScrollToComponentExampleState createState() => _ScrollToComponentExampleState();
}

class _ScrollToComponentExampleState extends State<ScrollToComponentExample> {
  final ScrollController _scrollController = ScrollController();
  GlobalKey _componentKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scroll To Component Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                final context = _componentKey.currentContext;
                if (context != null) {
                  _scrollController.animateTo(
                    context.size?.height ?? 0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: Text('Scroll to Component'),
            ),
            Expanded(
              child: ListView(
                controller: _scrollController,
                children: [
                  Container(
                    height: 1000,
                    color: Colors.blue,
                    child: Center(
                      child: Text('Top Component'),
                    ),
                  ),
                  Container(
                    key: _componentKey,
                    height: 1000,
                    color: Colors.green,
                    child: Center(
                      child: Text('Scroll To Component'),
                    ),
                  ),
                  Container(
                    height: 1000,
                    color: Colors.red,
                    child: Center(
                      child: Text('Bottom Component'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
