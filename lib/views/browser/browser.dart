import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test_project/context_navigator.dart';
import 'package:flutter_test_project/views/browser/top_links.dart';
import 'package:flutter_test_project/views/compute_test.dart';
import 'package:flutter_test_project/views/dashboard/dashboard.dart';
import 'package:flutter_test_project/views/slot_machine/slot_machine.dart';

import 'link_highlights.dart';

class Browser extends StatefulWidget {

  @override
  State<Browser> createState() => BrowserState();
}

TextEditingController _textEditingController = new TextEditingController();

class BrowserState extends State<Browser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Browser Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.money),
            onPressed: () => ContextNavigator.push(context, SlotMachine()),
          ),
          IconButton(
            icon: Icon(Icons.dashboard),
            onPressed: () => ContextNavigator.push(context, Dashboard()),
          ),
          IconButton(
            icon: Icon(Icons.wifi),
            onPressed: () => ContextNavigator.push(context, ComputeTest()),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                child: TextField(
                  controller: _textEditingController,
                  onSubmitted: (value) => null,
                  decoration: InputDecoration(
                    hintText: 'Search the Web',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 5.0),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              TopLinks(topLinkUrls: 'lib/assets/youtube.jpg'),
              Divider(height: 10.0),
              LinkHighLights(highLightUrls: 'lib/assets/youtube.jpg'),
            ],
          ),
        ),
      ),
    );
  }
}
