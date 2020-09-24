import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_test_project/connection.dart';
import 'package:flutter_test_project/context_navigator.dart';
import 'package:flutter_test_project/dialogs/dialog_actions.dart';
import 'package:flutter_test_project/views/browser/browser_view.dart';
import 'package:flutter_test_project/views/todo_view.dart';

import 'controllers/todo_view_controller.dart';
import 'slot_machine_provider.dart';

import 'dialogs/custom_dialog.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => SlotMachineProvider(),
        ),
      ],
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(title: 'Todo List'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TodoViewController controller = new TodoViewController();

  @override
  void initState() {
    super.initState();
    this.checkInternet();
  }

  void checkInternet() {
    Connection.isConnectedToInternet().then(
      (isConnected) => {
        print('isConnected: $isConnected'),
        if (!isConnected)
          {
            print('Please connect to the internet'),
            this.showDialogConnectToInternet(
                'It is advised to connect you device to the internet in order to use this application'),
          }
      },
    );
  }

  showDialogConnectToInternet(textAlert) async {
    showDialog(
      context: context,
      child: CustomDialog(
        title: "Internet",
        message: textAlert,
        icon: Icons.wifi,
        actions: <DialogAction, Function()>{
          DialogAction.LATER: () {
            print('Tapped later');
            Navigator.of(context).pop(false);
          },
          DialogAction.OKAY: () async {
            print('Tapped okay');
            Navigator.of(context).pop(true);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
            icon: Icon(Icons.search),
            onPressed: () => ContextNavigator.push(context, BrowserView())),
      ),
      body: TodoView(controller: controller),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => controller.addTodo(),
        label: Text('Add todo'),
        icon: Icon(Icons.add),
      ),
    );
  }
}