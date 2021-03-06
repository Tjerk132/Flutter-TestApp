import 'package:flutter/material.dart';
import 'package:flutter_test_project/providers/slot_machine_provider.dart';
import 'package:provider/provider.dart';

import 'package:flutter_test_project/views/slot_machine/slot_machine_slot.dart';

class SlotMachine extends StatefulWidget {
  @override
  _SlotMachineState createState() => _SlotMachineState();
}

class _SlotMachineState extends State<SlotMachine> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Size slotsSize = new Size(size.width * 0.9, size.height * 0.6);
    return Scaffold(
      appBar: AppBar(
        title: Text('Slot machine'),
      ),
      body: Container(
        color: Colors.red[800],
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Text(
                'Slot machine spinner',
                style: TextStyle(fontSize: 30.0, color: Colors.white),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Container(
                    width: slotsSize.width,
                    height: slotsSize.height,
                    child: Row(
                      children: <Widget>[
                        SlotMachineSlot(
                            size: slotsSize,
                            scrollable: false,
                            offAxisFraction: -1.5),
                        SlotMachineSlot(
                            size: slotsSize,
                            scrollable: false,
                            offAxisFraction: 0.0),
                        SlotMachineSlot(
                            size: slotsSize,
                            scrollable: false,
                            offAxisFraction: 1.5),
                      ],
                    ),
                    decoration: BoxDecoration(
//            color: Colors.pink,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      ],
                      color: Colors.red,
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                RaisedButton(
                  onPressed: () => context.read<SlotMachineProvider>().onSpin(),
                  textColor: Colors.white,
                  padding: EdgeInsets.all(0.0),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Colors.red[400],
                          Colors.red[500],
                          Colors.red[600],
                        ],
                      ),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 45.0, horizontal: 150.0),
                    child: Text(
                      'Spin!',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
